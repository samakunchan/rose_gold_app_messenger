import 'package:rose_gold_app_messenger/features/profile/domain/entities/profile_entity.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/repositories/profile_repository.dart';

class WatchProfilesUseCase {
  const new(this.repository);

  final ProfileRepository repository;

  Stream<ProfileEntity> call() => repository.watchProfiles();
}
