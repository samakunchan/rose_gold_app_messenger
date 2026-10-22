import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/user_profile_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_member_repository.dart';

/// Récupère la liste des utlilisateurs connectés de tout mes salons.
class GetCoMembersUseCase {
  const new(this.repository);

  final RoomMemberRepository repository;

  Future<Either<Failure, List<UserProfileEntity>>> call() async {
    return await repository.getCoMembers();
  }
}
