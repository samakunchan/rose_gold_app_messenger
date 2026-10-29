import 'dart:typed_data';

import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/encrypted_media_attachment.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/repositories/chat_repository.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';

class DownloadAndDecryptMediaUseCase {
  const new({required this.repository});

  final ChatRepository repository;

  Future<Either<Failure, Uint8List>> call(EncryptedMediaAttachment attachment) {
    return repository.downloadAndDecryptMedia(attachment: attachment);
  }
}
