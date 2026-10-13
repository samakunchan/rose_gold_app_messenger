import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/repositories/user_presence_repository.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/usecases/params.dart';

class TrackPresenceUseCase {
  new(this.repository);
  final UserPresenceRepository repository;

  Future<Either<Failure, bool>> call(PresenceParams params) {
    return repository.trackPresence(params: params);
  }
}
