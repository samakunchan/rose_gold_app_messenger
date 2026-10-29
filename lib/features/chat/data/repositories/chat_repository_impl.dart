import 'dart:async';
import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/chat/data/datasources/chat_crypto_data_source.dart';
import 'package:rose_gold_app_messenger/features/chat/data/datasources/chat_local_data_source.dart';
import 'package:rose_gold_app_messenger/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:rose_gold_app_messenger/features/chat/data/models/message_model.dart';
import 'package:rose_gold_app_messenger/features/chat/data/models/user_public_key_model.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/encrypted_media_attachment.dart';
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

  Future<SecretKey> _getOrEnsureRoomKey({
    required String userId,
    required String roomId,
    String? peerPublicKeyBase64,
  }) async {
    // 1. Vérifier si la clé de salon est déjà en cache mémoire ou local
    final SecretKey? localKey = await cryptoDataSource.getRoomKey(roomId: roomId);
    if (localKey != null) {
      unawaited(_syncMissingRoomKeys(userId: userId, roomId: roomId, roomKey: localKey));
      return localKey;
    }

    // 2. Tenter de récupérer la clé chiffrée pour cet utilisateur depuis Supabase
    final Map<String, dynamic>? keyRow = await remoteDataSource.getRoomKeyForUser(
      roomId: roomId,
      userId: userId,
    );

    if (keyRow != null) {
      final String encryptedKey = keyRow['encrypted_key'] as String;
      final String nonce = keyRow['nonce'] as String;
      final String senderId = keyRow['sender_id'] as String;

      final String senderPubKey = senderId == userId
          ? await cryptoDataSource.getPublicKeyBase64(userId: userId)
          : (await remoteDataSource.getPeerPublicKey(userId: senderId))?.publicKey ?? '';

      if (senderPubKey.isNotEmpty) {
        final SecretKey pairwiseKey = await cryptoDataSource.deriveSharedKey(
          userId: userId,
          peerPublicKeyBase64: senderPubKey,
          roomId: roomId,
        );

        final SecretKey roomKey = await cryptoDataSource.decryptRoomKey(
          encryptedKeyBase64: encryptedKey,
          nonceBase64: nonce,
          pairwiseKey: pairwiseKey,
          roomId: roomId,
        );

        unawaited(_syncMissingRoomKeys(userId: userId, roomId: roomId, roomKey: roomKey));
        return roomKey;
      }
    }

    // 3. Aucune clé existante trouvée : générer une clé de salon et la distribuer à tous les membres
    final SecretKey newRoomKey = await cryptoDataSource.generateAndStoreRoomKey(roomId: roomId);
    await _distributeRoomKey(userId: userId, roomId: roomId, roomKey: newRoomKey);
    return newRoomKey;
  }

  Future<void> _distributeRoomKey({
    required String userId,
    required String roomId,
    required SecretKey roomKey,
  }) async {
    try {
      final Map<String, String> membersPublicKeys = await remoteDataSource.getRoomMembersPublicKeys(roomId: roomId);
      if (!membersPublicKeys.containsKey(userId)) {
        final String myKey = await cryptoDataSource.getPublicKeyBase64(userId: userId);
        membersPublicKeys[userId] = myKey;
      }

      final List<Map<String, dynamic>> rowsToUpsert = <Map<String, dynamic>>[];
      for (final MapEntry<String, String> entry in membersPublicKeys.entries) {
        final String memberId = entry.key;
        final String memberPubKey = entry.value;

        final SecretKey pairwiseKey = await cryptoDataSource.deriveSharedKey(
          userId: userId,
          peerPublicKeyBase64: memberPubKey,
          roomId: roomId,
        );

        final ({String encryptedKey, String nonce}) encrypted = await cryptoDataSource.encryptRoomKey(
          roomKey: roomKey,
          pairwiseKey: pairwiseKey,
        );

        rowsToUpsert.add(<String, dynamic>{
          'room_id': roomId,
          'user_id': memberId,
          'sender_id': userId,
          'encrypted_key': encrypted.encryptedKey,
          'nonce': encrypted.nonce,
        });
      }

      if (rowsToUpsert.isNotEmpty) {
        await remoteDataSource.saveRoomKeys(roomKeys: rowsToUpsert);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Erreur _distributeRoomKey: $e');
      }
    }
  }

  Future<void> _syncMissingRoomKeys({
    required String userId,
    required String roomId,
    required SecretKey roomKey,
  }) async {
    try {
      final List<String> existingUserIds = await remoteDataSource.getExistingRoomKeyUserIds(roomId: roomId);
      final Map<String, String> allMembers = await remoteDataSource.getRoomMembersPublicKeys(roomId: roomId);

      final List<Map<String, dynamic>> missingRows = <Map<String, dynamic>>[];
      for (final MapEntry<String, String> entry in allMembers.entries) {
        if (!existingUserIds.contains(entry.key)) {
          final SecretKey pairwiseKey = await cryptoDataSource.deriveSharedKey(
            userId: userId,
            peerPublicKeyBase64: entry.value,
            roomId: roomId,
          );

          final ({String encryptedKey, String nonce}) encrypted = await cryptoDataSource.encryptRoomKey(
            roomKey: roomKey,
            pairwiseKey: pairwiseKey,
          );

          missingRows.add(<String, dynamic>{
            'room_id': roomId,
            'user_id': entry.key,
            'sender_id': userId,
            'encrypted_key': encrypted.encryptedKey,
            'nonce': encrypted.nonce,
          });
        }
      }

      if (missingRows.isNotEmpty) {
        await remoteDataSource.saveRoomKeys(roomKeys: missingRows);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Erreur _syncMissingRoomKeys: $e');
      }
    }
  }

  @override
  Future<Either<Failure, MessageEntity>> sendEncryptedMessage({required SendEncryptedMessageParams params}) async {
    try {
      final String userId = _currentUserId;

      final SecretKey secretKey = await _getOrEnsureRoomKey(
        userId: userId,
        roomId: params.roomId,
        peerPublicKeyBase64: params.peerPublicKeyBase64,
      );

      EncryptedMediaAttachment? attachment;
      String payloadToEncrypt = params.plainText;

      // 1. Chiffrement hybride du fichier média si présent
      if (params.mediaBytes != null && params.mediaBytes!.isNotEmpty) {
        final String fileExtension = params.mediaFileName?.split('.').last ?? 'bin';
        final ({Uint8List encryptedBytes, String fileKeyBase64, String nonceBase64}) mediaEncrypted = await cryptoDataSource.encryptMediaFile(
          params.mediaBytes!,
        );

        final String storagePath = await remoteDataSource.uploadEncryptedMedia(
          encryptedBytes: mediaEncrypted.encryptedBytes,
          fileExtension: fileExtension,
        );

        attachment = EncryptedMediaAttachment(
          storagePath: storagePath,
          fileKeyBase64: mediaEncrypted.fileKeyBase64,
          nonceBase64: mediaEncrypted.nonceBase64,
          fileName: params.mediaFileName ?? 'attachment.$fileExtension',
          fileSize: params.mediaBytes!.length,
          mimeType: params.mediaMimeType ?? 'application/octet-stream',
        );

        payloadToEncrypt = jsonEncode(<String, dynamic>{
          'text': params.plainText,
          'attachment': attachment.toJson(),
        });
      }

      // 2. Chiffrement E2EE de l'enveloppe
      final ({String ciphertext, String fingerprint, String nonce}) encrypted = await cryptoDataSource.encrypt(
        userId: userId,
        plainText: payloadToEncrypt,
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
        attachment: attachment,
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

        // 3. Obtenir la clé de salon (Option 1 - Clé partagée E2EE)
        SecretKey? roomKey;
        try {
          roomKey = await _getOrEnsureRoomKey(
            userId: userId,
            roomId: params.roomId,
            peerPublicKeyBase64: params.peerPublicKeyBase64,
          );
        } on Exception catch (e) {
          if (kDebugMode) {
            print('Erreur récupération roomKey: $e');
          }
        }

        // 4. Dériver les SecretKeys bilatérales correspondantes (Rétrocompatibilité)
        final List<SecretKey> candidateSecretKeys = <SecretKey>[];
        for (final String peerKey in candidatePeerKeys) {
          final SecretKey sk = await cryptoDataSource.deriveSharedKey(
            userId: userId,
            peerPublicKeyBase64: peerKey,
            roomId: params.roomId,
          );
          candidateSecretKeys.add(sk);
        }

        // 5. Déchiffrer chaque message
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

          String? decryptedPayload;

          // Essai 1 : Déchiffrement direct avec la clé de salon (Room Key)
          if (roomKey != null) {
            try {
              decryptedPayload = await cryptoDataSource.decrypt(
                ciphertextBase64: model.ciphertext,
                nonceBase64: model.nonce,
                secretKey: roomKey,
              );
            } on Exception {
              // Si échec (ex: ancien message d'avant la migration), tenter les clés bilatérales ci-dessous
            }
          }

          // Essai 2 : Rétrocompatibilité avec les clés bilatérales candidates
          if (decryptedPayload == null) {
            for (final SecretKey sk in candidateSecretKeys) {
              try {
                decryptedPayload = await cryptoDataSource.decrypt(
                  ciphertextBase64: model.ciphertext,
                  nonceBase64: model.nonce,
                  secretKey: sk,
                );
                break;
              } on Exception {
                // Échec normal pour une mauvaise clé : continuer vers la clé candidate suivante
              }
            }
          }

          final bool isSuccess = decryptedPayload != null;
          String finalText = isSuccess ? decryptedPayload : '🔒 [Message chiffré indéchiffrable]';
          EncryptedMediaAttachment? attachment;

          if (isSuccess) {
            try {
              final dynamic decoded = jsonDecode(decryptedPayload);
              if (decoded is Map<String, dynamic> && decoded.containsKey('attachment')) {
                final dynamic textVal = decoded['text'];
                finalText = textVal is String ? textVal : '';
                final dynamic rawAttachment = decoded['attachment'];
                if (rawAttachment is Map<String, dynamic>) {
                  attachment = EncryptedMediaAttachment.fromJson(rawAttachment);
                }
              }
            } on Exception {
              // Format de message texte brut classique (rétro-compatible)
            }
          }

          final MessageEntity entity = MessageEntity(
            id: model.id,
            roomId: model.roomId,
            senderId: model.senderId,
            decryptedContent: finalText,
            keyFingerprint: model.keyFingerprint,
            createdAt: model.createdAt,
            mediaUrl: model.mediaUrl,
            attachment: attachment,
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
  Future<Either<Failure, Uint8List>> downloadAndDecryptMedia({
    required EncryptedMediaAttachment attachment,
  }) async {
    try {
      final Uint8List encryptedBytes = await remoteDataSource.downloadEncryptedMedia(
        storagePath: attachment.storagePath,
      );
      final Uint8List decryptedBytes = await cryptoDataSource.decryptMediaFile(
        encryptedBytes: encryptedBytes,
        fileKeyBase64: attachment.fileKeyBase64,
        nonceBase64: attachment.nonceBase64,
      );
      return Right<Failure, Uint8List>(decryptedBytes);
    } on Exception catch (e, stack) {
      if (kDebugMode) {
        print('Erreur downloadAndDecryptMedia: $e\n$stack');
      }
      return const Left<Failure, Uint8List>(CryptoFailure());
    }
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
