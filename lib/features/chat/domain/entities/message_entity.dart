import 'package:equatable/equatable.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/encrypted_media_attachment.dart';

class MessageEntity extends Equatable {
  const new({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.decryptedContent,
    required this.keyFingerprint,
    required this.createdAt,
    this.senderUsername,
    this.senderAvatarUrl,
    this.mediaUrl,
    this.attachment,
    this.readBy = const <String>[],
  });

  final String id;
  final String roomId;
  final String senderId;
  final String decryptedContent;
  final String keyFingerprint;
  final String createdAt;
  final String? senderUsername;
  final String? senderAvatarUrl;
  final String? mediaUrl;
  final EncryptedMediaAttachment? attachment;
  final List<String> readBy;

  @override
  List<Object?> get props => <Object?>[
    id,
    roomId,
    senderId,
    decryptedContent,
    keyFingerprint,
    createdAt,
    senderUsername,
    senderAvatarUrl,
    mediaUrl,
    attachment,
    readBy,
  ];
}
