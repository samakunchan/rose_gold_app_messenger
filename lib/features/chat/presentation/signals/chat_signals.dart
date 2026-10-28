import 'dart:async';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/message_entity.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/get_chat_messages_stream_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/get_passphrase_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/initialize_e2ee_keys_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/params.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/regenerate_passphrase_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/search_messages_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/send_encrypted_message_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/update_passphrase_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/view_models/message_view_model.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:signals_flutter/signals_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChatSignals {
  new({
    required this.initKeysUseCase,
    required this.sendMessageUseCase,
    required this.getMessagesStreamUseCase,
    required this.searchMessagesUseCase,
    required this.getPassphraseUseCase,
    required this.updatePassphraseUseCase,
    required this.regeneratePassphraseUseCase,
    required this.supabaseClient,
  });

  final InitializeE2EEKeysUseCase initKeysUseCase;
  final SendEncryptedMessageUseCase sendMessageUseCase;
  final GetChatMessagesStreamUseCase getMessagesStreamUseCase;
  final SearchMessagesUseCase searchMessagesUseCase;
  final GetPassphraseUseCase getPassphraseUseCase;
  final UpdatePassphraseUseCase updatePassphraseUseCase;
  final RegeneratePassphraseUseCase regeneratePassphraseUseCase;
  final SupabaseClient supabaseClient;

  final Signal<bool> isLoading = .new(false);
  final Signal<bool> isSending = .new(false);
  final Signal<bool> isSearching = .new(false);
  final Signal<bool> isPassphraseLoading = .new(false);
  final Signal<String?> currentRoomId = .new(null);
  final Signal<String?> currentPassphrase = signal<String?>(null);
  final Signal<List<MessageViewModel>> messages = signal<List<MessageViewModel>>(<MessageViewModel>[]);
  final Signal<List<MessageViewModel>> searchResults = signal<List<MessageViewModel>>(<MessageViewModel>[]);

  StreamSubscription<Either<Failure, List<MessageEntity>>>? _messagesSubscription;

  Future<void> initializeKeys() async {
    final Either<Failure, void> result = await initKeysUseCase();
    result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print('Erreur initialisation clés E2EE: ${failure.message}');
        }
      },
      ifRight: (_) {
        if (kDebugMode) {
          print('Clés E2EE initialisées et synchronisées avec succès');
        }
      },
    );
  }

  Future<void> loadPassphrase() async {
    isPassphraseLoading.value = true;
    final Either<Failure, String> result = await getPassphraseUseCase();
    result.fold(
      ifLeft: (Failure failure) {
        isPassphraseLoading.value = false;
        if (kDebugMode) {
          print('Erreur chargement phrase secrète: ${failure.message}');
        }
      },
      ifRight: (String phrase) {
        currentPassphrase.value = phrase;
        isPassphraseLoading.value = false;
      },
    );
  }

  Future<bool> changePassphrase(String newPassphrase) async {
    isPassphraseLoading.value = true;
    final Either<Failure, void> result = await updatePassphraseUseCase(newPassphrase);
    final bool isSuccess = result.fold(
      ifLeft: (Failure failure) {
        isPassphraseLoading.value = false;
        if (kDebugMode) {
          print('Erreur mise à jour phrase secrète: ${failure.message}');
        }
        return false;
      },
      ifRight: (_) {
        currentPassphrase.value = newPassphrase.trim();
        isPassphraseLoading.value = false;
        return true;
      },
    );
    return isSuccess;
  }

  Future<String?> generateNewRandomPassphrase() async {
    isPassphraseLoading.value = true;
    final Either<Failure, String> result = await regeneratePassphraseUseCase();
    final String? phrase = result.fold(
      ifLeft: (Failure failure) {
        isPassphraseLoading.value = false;
        if (kDebugMode) {
          print('Erreur génération nouvelle phrase: ${failure.message}');
        }
        return null;
      },
      ifRight: (String newPhrase) {
        currentPassphrase.value = newPhrase;
        isPassphraseLoading.value = false;
        return newPhrase;
      },
    );
    return phrase;
  }

  void subscribeToRoom({
    required String roomId,
    String? peerPublicKeyBase64,
  }) {
    unawaited(_messagesSubscription?.cancel());
    currentRoomId.value = roomId;
    isLoading.value = true;

    final String currentUserId = supabaseClient.auth.currentUser?.id ?? '';

    _messagesSubscription = getMessagesStreamUseCase(
      GetChatMessagesStreamParams(
        roomId: roomId,
        peerPublicKeyBase64: peerPublicKeyBase64,
      ),
    ).listen((Either<Failure, List<MessageEntity>> either) {
      either.fold(
        ifLeft: (Failure failure) {
          isLoading.value = false;
          if (kDebugMode) {
            print('Erreur stream messages: ${failure.message}');
          }
        },
        ifRight: (List<MessageEntity> entities) {
          messages.value = entities
              .map(
                (MessageEntity e) => MessageViewModel(
                  e,
                  currentUserId: currentUserId,
                ),
              )
              .toList();
          isLoading.value = false;
        },
      );
    });
  }

  Future<bool> sendMessage({
    required String roomId,
    required String plainText,
    String? peerPublicKeyBase64,
    String? mediaUrl,
  }) async {
    if (plainText.trim().isEmpty && mediaUrl == null) {
      return false;
    }

    isSending.value = true;
    final Either<Failure, MessageEntity> result = await sendMessageUseCase(
      SendEncryptedMessageParams(
        roomId: roomId,
        plainText: plainText.trim(),
        peerPublicKeyBase64: peerPublicKeyBase64,
        mediaUrl: mediaUrl,
      ),
    );

    final bool isSuccess = result.fold(
      ifLeft: (Failure failure) {
        isSending.value = false;
        if (kDebugMode) {
          print('Erreur envoi message: ${failure.message}');
        }
        return false;
      },
      ifRight: (MessageEntity entity) {
        isSending.value = false;
        return true;
      },
    );
    return isSuccess;
  }

  Future<void> search({
    required String query,
    String? roomId,
  }) async {
    final String trimmed = query.trim();
    if (trimmed.isEmpty) {
      searchResults.value = <MessageViewModel>[];
      isSearching.value = false;
      return;
    }

    isSearching.value = true;
    final String currentUserId = supabaseClient.auth.currentUser?.id ?? '';

    final Either<Failure, List<MessageEntity>> result = await searchMessagesUseCase(
      SearchMessagesParams(query: trimmed, roomId: roomId),
    );

    result.fold(
      ifLeft: (Failure failure) {
        isSearching.value = false;
        searchResults.value = <MessageViewModel>[];
      },
      ifRight: (List<MessageEntity> entities) {
        isSearching.value = false;
        searchResults.value = entities
            .map((MessageEntity e) => MessageViewModel(e, currentUserId: currentUserId))
            .toList();
      },
    );
  }

  void clearSearch() {
    searchResults.value = <MessageViewModel>[];
    isSearching.value = false;
  }

  Future<void> dispose() async {
    await _messagesSubscription?.cancel();
    _messagesSubscription = null;
    currentRoomId.value = null;
    messages.value = <MessageViewModel>[];
    clearSearch();
  }
}
