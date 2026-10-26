import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/moderation/data/datasources/moderation_remote_data_source.dart';
import 'package:rose_gold_app_messenger/features/moderation/data/repositories/moderation_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/repositories/moderation_repository.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/usecases/block_user_use_case.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/usecases/get_blocked_users_use_case.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/usecases/report_invitation_use_case.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/usecases/unblock_user_use_case.dart';
import 'package:rose_gold_app_messenger/features/moderation/presentation/signals/moderation_signals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void initModerationDI() {
  kGetIt
    /// Moderation - DataSource
    ..registerLazySingleton<ModerationRemoteDataSource>(
      () => ModerationRemoteDataSourceImpl(client: kGetIt<SupabaseClient>()),
    )
    /// Moderation - Repository
    ..registerLazySingleton<ModerationRepository>(
      () => ModerationRepositoryImpl(remoteDataSource: kGetIt<ModerationRemoteDataSource>()),
    )
    /// Moderation - Use cases
    ..registerLazySingleton<GetBlockedUsersUseCase>(() => GetBlockedUsersUseCase(kGetIt<ModerationRepository>()))
    ..registerLazySingleton<BlockUserUseCase>(() => BlockUserUseCase(kGetIt<ModerationRepository>()))
    ..registerLazySingleton<UnblockUserUseCase>(() => UnblockUserUseCase(kGetIt<ModerationRepository>()))
    ..registerLazySingleton<ReportInvitationUseCase>(() => ReportInvitationUseCase(kGetIt<ModerationRepository>()))
    /// Moderation - Signals
    ..registerLazySingleton<ModerationSignals>(
      () => ModerationSignals(
        getBlockedUsersUseCase: kGetIt<GetBlockedUsersUseCase>(),
        blockUserUseCase: kGetIt<BlockUserUseCase>(),
        unblockUserUseCase: kGetIt<UnblockUserUseCase>(),
        reportInvitationUseCase: kGetIt<ReportInvitationUseCase>(),
      ),
    );
}
