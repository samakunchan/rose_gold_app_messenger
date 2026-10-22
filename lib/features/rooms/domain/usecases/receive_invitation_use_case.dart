import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_invitation_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_invitation_repository.dart';

/// Recevoir une invitation à entrer dans un salon.
class ReceiveInvitationUseCase {
  new(this.repository);
  final RoomInvitationRepository repository;

  Stream<List<RoomInvitationEntity>> call() {
    return repository.receivedInvitationsStream();
  }
}
