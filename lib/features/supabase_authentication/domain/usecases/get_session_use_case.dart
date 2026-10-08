import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/auth_session_entity.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/repositories/auth_repository.dart';

///
/// ```dart
/// final GetSessionUseCase getSessionUseCase = GetSessionUseCase(repository);
/// final Either<Failure, AuthSessionEntity> result = await getSessionUseCase();
/// ```
class GetSessionUseCase {
  const new(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, AuthSessionEntity>> call() {
    return repository.getSession();
  }
}
