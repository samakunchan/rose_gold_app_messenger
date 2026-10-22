import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/error_messages.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/datasources/room_data_source.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/models/room_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';

class RoomRepositoryImpl extends RoomRepository {
  new({required this.dataSource});

  final RoomDataSource dataSource;

  @override
  Future<Either<Failure, RoomEntity>> createRoom({required CreateRoomParams params}) async {
    try {
      final RoomModel result = await dataSource.createRoom(
        name: params.name,
        description: params.description,
        avatarUrl: params.avatarUrl,
      );

      return Right<Failure, RoomEntity>(result.toEntity());
    } on Exception {
      return const Left<Failure, RoomEntity>(RoomsFailure());
    }
  }

  @override
  Future<Either<Failure, RoomEntity>> updateRoom({required UpdateRoomParams params}) async {
    try {
      final RoomModel result = await dataSource.updateRoom(
        name: params.name,
        roomId: params.roomId,
        description: params.description,
        avatarUrl: params.avatarUrl,
      );

      return Right<Failure, RoomEntity>(result.toEntity());
    } on Exception {
      return const Left<Failure, RoomEntity>(RoomsFailure(message: ErrorMessage.roomUpdateFailureMessage));
    }
  }

  @override
  Stream<List<RoomEntity>> roomsStream() {
    final Stream<List<RoomModel>> stream = dataSource.roomsStream();

    return stream.map(
      (List<RoomModel> rooms) => rooms.map((RoomModel room) => room.toEntity()).toList(),
    );
  }

  @override
  Future<Either<Failure, bool>> deleteRoom({required DeleteRoomParams params}) async {
    try {
      await dataSource.deleteRoom(roomId: params.roomId);

      return const Right<Failure, bool>(true);
    } on Exception {
      return const Left<Failure, bool>(RoomsFailure(message: ErrorMessage.roomUpdateFailureMessage));
    }
  }
}
