import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/auth_session_entity.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/repositories/auth_repository.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/usecases/params.dart';

/// Example
/// ```dart
/// final SignInUseCase signInUseCase = SignInUseCase(repository);
///
/// final Either<Failure, AuthSessionEntity> result = await signInUseCase(
///   SignInParams(email: email, password: password),
/// );
/// ```
class SignInUseCase {
  new(this.repository);
  final AuthRepository repository;

  Future<Either<Failure, AuthSessionEntity>> call(SignInParams params) {
    return repository.signIn(params: params);
  }
}
