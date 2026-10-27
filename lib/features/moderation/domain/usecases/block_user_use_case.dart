import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/repositories/moderation_repository.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/usecases/params.dart';

class BlockUserUseCase {
  new(this.repository);

  final ModerationRepository repository;

  Future<Either<Failure, bool>> call(BlockUserParams params) async {
    return await repository.blockUser(params: params);
  }
}
