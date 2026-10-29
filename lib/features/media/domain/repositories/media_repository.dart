import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/media/domain/entities/picked_media.dart';

abstract class MediaRepository {
  Future<Either<Failure, PickedMedia?>> pickImageFromCamera({int imageQuality = 85});
  Future<Either<Failure, PickedMedia?>> pickImageFromGallery({int imageQuality = 85});
  Future<Either<Failure, PickedMedia?>> pickVideoFromGallery();
  Future<Either<Failure, String>> uploadPublicAvatar({
    required Uint8List bytes,
    required String fileExtension,
    String? mimeType,
    String? customPrefix,
  });
}
