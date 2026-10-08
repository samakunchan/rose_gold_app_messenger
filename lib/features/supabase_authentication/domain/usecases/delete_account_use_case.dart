import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/repositories/auth_repository.dart';

/// Example
/// ```dart
/// final DeleteAccountUseCase deleteAccountUseCase = DeleteAccountUseCase(repository);
///
/// final Either<Failure, bool> result = await deleteAccountUseCase();
/// ```
class DeleteAccountUseCase {
  const new(this.repository);

  final AuthRepository repository;

  Future<Either<Failure, bool>> call() async {
    return await repository.deleteAccount();
  }
}
