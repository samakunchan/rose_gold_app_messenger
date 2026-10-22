import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';

/// Mettre à jour les infos d'un salon.
class UpdateRoomUseCase {
  new(this.repository);
  final RoomRepository repository;

  Future<Either<Failure, RoomEntity>> call(UpdateRoomParams params) async {
    return await repository.updateRoom(params: params);
  }
}
