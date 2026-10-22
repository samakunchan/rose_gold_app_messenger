import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_invitation_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';

/// Accepter une invitation à entrer dans un salon.
class AcceptInvitationUseCase {
  new(this.repository);
  final RoomInvitationRepository repository;

  Future<Either<Failure, bool>> call(InvitationParams params) async {
    return await repository.acceptInvitation(params: params);
  }
}
