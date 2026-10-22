import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_member_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_member_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';

/// Récupère la liste des utlilisateurs connectés d'un salon specifique.
class GetRoomsMembersUseCase {
  new(this.repository);
  final RoomMemberRepository repository;

  Stream<List<RoomMemberEntity>> call(GetRoomMembersParams params) {
    return repository.roomMembersStream(params: params);
  }
}
