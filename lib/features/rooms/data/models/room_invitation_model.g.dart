// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_invitation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoomInvitationModel _$RoomInvitationModelFromJson(Map<String, dynamic> json) =>
    _RoomInvitationModel(
      id: json['id'] as String,
      roomId: json['room_id'] as String,
      inviterId: json['inviter_id'] as String,
      invitedUserId: json['invited_user_id'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      status: json['status'] as String,
      inviter: json['inviter'] == null
          ? null
          : InviterModel.fromJson(json['inviter'] as Map<String, dynamic>),
      room: json['rooms'] == null
          ? null
          : RoomModel.fromJson(json['rooms'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$RoomInvitationModelToJson(
  _RoomInvitationModel instance,
) => <String, dynamic>{
  'id': instance.id,
  'room_id': instance.roomId,
  'inviter_id': instance.inviterId,
  'invited_user_id': instance.invitedUserId,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'status': instance.status,
  'inviter': instance.inviter,
  'rooms': instance.room,
};
