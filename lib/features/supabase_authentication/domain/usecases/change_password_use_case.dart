import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/auth_session_entity.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/repositories/auth_repository.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/usecases/params.dart';

///
/// ```dart
/// final ChangePasswordUseCase changePasswordUseCase = ChangePasswordUseCase(repository);
///
/// final Either<Failure, AuthSessionEntity> result = await changePasswordUseCase(
///    ChangePasswordParams(email: email, password: password, token: token),
/// );
/// ```
class ChangePasswordUseCase {
  new(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, AuthSessionEntity>> call(ChangePasswordParams params) async {
    return await repository.changePassword(params: params);
  }
}
