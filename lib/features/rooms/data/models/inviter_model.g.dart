// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inviter_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InviterModel _$InviterModelFromJson(Map<String, dynamic> json) =>
    _InviterModel(
      username: json['username'] as String,
      userTag: json['user_tag'] as String,
      id: json['id'] as String?,
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$InviterModelToJson(_InviterModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'user_tag': instance.userTag,
      'id': instance.id,
      'avatar_url': instance.avatarUrl,
    };
