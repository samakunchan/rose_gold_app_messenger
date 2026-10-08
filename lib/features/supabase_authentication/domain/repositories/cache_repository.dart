import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/credential_remembered_entity.dart';

/// Interface de CacheRepositoryImpl
/// ```groovy
///     CacheRepository     => Interface
///           ↓
///     CacheRepositoryImpl => Codes Metier
/// ```
abstract class CacheRepository {
  Future<Either<Failure, CredentialRememberedEntity?>> getCredentials();
}
