import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/media/domain/repositories/media_repository.dart';

class UploadPublicAvatarUseCase {
  const new({required this.repository});

  final MediaRepository repository;

  Future<Either<Failure, String>> call({required Uint8List bytes, required String fileExtension, String? mimeType, String? customPrefix}) {
    return repository.uploadPublicAvatar(bytes: bytes, fileExtension: fileExtension, mimeType: mimeType, customPrefix: customPrefix);
  }
}
