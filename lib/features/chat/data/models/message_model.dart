import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_model.freezed.dart';
part 'message_model.g.dart';

@freezed
abstract class MessageModel with _$MessageModel {
  factory({
    required String id,
    @JsonKey(name: 'room_id') required String roomId,
    @JsonKey(name: 'sender_id') required String senderId,
    required String ciphertext,
    required String nonce,
    @JsonKey(name: 'key_fingerprint') required String keyFingerprint,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'media_url') String? mediaUrl,
  }) = _MessageModel;

  factory fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);
}
