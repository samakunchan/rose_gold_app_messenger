// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_metadata_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserMetadataModel _$UserMetadataModelFromJson(Map<String, dynamic> json) =>
    _UserMetadataModel(
      email: json['email'] as String,
      sub: json['sub'] as String,
      targetApp: json['target_app'] as String,
      emailVerified: json['email_verified'] as bool,
      phoneVerified: json['phone_verified'] as bool,
      username: json['username'] as String?,
    );

Map<String, dynamic> _$UserMetadataModelToJson(_UserMetadataModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'sub': instance.sub,
      'target_app': instance.targetApp,
      'email_verified': instance.emailVerified,
      'phone_verified': instance.phoneVerified,
      'username': instance.username,
    };
