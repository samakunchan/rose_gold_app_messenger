// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_presence_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserPresenceModel _$UserPresenceModelFromJson(Map<String, dynamic> json) => _UserPresenceModel(
  userId: json['user_id'] as String,
  username: json['username'] as String,
  device: json['device'] as String,
  onlineAt: json['online_at'] as String,
);

Map<String, dynamic> _$UserPresenceModelToJson(_UserPresenceModel instance) => <String, dynamic>{
  'user_id': instance.userId,
  'username': instance.username,
  'device': instance.device,
  'online_at': instance.onlineAt,
};
