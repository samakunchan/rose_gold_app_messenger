import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/moderation/data/datasources/moderation_remote_data_source.dart';
import 'package:rose_gold_app_messenger/features/moderation/data/models/blocked_user_model.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/entities/blocked_user_entity.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/repositories/moderation_repository.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/usecases/params.dart';

class ModerationRepositoryImpl implements ModerationRepository {
  new({required this.remoteDataSource});

  final ModerationRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<BlockedUserEntity>>> getBlockedUsers() async {
    try {
      final List<BlockedUserModel> models = await remoteDataSource.getBlockedUsers();
      return Right<Failure, List<BlockedUserEntity>>(
        models.map((BlockedUserModel m) => m.toEntity()).toList(),
      );
    } on Object catch (e) {
      return Left<Failure, List<BlockedUserEntity>>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> blockUser({required BlockUserParams params}) async {
    try {
      final bool res = await remoteDataSource.blockUser(blockedUserId: params.blockedUserId);
      return Right<Failure, bool>(res);
    } on Object catch (e) {
      return Left<Failure, bool>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> unblockUser({required UnblockUserParams params}) async {
    try {
      final bool res = await remoteDataSource.unblockUser(blockedUserId: params.blockedUserId);
      return Right<Failure, bool>(res);
    } on Object catch (e) {
      return Left<Failure, bool>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> reportInvitation({required ReportInvitationParams params}) async {
    try {
      final bool res = await remoteDataSource.reportInvitation(
        reportedUserId: params.reportedUserId,
        roomId: params.roomId,
        invitationId: params.invitationId,
        reason: params.reason,
        details: params.details,
        blockUser: params.blockUser,
      );
      return Right<Failure, bool>(res);
    } on Object catch (e) {
      return Left<Failure, bool>(ServerFailure(message: e.toString()));
    }
  }
}
