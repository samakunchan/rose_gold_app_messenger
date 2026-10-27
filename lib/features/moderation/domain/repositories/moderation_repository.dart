import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/entities/blocked_user_entity.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/usecases/params.dart';

abstract class ModerationRepository {
  Future<Either<Failure, List<BlockedUserEntity>>> getBlockedUsers();
  Future<Either<Failure, bool>> blockUser({required BlockUserParams params});
  Future<Either<Failure, bool>> unblockUser({required UnblockUserParams params});
  Future<Either<Failure, bool>> reportInvitation({required ReportInvitationParams params});
}
