import 'dart:async';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/presences/presentation/signals/user_presence_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_member_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/user_profile_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/get_co_members_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/get_rooms_members_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/leave_one_room.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_member_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/user_profile_view_model.dart';
import 'package:signals_flutter/signals_core.dart';

class RoomMembersSignals {
  new({
    required this.getRoomsMembersUseCase,
    required this.getCoMembersUseCase,
    required this.leaveOneRoom,
  });

  final GetRoomsMembersUseCase getRoomsMembersUseCase;
  final GetCoMembersUseCase getCoMembersUseCase;
  final LeaveOneRoom leaveOneRoom;

  final Signal<List<RoomMemberViewModel>> members = signal<List<RoomMemberViewModel>>(<RoomMemberViewModel>[]);
  final Signal<List<UserProfileViewModel>> coMembers = signal<List<UserProfileViewModel>>(<UserProfileViewModel>[]);
  final Signal<bool> isLoadingCoMembers = signal<bool>(false);

  StreamSubscription<List<RoomMemberEntity>>? _membersSubscription;

  /// Voir les membres d'un salon.
  Future<void> getMembers({required String roomId}) async {
    await _membersSubscription?.cancel();
    _membersSubscription = getRoomsMembersUseCase(GetRoomMembersParams(roomId: roomId)).listen(
      (List<RoomMemberEntity> roomsEntity) {
        members.value = roomsEntity
            .map((RoomMemberEntity entity) => RoomMemberViewModel(entity, onlineUsers: kGetIt<UserPresenceSignals>().onlineUsers.value))
            .toList();
      },
      onError: (Object error) {
        if (kDebugMode) {
          print('RoomMembersSignals getMembers error: $error');
        }
      },
    );
  }

  /// Récupérer les co-membres partageant au moins un salon
  Future<void> fetchCoMembers() async {
    isLoadingCoMembers.value = true;
    final Either<Failure, List<UserProfileEntity>> result = await getCoMembersUseCase();
    result.fold(
      ifLeft: (Failure failure) {
        isLoadingCoMembers.value = false;
        if (kDebugMode) {
          print('fetchCoMembers error: ${failure.message}');
        }
      },
      ifRight: (List<UserProfileEntity> entities) {
        isLoadingCoMembers.value = false;
        coMembers.value = entities.map(UserProfileViewModel.new).toList();
      },
    );
  }

  Future<void> leaveRoom({required String roomId}) async {
    isLoadingCoMembers.value = true;
    final Either<Failure, bool> result = await leaveOneRoom(
      GetRoomMembersParams(roomId: roomId),
    );
    result.fold(
      ifLeft: (Failure failure) {
        isLoadingCoMembers.value = false;
        if (kDebugMode) {
          print('fetchCoMembers error: ${failure.message}');
        }
      },
      ifRight: (bool entities) {
        isLoadingCoMembers.value = false;
      },
    );
  }
}
