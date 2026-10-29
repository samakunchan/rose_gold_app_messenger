import 'dart:ui';

import 'package:rose_gold_app_messenger/features/chat/domain/entities/encrypted_media_attachment.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/message_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class MessageViewModel {
  new(this.entity, {required this.currentUserId}) : _locale = PlatformDispatcher.instance.locale.languageCode;

  final MessageEntity entity;
  final String currentUserId;
  final String _locale;

  String get id => entity.id;
  String get roomId => entity.roomId;
  String get senderId => entity.senderId;
  String get content => entity.decryptedContent;
  String? get mediaUrl => entity.mediaUrl;
  EncryptedMediaAttachment? get attachment => entity.attachment;
  bool get hasMedia => entity.attachment != null;
  bool get isImage => entity.attachment?.mimeType.startsWith('image/') ?? false;
  bool get isVideo => entity.attachment?.mimeType.startsWith('video/') ?? false;
  String? get mediaFileName => entity.attachment?.fileName;
  int? get mediaFileSize => entity.attachment?.fileSize;
  String get keyFingerprint => entity.keyFingerprint;
  bool get isMe => entity.senderId == currentUserId;
  String get createdAt => timeago.format(DateTime.parse(entity.createdAt), locale: _locale);
}
