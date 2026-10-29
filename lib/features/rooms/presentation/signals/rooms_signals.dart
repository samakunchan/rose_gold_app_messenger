import 'dart:async';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/create_room_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/delete_room_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/get_rooms_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/update_room_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_members_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_view_model.dart';
import 'package:signals_flutter/signals_core.dart';

class RoomsSignals {
  new({required this.createRoomUseCase, required this.updateRoomUseCase, required this.getRoomsUseCase, required this.deleteRoomUseCase});
  final CreateRoomUseCase createRoomUseCase;
  final UpdateRoomUseCase updateRoomUseCase;
  final GetRoomsUseCase getRoomsUseCase;
  final DeleteRoomUseCase deleteRoomUseCase;

  final Signal<String?> roomName = .new('null');
  final Signal<String?> roomId = .new('null');
  final Signal<bool> isRoomCreated = .new(false);
  final Signal<bool> isRoomUpdated = .new(false);
  final Signal<bool> isLoading = .new(false);
  final Signal<List<RoomViewModel>> rooms = signal<List<RoomViewModel>>(<RoomViewModel>[]);

  StreamSubscription<List<RoomEntity>>? _roomsSubscription;

  Future<void> createRoom({required String name, String? description}) async {
    isLoading.value = true;
    final Either<Failure, RoomEntity> result = await createRoomUseCase(
      CreateRoomParams(name: name, description: description),
    );

    await result.fold(
      ifLeft: (Failure failure) async {
        isLoading.value = false;
        isRoomCreated.value = false;
        roomName.value = null;
        if (kDebugMode) {
          print(failure);
        }
      },
      ifRight: (RoomEntity entity) async {
        final RoomViewModel roomViewModel = RoomViewModel(entity);
        isLoading.value = false;
        isRoomCreated.value = true;
        roomName.value = roomViewModel.name;
        roomId.value = roomViewModel.id;
      },
    );
  }

  Future<void> updateRoom({required String roomId, required String name, String? description, String? avatarUrl}) async {
    isLoading.value = true;
    final Either<Failure, RoomEntity> result = await updateRoomUseCase(
      UpdateRoomParams(name: name, description: description, roomId: roomId, avatarUrl: avatarUrl),
    );

    await result.fold(
      ifLeft: (Failure failure) async {
        isLoading.value = false;
        isRoomUpdated.value = false;
        roomName.value = null;
        if (kDebugMode) {
          print(failure);
        }
      },
      ifRight: (RoomEntity entity) async {
        final RoomViewModel roomViewModel = RoomViewModel(entity);
        isLoading.value = false;
        isRoomUpdated.value = true;
        roomName.value = roomViewModel.name;
        rooms.value = rooms.value.map((RoomViewModel room) => room.id == entity.id ? roomViewModel : room).toList();
      },
    );
  }

  Future<void> deleteRooms({required String roomId}) async {
    isLoading.value = true;
    final Either<Failure, bool> result = await deleteRoomUseCase(
      DeleteRoomParams(roomId: roomId),
    );

    await result.fold(
      ifLeft: (Failure failure) async {
        isLoading.value = false;
        isRoomUpdated.value = false;
        roomName.value = null;
        if (kDebugMode) {
          print(failure);
        }
      },
      ifRight: (_) async {
        isLoading.value = false;
        isRoomUpdated.value = true;
        rooms.value = rooms.value.where((RoomViewModel room) => room.id != roomId).toList();
        unawaited(kGetIt<RoomMembersSignals>().fetchCoMembers());
      },
    );
  }

  Future<void> getRooms() async {
    await _roomsSubscription?.cancel();
    _roomsSubscription = getRoomsUseCase().listen(
      (List<RoomEntity> roomsEntity) {
        rooms.value = roomsEntity.map(RoomViewModel.new).toList();
        unawaited(kGetIt<RoomMembersSignals>().fetchCoMembers());
      },
      onError: (Object error) {
        if (kDebugMode) {
          print('RoomsSignals getRooms error: $error');
        }
      },
    );
  }
}
