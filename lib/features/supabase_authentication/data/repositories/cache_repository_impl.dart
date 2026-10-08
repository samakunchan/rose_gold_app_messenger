import 'dart:convert';

import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/data/datasources/cache_data_source.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/credential_remembered_entity.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/repositories/cache_repository.dart';

class CacheRepositoryImpl implements CacheRepository {
  new({required this.cacheDataSource});

  final CacheDataSource cacheDataSource;

  @override
  Future<Either<Failure, CredentialRememberedEntity?>> getCredentials() async {
    try {
      final String? credentials = await cacheDataSource.getSavedCredentials();
      if (credentials != null) {
        final Map<String, dynamic> json = jsonDecode(credentials) as Map<String, dynamic>;
        return Right<Failure, CredentialRememberedEntity>(
          CredentialRememberedEntity(
            email: json['email'] as String,
            password: json['password'] as String,
          ),
        );
      }
      return const Left<Failure, CredentialRememberedEntity>(CacheFailure(message: 'Pas de credentials'));
    } on Exception catch (e) {
      return Left<Failure, CredentialRememberedEntity>(CacheFailure(message: e.toString()));
    }
  }
}
