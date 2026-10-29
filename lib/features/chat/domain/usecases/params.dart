import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class SendEncryptedMessageParams extends Equatable {
  const new({
    required this.roomId,
    this.plainText = '',
    this.peerPublicKeyBase64,
    this.mediaUrl,
    this.mediaBytes,
    this.mediaFileName,
    this.mediaMimeType,
  });

  final String roomId;
  final String plainText;
  final String? peerPublicKeyBase64;
  final String? mediaUrl;
  final Uint8List? mediaBytes;
  final String? mediaFileName;
  final String? mediaMimeType;

  @override
  List<Object?> get props => <Object?>[
    roomId,
    plainText,
    peerPublicKeyBase64,
    mediaUrl,
    mediaBytes,
    mediaFileName,
    mediaMimeType,
  ];
}

class GetChatMessagesStreamParams extends Equatable {
  const new({
    required this.roomId,
    this.peerPublicKeyBase64,
  });

  final String roomId;
  final String? peerPublicKeyBase64;

  @override
  List<Object?> get props => <Object?>[roomId, peerPublicKeyBase64];
}

class PublishPublicKeyParams extends Equatable {
  const new();

  @override
  List<Object?> get props => <Object?>[];
}

class SearchMessagesParams extends Equatable {
  const new({
    required this.query,
    this.roomId,
  });

  final String query;
  final String? roomId;

  @override
  List<Object?> get props => <Object?>[query, roomId];
}
