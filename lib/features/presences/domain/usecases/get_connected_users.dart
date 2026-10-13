import 'package:rose_gold_app_messenger/features/presences/domain/entities/user_presence_entity.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/repositories/user_presence_repository.dart';

class GetConnectedUsersUseCase {
  new(this.repository);
  final UserPresenceRepository repository;

  Stream<List<UserPresenceEntity>> call() {
    return repository.presenceStream();
  }
}
