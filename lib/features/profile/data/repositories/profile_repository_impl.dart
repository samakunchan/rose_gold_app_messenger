import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:rose_gold_app_messenger/features/profile/data/models/profile_model.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/entities/profile_entity.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  new({required this.remoteDataSource});

  final ProfileRemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, ProfileEntity?>> getProfile({required String userId}) async {
    try {
      final ProfileModel? model = await remoteDataSource.getProfile(userId: userId);
      return Right<Failure, ProfileEntity?>(model?.toEntity());
    } on Object catch (e, stack) {
      if (kDebugMode) {
        print('Erreur getProfile: $e\n$stack');
      }
      return Left<Failure, ProfileEntity?>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile({required String userId, String? username, String? avatarUrl, String? phone}) async {
    try {
      final ProfileModel model = await remoteDataSource.updateProfile(userId: userId, username: username, avatarUrl: avatarUrl, phone: phone);
      return Right<Failure, ProfileEntity>(model.toEntity());
    } on Object catch (e, stack) {
      if (kDebugMode) {
        print('Erreur updateProfile: $e\n$stack');
      }
      return Left<Failure, ProfileEntity>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Stream<ProfileEntity> watchProfiles() {
    return remoteDataSource.watchProfiles().map((ProfileModel model) => model.toEntity());
  }
}
