import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';

/// Supprimer complètement un salon.
class DeleteRoomUseCase {
  new(this.repository);
  final RoomRepository repository;

  Future<Either<Failure, bool>> call(DeleteRoomParams params) async {
    return await repository.deleteRoom(params: params);
  }
}
