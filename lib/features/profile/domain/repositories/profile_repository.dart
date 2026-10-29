import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity?>> getProfile({required String userId});
  Future<Either<Failure, ProfileEntity>> updateProfile({required String userId, String? username, String? avatarUrl, String? phone});
  Stream<ProfileEntity> watchProfiles();
}
