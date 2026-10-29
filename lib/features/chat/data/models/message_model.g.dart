// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessageModel _$MessageModelFromJson(Map<String, dynamic> json) => _MessageModel(
  id: json['id'] as String,
  roomId: json['room_id'] as String,
  senderId: json['sender_id'] as String,
  ciphertext: json['ciphertext'] as String,
  nonce: json['nonce'] as String,
  keyFingerprint: json['key_fingerprint'] as String,
  createdAt: json['created_at'] as String,
  mediaUrl: json['media_url'] as String?,
);

Map<String, dynamic> _$MessageModelToJson(_MessageModel instance) => <String, dynamic>{
  'id': instance.id,
  'room_id': instance.roomId,
  'sender_id': instance.senderId,
  'ciphertext': instance.ciphertext,
  'nonce': instance.nonce,
  'key_fingerprint': instance.keyFingerprint,
  'created_at': instance.createdAt,
  'media_url': instance.mediaUrl,
};
