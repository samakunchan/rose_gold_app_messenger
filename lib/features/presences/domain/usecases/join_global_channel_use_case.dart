import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/repositories/user_presence_repository.dart';

class JoinGlobalChannelUseCase {
  new(this.repository);
  final UserPresenceRepository repository;

  Future<Either<Failure, bool>> call() {
    return repository.joinGlobalChannel();
  }
}
