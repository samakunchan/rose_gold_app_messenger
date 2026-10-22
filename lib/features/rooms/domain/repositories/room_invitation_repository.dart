import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_invitation_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/user_profile_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';

abstract class RoomInvitationRepository {
  Future<Either<Failure, bool>> sendInvitation({required SendInvitationParams params});
  Future<Either<Failure, bool>> acceptInvitation({required InvitationParams params});
  Future<Either<Failure, bool>> declineInvitation({required InvitationParams params});
  Future<Either<Failure, UserProfileEntity?>> searchUserByTag({required SearchUserByTagParams params});
  Stream<List<RoomInvitationEntity>> receivedInvitationsStream();
}
