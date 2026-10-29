import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:rose_gold_app_messenger/features/profile/data/repositories/profile_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/repositories/profile_repository.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/usecases/update_profile_use_case.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/usecases/watch_profiles_use_case.dart';
import 'package:rose_gold_app_messenger/features/profile/presentation/signals/profile_signals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void initProfileDI() {
  kGetIt
    ..registerLazySingleton<ProfileRemoteDataSource>(() => ProfileRemoteDataSourceImpl(client: kGetIt<SupabaseClient>()))
    ..registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl(remoteDataSource: kGetIt<ProfileRemoteDataSource>()))
    ..registerLazySingleton<GetProfileUseCase>(() => GetProfileUseCase(repository: kGetIt<ProfileRepository>()))
    ..registerLazySingleton<UpdateProfileUseCase>(() => UpdateProfileUseCase(repository: kGetIt<ProfileRepository>()))
    ..registerLazySingleton<WatchProfilesUseCase>(() => WatchProfilesUseCase(kGetIt<ProfileRepository>()))
    ..registerLazySingleton<ProfileSignals>(
      () => ProfileSignals(
        getProfileUseCase: kGetIt<GetProfileUseCase>(),
        updateProfileUseCase: kGetIt<UpdateProfileUseCase>(),
        watchProfilesUseCase: kGetIt<WatchProfilesUseCase>(),
      ),
    );
}
