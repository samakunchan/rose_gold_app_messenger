import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';

abstract class RoomRepository {
  Future<Either<Failure, RoomEntity>> createRoom({required CreateRoomParams params});
  Future<Either<Failure, RoomEntity>> updateRoom({required UpdateRoomParams params});
  Stream<List<RoomEntity>> roomsStream();
  Future<Either<Failure, bool>> deleteRoom({required DeleteRoomParams params});
}
