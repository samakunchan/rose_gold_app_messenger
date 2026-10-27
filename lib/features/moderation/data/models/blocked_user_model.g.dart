// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'blocked_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BlockedUserModel _$BlockedUserModelFromJson(Map<String, dynamic> json) =>
    _BlockedUserModel(
      id: json['id'] as String,
      blockerId: json['blocker_id'] as String,
      blockedId: json['blocked_id'] as String,
      createdAt: json['created_at'] as String,
      username: json['username'] as String?,
      userTag: json['user_tag'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$BlockedUserModelToJson(_BlockedUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'blocker_id': instance.blockerId,
      'blocked_id': instance.blockedId,
      'created_at': instance.createdAt,
      'username': instance.username,
      'user_tag': instance.userTag,
      'avatar_url': instance.avatarUrl,
    };
