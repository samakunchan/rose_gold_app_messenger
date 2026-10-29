import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/entities/profile_entity.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/repositories/profile_repository.dart';

class GetProfileUseCase {
  const new({required this.repository});

  final ProfileRepository repository;

  Future<Either<Failure, ProfileEntity?>> call({required String userId}) {
    return repository.getProfile(userId: userId);
  }
}
