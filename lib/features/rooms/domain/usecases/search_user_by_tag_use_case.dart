import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/user_profile_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_invitation_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';

/// Rechercher les utilisateurs depuis un salon, en vue d'une invitation ou autres.
class SearchUserByTagUseCase {
  new(this.repository);
  final RoomInvitationRepository repository;

  Future<Either<Failure, UserProfileEntity?>> call(SearchUserByTagParams params) async {
    return await repository.searchUserByTag(params: params);
  }
}
