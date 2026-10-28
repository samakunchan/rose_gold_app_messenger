import 'package:equatable/equatable.dart';

class MessageEntity extends Equatable {
  const new({
    required this.id,
    required this.roomId,
    required this.senderId,
    required this.decryptedContent,
    required this.keyFingerprint,
    required this.createdAt,
    this.mediaUrl,
  });

  final String id;
  final String roomId;
  final String senderId;
  final String decryptedContent;
  final String keyFingerprint;
  final String createdAt;
  final String? mediaUrl;

  @override
  List<Object?> get props => <Object?>[
        id,
        roomId,
        senderId,
        decryptedContent,
        keyFingerprint,
        createdAt,
        mediaUrl,
      ];
}
