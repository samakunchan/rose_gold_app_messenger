import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_member_entity.dart';

part 'room_member_model.freezed.dart';
part 'room_member_model.g.dart';

@freezed
abstract class RoomMemberModel with _$RoomMemberModel {
  factory({
    required String id,
    required String role, // owner, admin, member
    @JsonKey(name: 'room_id') required String roomId,
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'joined_at') required String joinedAt,
    String? username,
    String? avatarUrl,
  }) = _RoomMemberModel;

  factory fromJson(Map<String, dynamic> json) => _$RoomMemberModelFromJson(json);
}

extension RoomMemberModelX on RoomMemberModel {
  RoomMemberEntity toEntity() => RoomMemberEntity(
    id: id,
    role: role,
    roomId: roomId,
    userId: userId,
    joinedAt: joinedAt,
    username: username,
    avatarUrl: avatarUrl,
  );
}
