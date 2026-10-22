import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_member_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';

/// Utilisateur qui quitte un salon.
class LeaveOneRoom {
  new(this.repository);
  final RoomMemberRepository repository;

  Future<Either<Failure, bool>> call(GetRoomMembersParams params) async {
    return await repository.removeCoMembers(params: params);
  }
}
