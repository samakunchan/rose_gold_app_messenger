import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/auth_session_entity.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/usecases/params.dart';

/// Interface de AuthRepositoryImpl
/// ```groovy
///     AuthRepository     => Interface
///           ↓
///     AuthRepositoryImpl => Codes Metier
/// ```
abstract class AuthRepository {
  Future<Either<Failure, AuthSessionEntity>> signIn({required SignInParams params});
  Future<Either<Failure, AuthSessionEntity>> signUpWithEmail({required SignUpWithEmailParams params});
  Future<Either<Failure, AuthSessionEntity>> signUpWithPhone({required SignUpWithPhoneParams params});
  Future<Either<Failure, AuthSessionEntity>> changePassword({required ChangePasswordParams params});
  Future<Either<Failure, AuthSessionEntity>> getSession();
  Future<Either<Failure, void>> forgotPassword({required ForgotPasswordParams params});
  Future<Either<Failure, void>> signOut();
  Future<Either<Failure, bool>> deleteAccount();
}
