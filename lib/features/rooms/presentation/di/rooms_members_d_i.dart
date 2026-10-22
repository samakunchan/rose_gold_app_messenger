import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/datasources/room_member_data_source.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/repositories/room_member_repository_impl.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_member_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/get_co_members_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/get_rooms_members_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/leave_one_room.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_members_signals.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void initSupabaseRoomsMembersDI() {
  kGetIt
    /// RoomsMembers
    ..registerLazySingleton<RoomMemberDataSource>(() => RoomMemberDataSourceImpl(client: kGetIt<SupabaseClient>()))
    /// RoomsMembers - Repositories
    ..registerLazySingleton<RoomMemberRepository>(() => RoomMemberRepositoryImpl(dataSource: kGetIt<RoomMemberDataSource>()))
    /// RoomsMembers - Use cases
    ..registerLazySingleton<GetRoomsMembersUseCase>(() => GetRoomsMembersUseCase(kGetIt<RoomMemberRepository>()))
    ..registerLazySingleton<GetCoMembersUseCase>(() => GetCoMembersUseCase(kGetIt<RoomMemberRepository>()))
    ..registerLazySingleton<LeaveOneRoom>(() => LeaveOneRoom(kGetIt<RoomMemberRepository>()))
    /// RoomsMembers - Signals
    ..registerLazySingleton<RoomMembersSignals>(
      () => RoomMembersSignals(
        getRoomsMembersUseCase: kGetIt<GetRoomsMembersUseCase>(),
        getCoMembersUseCase: kGetIt<GetCoMembersUseCase>(),
        leaveOneRoom: kGetIt<LeaveOneRoom>(),
      ),
    )
  //
  ;
}
