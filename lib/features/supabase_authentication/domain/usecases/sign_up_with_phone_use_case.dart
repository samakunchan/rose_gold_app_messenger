import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/auth_session_entity.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/repositories/auth_repository.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/usecases/params.dart';

/// Example
/// ```dart
/// final SignUpWithPhoneUseCase signUpWithPhoneUseCase = SignUpWithPhoneUseCase(repository);
///
/// final Either<Failure, AuthSessionEntity> result = await signUpWithPhoneUseCase(
///   SignUpWithPhoneParams(phoneNumber: phoneNumber, password: password, username: username, locale: 'fr'),
/// );
/// ```
class SignUpWithPhoneUseCase {
  new(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, AuthSessionEntity>> call(SignUpWithPhoneParams params) async {
    return await repository.signUpWithPhone(params: params);
  }
}
