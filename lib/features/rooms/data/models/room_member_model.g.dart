// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_member_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoomMemberModel _$RoomMemberModelFromJson(Map<String, dynamic> json) => _RoomMemberModel(
  id: json['id'] as String,
  role: json['role'] as String,
  roomId: json['room_id'] as String,
  userId: json['user_id'] as String,
  joinedAt: json['joined_at'] as String,
  username: json['username'] as String?,
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$RoomMemberModelToJson(_RoomMemberModel instance) => <String, dynamic>{
  'id': instance.id,
  'role': instance.role,
  'room_id': instance.roomId,
  'user_id': instance.userId,
  'joined_at': instance.joinedAt,
  'username': instance.username,
  'avatarUrl': instance.avatarUrl,
};
