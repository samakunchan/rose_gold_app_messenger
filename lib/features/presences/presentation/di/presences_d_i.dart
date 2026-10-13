import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/presences/data/datasources/user_presence_data_source.dart';
import 'package:rose_gold_app_messenger/features/presences/data/repositories/user_presence_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/repositories/user_presence_repository.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/usecases/get_connected_users.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/usecases/join_global_channel_use_case.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/usecases/leave_global_channel_use_case.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/usecases/track_presence_use_case.dart';
import 'package:rose_gold_app_messenger/features/presences/presentation/signals/user_presence_signals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void initSupabasePresenceDI() {
  kGetIt
    /// Presences
    ..registerLazySingleton<UserPresenceDataSource>(() => UserPresenceDataSourceImpl(client: kGetIt<SupabaseClient>()))
    /// Presences - Repositories
    ..registerLazySingleton<UserPresenceRepository>(() => UserPresenceRepositoryImpl(dataSource: kGetIt<UserPresenceDataSource>()))
    /// Presences -  Use cases
    ..registerLazySingleton<JoinGlobalChannelUseCase>(() => JoinGlobalChannelUseCase(kGetIt<UserPresenceRepository>()))
    ..registerLazySingleton<LeaveGlobalChannelUseCase>(() => LeaveGlobalChannelUseCase(kGetIt<UserPresenceRepository>()))
    ..registerLazySingleton<TrackPresenceUseCase>(() => TrackPresenceUseCase(kGetIt<UserPresenceRepository>()))
    ..registerLazySingleton<GetConnectedUsersUseCase>(() => GetConnectedUsersUseCase(kGetIt<UserPresenceRepository>()))
    /// Presences - Signals
    ..registerLazySingleton<UserPresenceSignals>(
      () => UserPresenceSignals(
        joinGlobalChannelUseCase: kGetIt<JoinGlobalChannelUseCase>(),
        trackPresenceUseCase: kGetIt<TrackPresenceUseCase>(),
        getConnectedUsersUseCase: kGetIt<GetConnectedUsersUseCase>(),
        leaveGlobalChannelUseCase: kGetIt<LeaveGlobalChannelUseCase>(),
      ),
    )
  //
  ;
}
