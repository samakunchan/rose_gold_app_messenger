import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_invitation_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';

/// Envoyer une invitation à entrer dans un salon.
class SendInvitationUseCase {
  new(this.repository);
  final RoomInvitationRepository repository;

  Future<Either<Failure, bool>> call(SendInvitationParams params) async {
    return await repository.sendInvitation(params: params);
  }
}
