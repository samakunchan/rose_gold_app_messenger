import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rose_gold_app_messenger/features/chat/data/datasources/chat_crypto_data_source.dart';
import 'package:rose_gold_app_messenger/features/chat/data/datasources/chat_local_data_source.dart';
import 'package:rose_gold_app_messenger/features/chat/data/datasources/chat_remote_data_source.dart';
import 'package:rose_gold_app_messenger/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/repositories/chat_repository.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/get_chat_messages_stream_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/get_passphrase_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/initialize_e2ee_keys_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/regenerate_passphrase_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/search_messages_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/send_encrypted_message_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/update_passphrase_use_case.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/signals/chat_signals.dart';
import 'package:rose_gold_app_messenger/features/core/database/app_database.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void initChatDI() {
  kGetIt
    /// Data Sources
    ..registerLazySingleton<ChatCryptoDataSource>(
      () => ChatCryptoDataSourceImpl(secureStorage: kGetIt<FlutterSecureStorage>()),
    )
    ..registerLazySingleton<ChatRemoteDataSource>(
      () => ChatRemoteDataSourceImpl(client: kGetIt<SupabaseClient>()),
    )
    ..registerLazySingleton<ChatLocalDataSource>(
      () => ChatLocalDataSourceImpl(database: kGetIt<AppDatabase>()),
    )
    /// Repositories
    ..registerLazySingleton<ChatRepository>(
      () => ChatRepositoryImpl(
        remoteDataSource: kGetIt<ChatRemoteDataSource>(),
        cryptoDataSource: kGetIt<ChatCryptoDataSource>(),
        localDataSource: kGetIt<ChatLocalDataSource>(),
        supabaseClient: kGetIt<SupabaseClient>(),
      ),
    )
    /// Use Cases
    ..registerLazySingleton<InitializeE2EEKeysUseCase>(
      () => InitializeE2EEKeysUseCase(kGetIt<ChatRepository>()),
    )
    ..registerLazySingleton<SendEncryptedMessageUseCase>(
      () => SendEncryptedMessageUseCase(kGetIt<ChatRepository>()),
    )
    ..registerLazySingleton<GetChatMessagesStreamUseCase>(
      () => GetChatMessagesStreamUseCase(kGetIt<ChatRepository>()),
    )
    ..registerLazySingleton<SearchMessagesUseCase>(
      () => SearchMessagesUseCase(kGetIt<ChatRepository>()),
    )
    ..registerLazySingleton<GetPassphraseUseCase>(
      () => GetPassphraseUseCase(kGetIt<ChatRepository>()),
    )
    ..registerLazySingleton<UpdatePassphraseUseCase>(
      () => UpdatePassphraseUseCase(kGetIt<ChatRepository>()),
    )
    ..registerLazySingleton<RegeneratePassphraseUseCase>(
      () => RegeneratePassphraseUseCase(kGetIt<ChatRepository>()),
    )
    /// Signals
    ..registerLazySingleton<ChatSignals>(
      () => ChatSignals(
        initKeysUseCase: kGetIt<InitializeE2EEKeysUseCase>(),
        sendMessageUseCase: kGetIt<SendEncryptedMessageUseCase>(),
        getMessagesStreamUseCase: kGetIt<GetChatMessagesStreamUseCase>(),
        searchMessagesUseCase: kGetIt<SearchMessagesUseCase>(),
        getPassphraseUseCase: kGetIt<GetPassphraseUseCase>(),
        updatePassphraseUseCase: kGetIt<UpdatePassphraseUseCase>(),
        regeneratePassphraseUseCase: kGetIt<RegeneratePassphraseUseCase>(),
        supabaseClient: kGetIt<SupabaseClient>(),
      ),
    );
}
