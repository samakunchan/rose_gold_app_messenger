// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => _ProfileModel(
  id: json['id'] as String,
  username: json['username'] as String,
  userTag: json['user_tag'] as String,
  avatarUrl: json['avatar_url'] as String?,
  phone: json['phone'] as String?,
  publicKey: json['public_key'] as String?,
  createdAt: json['created_at'] as String?,
  updatedAt: json['updated_at'] as String?,
);

Map<String, dynamic> _$ProfileModelToJson(_ProfileModel instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'user_tag': instance.userTag,
  'avatar_url': instance.avatarUrl,
  'phone': instance.phone,
  'public_key': instance.publicKey,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
