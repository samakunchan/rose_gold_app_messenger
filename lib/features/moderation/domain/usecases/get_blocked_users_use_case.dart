import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/entities/blocked_user_entity.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/repositories/moderation_repository.dart';

class GetBlockedUsersUseCase {
  new(this.repository);

  final ModerationRepository repository;

  Future<Either<Failure, List<BlockedUserEntity>>> call() async {
    return await repository.getBlockedUsers();
  }
}
