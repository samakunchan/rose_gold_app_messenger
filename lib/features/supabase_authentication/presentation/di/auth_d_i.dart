import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/data/datasources/auth_remote_data_source.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/data/datasources/cache_data_source.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/data/repositories/auth_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/data/repositories/cache_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/repositories/auth_repository.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/repositories/cache_repository.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/usecases/get_remembered_credentials.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/usecases/use_cases_export.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void initSupabaseAuthDI() {
  kGetIt
    /// Auth
    ..registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(client: kGetIt<SupabaseClient>()))
    ..registerSingleton<CacheDataSource>(CacheDataSourceImpl(storage: kGetIt<FlutterSecureStorage>()))
    /// Auth - Repositories
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(remoteDataSource: kGetIt<AuthRemoteDataSource>(), cacheDataSource: kGetIt<CacheDataSource>()),
    )
    ..registerSingleton<CacheRepository>(CacheRepositoryImpl(cacheDataSource: kGetIt<CacheDataSource>()))
    /// Auth -  Use cases
    ..registerLazySingleton<SignInUseCase>(() => SignInUseCase(kGetIt<AuthRepository>()))
    ..registerLazySingleton<SignUpWithEmailUseCase>(() => SignUpWithEmailUseCase(kGetIt<AuthRepository>()))
    ..registerLazySingleton<SignUpWithPhoneUseCase>(() => SignUpWithPhoneUseCase(kGetIt<AuthRepository>()))
    ..registerLazySingleton<SignOutUseCase>(() => SignOutUseCase(kGetIt<AuthRepository>()))
    ..registerLazySingleton<ForgotPasswordRequestUseCase>(() => ForgotPasswordRequestUseCase(kGetIt<AuthRepository>()))
    ..registerLazySingleton<ChangePasswordUseCase>(() => ChangePasswordUseCase(kGetIt<AuthRepository>()))
    ..registerLazySingleton<DeleteAccountUseCase>(() => DeleteAccountUseCase(kGetIt<AuthRepository>()))
    ..registerLazySingleton<GetSessionUseCase>(() => GetSessionUseCase(kGetIt<AuthRepository>()))
    ..registerLazySingleton<GetRememberedCredentials>(() => GetRememberedCredentials(kGetIt<CacheRepository>()))
    /// Auth - Signals
    ..registerLazySingleton<AuthSignals>(
      () => AuthSignals(
        signInUseCase: kGetIt<SignInUseCase>(),
        signOutUseCase: kGetIt<SignOutUseCase>(),
        getSessionUseCase: kGetIt<GetSessionUseCase>(),
        registerUseCase: kGetIt<SignUpWithEmailUseCase>(),
        deleteAccountUseCase: kGetIt<DeleteAccountUseCase>(),
        forgotPasswordRequestUseCase: kGetIt<ForgotPasswordRequestUseCase>(),
        changePasswordUseCase: kGetIt<ChangePasswordUseCase>(),
        getRememberedCredentials: kGetIt<GetRememberedCredentials>(),
      ),
    )
  //
  ;
}
