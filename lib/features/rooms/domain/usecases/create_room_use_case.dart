import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';

/// Créer un salon.
class CreateRoomUseCase {
  new(this.repository);
  final RoomRepository repository;

  Future<Either<Failure, RoomEntity>> call(CreateRoomParams params) async {
    return await repository.createRoom(params: params);
  }
}
