import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/datasources/room_member_data_source.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/models/room_member_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/models/user_profile_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_member_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/user_profile_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_member_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';

/// Uniquement après être entrer dans un salon
class RoomMemberRepositoryImpl extends RoomMemberRepository {
  new({required this.dataSource});

  final RoomMemberDataSource dataSource;

  @override
  Stream<List<RoomMemberEntity>> roomMembersStream({required GetRoomMembersParams params}) {
    final Stream<List<RoomMemberModel>> stream = dataSource.roomMembersStream(roomId: params.roomId);

    return stream.map(
      (List<RoomMemberModel> members) => members.map((RoomMemberModel member) => member.toEntity()).toList(),
    );
  }

  @override
  Future<Either<Failure, List<UserProfileEntity>>> getCoMembers() async {
    try {
      final List<UserProfileModel> models = await dataSource.getCoMembers();
      return Right<Failure, List<UserProfileEntity>>(models.map((UserProfileModel m) => m.toEntity()).toList());
    } on Exception catch (e) {
      return Left<Failure, List<UserProfileEntity>>(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> removeCoMembers({required GetRoomMembersParams params}) async {
    try {
      final bool isRemoved = await dataSource.removeCoMembers(roomId: params.roomId);
      return Right<Failure, bool>(isRemoved);
    } on Exception catch (e) {
      return Left<Failure, bool>(ServerFailure(message: e.toString()));
    }
  }
}
