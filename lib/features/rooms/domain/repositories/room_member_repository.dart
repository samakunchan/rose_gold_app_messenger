import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_member_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/user_profile_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';

abstract class RoomMemberRepository {
  Stream<List<RoomMemberEntity>> roomMembersStream({required GetRoomMembersParams params});
  Future<Either<Failure, List<UserProfileEntity>>> getCoMembers();
  Future<Either<Failure, bool>> removeCoMembers({required GetRoomMembersParams params});
}
