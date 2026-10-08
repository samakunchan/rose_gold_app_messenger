import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/credential_remembered_entity.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/repositories/cache_repository.dart';

///
/// ```dart
/// final GetRememberedCredentials getRememberedCredentials = GetRememberedCredentials(repository);
/// final Either<Failure, CredentialRememberedEntity> result = await getRememberedCredentials();
/// ```
class GetRememberedCredentials {
  const new(this.repository);

  final CacheRepository repository;

  Future<Either<Failure, CredentialRememberedEntity?>> call() {
    return repository.getCredentials();
  }
}
