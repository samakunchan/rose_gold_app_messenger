import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/datasources/room_invitation_data_source.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/repositories/room_invitation_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_invitation_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/accept_invitation_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/decline_invitation_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/receive_invitation_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/search_user_by_tag_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/send_invitation_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_invitations_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/rooms_signals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void initSupabaseRoomInvitationsDI() {
  kGetIt
    /// RoomsInvitation
    ..registerLazySingleton<RoomInvitationDataSource>(() => RoomInvitationDataSourceImpl(client: kGetIt<SupabaseClient>()))
    /// RoomsInvitation - Repositories
    ..registerLazySingleton<RoomInvitationRepository>(() => RoomInvitationRepositoryImpl(dataSource: kGetIt<RoomInvitationDataSource>()))
    /// RoomsInvitation - Use cases
    ..registerLazySingleton<SendInvitationUseCase>(() => SendInvitationUseCase(kGetIt<RoomInvitationRepository>()))
    ..registerLazySingleton<AcceptInvitationUseCase>(() => AcceptInvitationUseCase(kGetIt<RoomInvitationRepository>()))
    ..registerLazySingleton<DeclineInvitationUseCase>(() => DeclineInvitationUseCase(kGetIt<RoomInvitationRepository>()))
    ..registerLazySingleton<ReceiveInvitationUseCase>(() => ReceiveInvitationUseCase(kGetIt<RoomInvitationRepository>()))
    ..registerLazySingleton<SearchUserByTagUseCase>(() => SearchUserByTagUseCase(kGetIt<RoomInvitationRepository>()))
    /// RoomsInvitation - Signals
    ..registerLazySingleton<RoomInvitationsSignals>(
      () => RoomInvitationsSignals(
        sendInvitationUseCase: kGetIt<SendInvitationUseCase>(),
        acceptInvitationUseCase: kGetIt<AcceptInvitationUseCase>(),
        declineInvitationUseCase: kGetIt<DeclineInvitationUseCase>(),
        receiveInvitationUseCase: kGetIt<ReceiveInvitationUseCase>(),
        searchUserByTagUseCase: kGetIt<SearchUserByTagUseCase>(),
        roomsSignals: kGetIt<RoomsSignals>(),
      ),
    )
  //
  ;
}
