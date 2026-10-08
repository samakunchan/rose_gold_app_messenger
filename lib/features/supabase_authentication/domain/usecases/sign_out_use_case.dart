import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/repositories/auth_repository.dart';

/// Example
/// ```dart
/// final SignOutUseCase signOutUseCase = SignOutUseCase(repository);
///
/// final Either<Failure, void> result = await signOutUseCase();
/// ```
class SignOutUseCase {
  const new(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, void>> call() {
    return repository.signOut();
  }
}
