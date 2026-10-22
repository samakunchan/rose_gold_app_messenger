// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => _RoomModel(
  id: json['id'] as String,
  name: json['name'] as String,
  createdBy: json['created_by'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  avatarUrl: json['avatar_url'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$RoomModelToJson(_RoomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'created_by': instance.createdBy,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'avatar_url': instance.avatarUrl,
      'description': instance.description,
    };
