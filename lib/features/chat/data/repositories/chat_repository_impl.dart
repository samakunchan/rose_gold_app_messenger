import 'dart:async';

import 'package:cryptography/cryptography.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/chat/data/datasources/chat_crypto_data_source.dart';
import 'package:rose_gold_app_messenger/features/chat/data/datasources/chat_local_data_source.dart';
import 'package:rose_gold_app_messenger/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:rose_gold_app_messenger/features/chat/data/models/message_model.dart';
import 'package:rose_gold_app_messenger/features/chat/data/models/user_public_key_model.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/message_entity.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/repositories/chat_repository.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/params.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatRepositoryImpl extends ChatRepository {
  new({
    required this.remoteDataSource,
    required this.cryptoDataSource,
    required this.localDataSource,
    required this.supabaseClient,
  });

  final ChatRemoteDataSource remoteDataSource;
  final ChatCryptoDataSource cryptoDataSource;
  final ChatLocalDataSource localDataSource;
  final SupabaseClient supabaseClient;

  String get _currentUserId => supabaseClient.auth.currentUser?.id ?? '';

  @override
  Future<Either<Failure, void>> initializeAndPublishKeys() async {
    try {
      final String userId = _currentUserId;
      if (userId.isEmpty) {
        return const Right<Failure, void>(null);
      }

      await cryptoDataSource.initLocalKeys(userId: userId);
      final String publicKey = await cryptoDataSource.getPublicKeyBase64(userId: userId);
      final String fingerprint = await cryptoDataSource.getKeyFingerprint(userId: userId);

      await remoteDataSource.publishPublicKey(
        publicKey: publicKey,
        fingerprint: fingerprint,
      );

      return const Right<Failure, void>(null);
    } on Exception catch (e, stack) {
      if (kDebugMode) {
        print('Erreur initializeAndPublishKeys: $e\n$stack');
      }
      return const Left<Failure, void>(CryptoFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getLocalPublicKey() async {
    try {
      final String userId = _currentUserId;
      final String publicKey = await cryptoDataSource.getPublicKeyBase64(userId: userId);
      return Right<Failure, String>(publicKey);
    } on Exception catch (e, stack) {
      if (kDebugMode) {
        print('Erreur getLocalPublicKey: $e\n$stack');
      }
      return const Left<Failure, String>(CryptoFailure());
    }
  }

  @override
  Future<Either<Failure, String?>> getPeerPublicKey({required String userId}) async {
    try {
      final UserPublicKeyModel? model = await remoteDataSource.getPeerPublicKey(userId: userId);
      return Right<Failure, String?>(model?.publicKey);
    } on Exception catch (e, stack) {
      if (kDebugMode) {
        print('Erreur getPeerPublicKey: $e\n$stack');
      }
      return const Left<Failure, String?>(ChatFailure());
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> sendEncryptedMessage({required SendEncryptedMessageParams params}) async {
    try {
      final String userId = _currentUserId;
      final List<String> activePeerKeys = await remoteDataSource.getActiveRoomPeerPublicKeys(
        roomId: params.roomId,
      );

      String peerKey;
      if (params.peerPublicKeyBase64 != null) {
        peerKey = params.peerPublicKeyBase64!;
      } else if (activePeerKeys.isNotEmpty) {
        peerKey = activePeerKeys.first;
        unawaited(
          cryptoDataSource.rememberRoomPeerKey(
            userId: userId,
            roomId: params.roomId,
            peerPublicKeyBase64: peerKey,
          ),
        );
      } else {
        // Seul dans le salon : chiffrement avec sa propre clé publique
        peerKey = await cryptoDataSource.getPublicKeyBase64(userId: userId);
      }

      final SecretKey secretKey = await cryptoDataSource.deriveSharedKey(
        userId: userId,
        peerPublicKeyBase64: peerKey,
        roomId: params.roomId,
      );

      final ({String ciphertext, String fingerprint, String nonce}) encrypted = await cryptoDataSource.encrypt(
        userId: userId,
        plainText: params.plainText,
        secretKey: secretKey,
      );

      final MessageModel created = await remoteDataSource.sendMessage(
        roomId: params.roomId,
        ciphertext: encrypted.ciphertext,
        nonce: encrypted.nonce,
        fingerprint: encrypted.fingerprint,
        mediaUrl: params.mediaUrl,
      );

      final MessageEntity entity = MessageEntity(
        id: created.id,
        roomId: created.roomId,
        senderId: created.senderId,
        decryptedContent: params.plainText,
        keyFingerprint: created.keyFingerprint,
        createdAt: created.createdAt,
        mediaUrl: created.mediaUrl,
      );

      unawaited(localDataSource.saveMessage(entity));

      return Right<Failure, MessageEntity>(entity);
    } on Exception catch (e, stack) {
      if (kDebugMode) {
        print('Erreur sendEncryptedMessage: $e\n$stack');
      }
      return const Left<Failure, MessageEntity>(ChatFailure());
    }
  }

  @override
  Stream<Either<Failure, List<MessageEntity>>> getChatMessagesStream({required GetChatMessagesStreamParams params}) {
    return remoteDataSource.messagesStream(roomId: params.roomId).asyncMap((List<MessageModel> models) async {
      try {
        final String userId = _currentUserId;

        // 1. Charger le cache local Drift
        final List<MessageEntity> cachedList = await localDataSource.getRoomMessages(roomId: params.roomId);
        final Map<String, MessageEntity> cachedMap = <String, MessageEntity>{
          for (final MessageEntity m in cachedList) m.id: m,
        };

        // 2. Construire l'ensemble ordonné des clés publiques candidates pour ce salon
        final Set<String> candidatePeerKeys = <String>{};

        if (params.peerPublicKeyBase64 != null) {
          candidatePeerKeys.add(params.peerPublicKeyBase64!);
        }

        // a) Membres actifs du salon
        final List<String> activePeerKeys = await remoteDataSource.getActiveRoomPeerPublicKeys(roomId: params.roomId);
        candidatePeerKeys.addAll(activePeerKeys);

        // b) Expéditeurs des messages du salon (même ceux qui ont quitté le salon)
        final List<String> senderUserIds = models.map((MessageModel m) => m.senderId).where((String id) => id != userId).toSet().toList();
        final List<String> senderKeys = await remoteDataSource.getPublicKeysByUserIds(userIds: senderUserIds);
        candidatePeerKeys.addAll(senderKeys);

        // c) Clés mémorisées dans l'historique local du salon
        final List<String> rememberedKeys = await cryptoDataSource.getRememberedRoomPeerKeys(
          userId: userId,
          roomId: params.roomId,
        );
        candidatePeerKeys.addAll(rememberedKeys);

        // Mémoriser toutes les nouvelles clés de pairs découvertes pour ce salon
        for (final String peerKey in candidatePeerKeys) {
          unawaited(
            cryptoDataSource.rememberRoomPeerKey(
              userId: userId,
              roomId: params.roomId,
              peerPublicKeyBase64: peerKey,
            ),
          );
        }

        // d) Clé personnelle (pour les messages écrits quand on était seul)
        final String selfKey = await cryptoDataSource.getPublicKeyBase64(userId: userId);
        candidatePeerKeys.add(selfKey);

        // 3. Dériver les SecretKeys correspondantes
        final List<SecretKey> candidateSecretKeys = <SecretKey>[];
        for (final String peerKey in candidatePeerKeys) {
          final SecretKey sk = await cryptoDataSource.deriveSharedKey(
            userId: userId,
            peerPublicKeyBase64: peerKey,
            roomId: params.roomId,
          );
          candidateSecretKeys.add(sk);
        }

        // 4. Déchiffrer chaque message
        final List<MessageEntity> entities = <MessageEntity>[];
        final List<MessageEntity> newlyDecrypted = <MessageEntity>[];

        for (final MessageModel model in models) {
          // Utiliser le cache local s'il contient déjà le texte en clair
          if (cachedMap.containsKey(model.id)) {
            final MessageEntity cachedEntity = cachedMap[model.id]!;
            if (!cachedEntity.decryptedContent.contains('🔒')) {
              entities.add(cachedEntity);
              continue;
            }
          }

          String? decryptedText;
          // Tester les clés candidates
          for (final SecretKey sk in candidateSecretKeys) {
            try {
              decryptedText = await cryptoDataSource.decrypt(
                ciphertextBase64: model.ciphertext,
                nonceBase64: model.nonce,
                secretKey: sk,
              );
              break;
            } on Exception {
              // Échec normal pour une mauvaise clé : continuer vers la clé candidate suivante
            }
          }

          final bool isSuccess = decryptedText != null;
          final String finalText = isSuccess ? decryptedText : '🔒 [Message chiffré indéchiffrable]';

          final MessageEntity entity = MessageEntity(
            id: model.id,
            roomId: model.roomId,
            senderId: model.senderId,
            decryptedContent: finalText,
            keyFingerprint: model.keyFingerprint,
            createdAt: model.createdAt,
            mediaUrl: model.mediaUrl,
          );

          entities.add(entity);

          if (isSuccess) {
            newlyDecrypted.add(entity);
          }
        }

        // Sauvegarder uniquement les messages déchiffrés avec succès dans Drift
        if (newlyDecrypted.isNotEmpty) {
          unawaited(localDataSource.saveMessages(newlyDecrypted));
        }

        return Right<Failure, List<MessageEntity>>(entities);
      } on Exception catch (e, stack) {
        if (kDebugMode) {
          print('Erreur getChatMessagesStream: $e\n$stack');
        }
        return const Left<Failure, List<MessageEntity>>(ChatFailure());
      }
    });
  }

  @override
  Future<Either<Failure, List<MessageEntity>>> searchMessages({required SearchMessagesParams params}) async {
    try {
      final List<MessageEntity> results = await localDataSource.searchMessages(
        query: params.query,
        roomId: params.roomId,
      );
      return Right<Failure, List<MessageEntity>>(results);
    } on Exception catch (e, stack) {
      if (kDebugMode) {
        print('Erreur searchMessages: $e\n$stack');
      }
      return const Left<Failure, List<MessageEntity>>(ChatFailure());
    }
  }

  @override
  Future<Either<Failure, String>> getPassphrase() async {
    try {
      final String userId = _currentUserId;
      final String phrase = await cryptoDataSource.getOrGeneratePassphrase(userId: userId);
      return Right<Failure, String>(phrase);
    } on Exception catch (e, stack) {
      if (kDebugMode) {
        print('Erreur getPassphrase: $e\n$stack');
      }
      return const Left<Failure, String>(CryptoFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updatePassphrase({required String newPassphrase}) async {
    try {
      final String userId = _currentUserId;
      await cryptoDataSource.setPassphrase(userId: userId, passphrase: newPassphrase);

      final String publicKey = await cryptoDataSource.getPublicKeyBase64(userId: userId);
      final String fingerprint = await cryptoDataSource.getKeyFingerprint(userId: userId);
      await remoteDataSource.publishPublicKey(publicKey: publicKey, fingerprint: fingerprint);

      return const Right<Failure, void>(null);
    } on Exception catch (e, stack) {
      if (kDebugMode) {
        print('Erreur updatePassphrase: $e\n$stack');
      }
      return const Left<Failure, void>(CryptoFailure());
    }
  }

  @override
  Future<Either<Failure, String>> regenerateRandomPassphrase() async {
    try {
      final String userId = _currentUserId;
      final String newPhrase = await cryptoDataSource.regenerateRandomPassphrase(userId: userId);

      final String publicKey = await cryptoDataSource.getPublicKeyBase64(userId: userId);
      final String fingerprint = await cryptoDataSource.getKeyFingerprint(userId: userId);
      await remoteDataSource.publishPublicKey(publicKey: publicKey, fingerprint: fingerprint);

      return Right<Failure, String>(newPhrase);
    } on Exception catch (e, stack) {
      if (kDebugMode) {
        print('Erreur regenerateRandomPassphrase: $e\n$stack');
      }
      return const Left<Failure, String>(CryptoFailure());
    }
  }
}
