import 'dart:async';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/encrypted_media_attachment.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/message_entity.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/download_and_decrypt_media_use_case.dart';
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
    required this.downloadAndDecryptMediaUseCase,
    required this.supabaseClient,
  });

  final InitializeE2EEKeysUseCase initKeysUseCase;
  final SendEncryptedMessageUseCase sendMessageUseCase;
  final GetChatMessagesStreamUseCase getMessagesStreamUseCase;
  final SearchMessagesUseCase searchMessagesUseCase;
  final GetPassphraseUseCase getPassphraseUseCase;
  final UpdatePassphraseUseCase updatePassphraseUseCase;
  final RegeneratePassphraseUseCase regeneratePassphraseUseCase;
  final DownloadAndDecryptMediaUseCase downloadAndDecryptMediaUseCase;
  final SupabaseClient supabaseClient;

  static const Duration _typingMaxDuration = Duration(minutes: 1);

  final Signal<bool> isLoading = .new(false);
  final Signal<bool> isSending = .new(false);
  final Signal<bool> isSearching = .new(false);
  final Signal<bool> isPassphraseLoading = .new(false);
  final Signal<bool> isTyping = .new(false);
  final Signal<String?> currentRoomId = .new(null);
  final Signal<String?> currentPassphrase = signal<String?>(null);
  final Signal<List<MessageViewModel>> messages = signal<List<MessageViewModel>>(<MessageViewModel>[]);
  final Signal<List<MessageViewModel>> searchResults = signal<List<MessageViewModel>>(<MessageViewModel>[]);
  final Signal<List<String>> typingUsernames = signal<List<String>>(<String>[]);

  final Map<String, Uint8List> _decryptedMediaCache = <String, Uint8List>{};

  StreamSubscription<Either<Failure, List<MessageEntity>>>? _messagesSubscription;
  RealtimeChannel? _typingChannel;
  Timer? _typingResetTimer;
  Timer? _typingExpiryCleanupTimer;
  String? _cachedCurrentUsername;
  String? _cachedCurrentUserId;

  String? get typingIndicatorText {
    final List<String> names = typingUsernames.value;
    if (names.isEmpty) {
      return null;
    }
    if (names.length == 1) {
      return '${names.first} est en train d’écrire...';
    }
    if (names.length == 2) {
      return '${names[0]} et ${names[1]} sont en train d’écrire...';
    }
    final String others = names.sublist(0, names.length - 1).join(', ');
    return '$others et ${names.last} sont en train d’écrire...';
  }

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

  void subscribeToRoom({required String roomId, String? peerPublicKeyBase64}) {
    unawaited(_messagesSubscription?.cancel());
    currentRoomId.value = roomId;
    isLoading.value = true;

    final String currentUserId = supabaseClient.auth.currentUser?.id ?? '';
    unawaited(_subscribeToTypingChannel(roomId: roomId));

    _messagesSubscription =
        getMessagesStreamUseCase(
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

  Future<void> _subscribeToTypingChannel({required String roomId}) async {
    await _leaveTypingChannel();
    unawaited(_resolveCurrentUsername());

    final RealtimeChannel channel = supabaseClient.channel('room_typing:$roomId');
    _typingChannel = channel;

    channel
        .onPresenceSync((_) {
          _syncTypingUsers();
        })
        .subscribe();
  }

  void _syncTypingUsers() {
    _typingExpiryCleanupTimer?.cancel();
    _typingExpiryCleanupTimer = null;

    final RealtimeChannel? channel = _typingChannel;
    if (channel == null) {
      typingUsernames.value = <String>[];
      return;
    }

    final String currentUserId = supabaseClient.auth.currentUser?.id ?? '';
    final DateTime now = DateTime.now().toUtc();
    final List<SinglePresenceState> states = channel.presenceState();

    final Map<String, String> activeByUserId = <String, String>{};
    Duration? shortestRemaining;

    for (final SinglePresenceState state in states) {
      for (final Presence presence in state.presences) {
        final Map<String, dynamic> payload = presence.payload;
        final String? userId = payload['user_id'] as String?;
        final bool typing = payload['is_typing'] == true;
        if (userId == null || userId.isEmpty || userId == currentUserId || !typing) {
          continue;
        }

        final String? typedAtRaw = payload['typed_at'] as String?;
        final DateTime? typedAt = typedAtRaw != null ? DateTime.tryParse(typedAtRaw)?.toUtc() : null;
        if (typedAt != null) {
          final Duration elapsed = now.difference(typedAt);
          if (elapsed >= _typingMaxDuration) {
            continue;
          }
          final Duration remaining = _typingMaxDuration - elapsed;
          if (shortestRemaining == null || remaining < shortestRemaining) {
            shortestRemaining = remaining;
          }
        }

        final String rawName = (payload['username'] as String? ?? '').trim();
        activeByUserId[userId] = rawName.isNotEmpty ? rawName : 'Utilisateur';
      }
    }

    typingUsernames.value = activeByUserId.values.toList();

    if (shortestRemaining != null) {
      _typingExpiryCleanupTimer = Timer(shortestRemaining + const Duration(milliseconds: 250), _syncTypingUsers);
    }
  }

  Future<String> _resolveCurrentUsername() async {
    final User? user = supabaseClient.auth.currentUser;
    if (user == null) {
      return 'Utilisateur';
    }
    if (_cachedCurrentUserId == user.id && _cachedCurrentUsername != null) {
      return _cachedCurrentUsername!;
    }
    try {
      final PostgrestMap? row = await supabaseClient
          .from('profiles')
          .select('username, user_tag')
          .eq('id', user.id)
          .maybeSingle();
      final String? dbUsername = (row?['username'] as String?)?.trim();
      final String? dbTag = (row?['user_tag'] as String?)?.trim();
      final String? metaUsername = (user.userMetadata?['username'] as String?)?.trim();
      final String? metaTag = (user.userMetadata?['user_tag'] as String?)?.trim();

      final String resolved = (dbUsername != null && dbUsername.isNotEmpty)
          ? dbUsername
          : (metaUsername != null && metaUsername.isNotEmpty)
          ? metaUsername
          : (dbTag != null && dbTag.isNotEmpty)
          ? dbTag
          : (metaTag != null && metaTag.isNotEmpty)
          ? metaTag
          : 'Utilisateur';

      _cachedCurrentUserId = user.id;
      _cachedCurrentUsername = resolved;
      return resolved;
    } on Exception catch (_) {
      final String fallback = (user.userMetadata?['username'] as String?)?.trim() ?? 'Utilisateur';
      return fallback.isNotEmpty ? fallback : 'Utilisateur';
    }
  }

  void onInputTextChanged(String text) {
    if (text.trim().isEmpty) {
      if (isTyping.value) {
        unawaited(setTyping(value: false));
      }
      return;
    }

    if (!isTyping.value) {
      unawaited(setTyping(value: true));
    }
  }

  Future<void> setTyping({required bool value}) async {
    _typingResetTimer?.cancel();
    _typingResetTimer = null;

    if (!value) {
      if (!isTyping.value) {
        return;
      }
      isTyping.value = false;
      try {
        await _typingChannel?.untrack();
      } on Exception catch (_) {}
      return;
    }

    isTyping.value = true;
    _typingResetTimer = Timer(_typingMaxDuration, () {
      unawaited(setTyping(value: false));
    });

    final String userId = supabaseClient.auth.currentUser?.id ?? '';
    if (userId.isEmpty || _typingChannel == null) {
      return;
    }

    final String username = await _resolveCurrentUsername();
    if (!isTyping.value || _typingChannel == null) {
      return;
    }

    try {
      await _typingChannel!.track(<String, dynamic>{
        'user_id': userId,
        'username': username,
        'is_typing': true,
        'typed_at': DateTime.now().toUtc().toIso8601String(),
      });
    } on Exception catch (_) {}
  }

  Future<void> _leaveTypingChannel() async {
    _typingResetTimer?.cancel();
    _typingResetTimer = null;
    _typingExpiryCleanupTimer?.cancel();
    _typingExpiryCleanupTimer = null;
    isTyping.value = false;
    typingUsernames.value = <String>[];

    final RealtimeChannel? channel = _typingChannel;
    _typingChannel = null;
    if (channel != null) {
      try {
        await channel.untrack();
        await channel.unsubscribe();
        await supabaseClient.removeChannel(channel);
      } on Exception catch (_) {}
    }
  }

  Future<bool> sendMessage({
    required String roomId,
    String plainText = '',
    String? peerPublicKeyBase64,
    String? mediaUrl,
    Uint8List? mediaBytes,
    String? mediaFileName,
    String? mediaMimeType,
  }) async {
    final String trimmedText = plainText.trim();
    if (trimmedText.isEmpty && mediaBytes == null && mediaUrl == null) {
      return false;
    }

    unawaited(setTyping(value: false));
    isSending.value = true;
    final Either<Failure, MessageEntity> result = await sendMessageUseCase(
      SendEncryptedMessageParams(
        roomId: roomId,
        plainText: trimmedText,
        peerPublicKeyBase64: peerPublicKeyBase64,
        mediaUrl: mediaUrl,
        mediaBytes: mediaBytes,
        mediaFileName: mediaFileName,
        mediaMimeType: mediaMimeType,
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

  Future<Uint8List?> getOrDownloadMedia(EncryptedMediaAttachment attachment) async {
    if (_decryptedMediaCache.containsKey(attachment.storagePath)) {
      return _decryptedMediaCache[attachment.storagePath];
    }

    final Either<Failure, Uint8List> result = await downloadAndDecryptMediaUseCase(attachment);
    final Uint8List? decrypted = result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print('Erreur téléchargement/déchiffrement média: ${failure.message}');
        }
        return null;
      },
      ifRight: (Uint8List bytes) {
        _decryptedMediaCache[attachment.storagePath] = bytes;
        return bytes;
      },
    );
    return decrypted;
  }

  Future<void> search({required String query, String? roomId}) async {
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
        searchResults.value = entities.map((MessageEntity e) => MessageViewModel(e, currentUserId: currentUserId)).toList();
      },
    );
  }

  void clearSearch() {
    searchResults.value = <MessageViewModel>[];
    isSearching.value = false;
  }

  int clearMediaCache() {
    final int count = _decryptedMediaCache.length;
    _decryptedMediaCache.clear();
    return count;
  }

  Future<void> dispose() async {
    await _leaveTypingChannel();
    await _messagesSubscription?.cancel();
    _messagesSubscription = null;
    currentRoomId.value = null;
    messages.value = <MessageViewModel>[];
    _decryptedMediaCache.clear();
    clearSearch();
  }
}
