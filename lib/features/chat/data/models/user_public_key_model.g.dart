// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_public_key_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserPublicKeyModel _$UserPublicKeyModelFromJson(Map<String, dynamic> json) => _UserPublicKeyModel(
  userId: json['user_id'] as String,
  publicKey: json['public_key'] as String,
  keyFingerprint: json['key_fingerprint'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
);

Map<String, dynamic> _$UserPublicKeyModelToJson(_UserPublicKeyModel instance) => <String, dynamic>{
  'user_id': instance.userId,
  'public_key': instance.publicKey,
  'key_fingerprint': instance.keyFingerprint,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
};
