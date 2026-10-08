import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/repositories/auth_repository.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/usecases/params.dart';

/// Example
/// ```dart
/// final ForgotPasswordRequestUseCase forgotPasswordUseCase = ForgotPasswordRequestUseCase(repository);
///
/// final Either<Failure, void> result = await forgotPasswordUseCase(
///   ForgotPasswordRequestUseCase(email: email),
/// );
/// ```
class ForgotPasswordRequestUseCase {
  new(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, void>> call(ForgotPasswordParams params) async {
    return await repository.forgotPassword(params: params);
  }
}
