// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inviter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InviterModel _$InviterModelFromJson(Map<String, dynamic> json) =>
    _InviterModel(
      id: json['id'] as String?,
      username: json['username'] as String,
      userTag: json['user_tag'] as String,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$InviterModelToJson(_InviterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'user_tag': instance.userTag,
      'avatar_url': instance.avatarUrl,
    };
