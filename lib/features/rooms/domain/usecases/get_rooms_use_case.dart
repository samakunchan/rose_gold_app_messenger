import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_repository.dart';

/// Voir tout les salons autorisés en stream.
class GetRoomsUseCase {
  new(this.repository);
  final RoomRepository repository;

  Stream<List<RoomEntity>> call() {
    return repository.roomsStream();
  }
}
