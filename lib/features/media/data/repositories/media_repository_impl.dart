import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/media/data/datasources/media_picker_data_source.dart';
import 'package:rose_gold_app_messenger/features/media/data/datasources/media_storage_data_source.dart';
import 'package:rose_gold_app_messenger/features/media/domain/entities/picked_media.dart';
import 'package:rose_gold_app_messenger/features/media/domain/repositories/media_repository.dart';

class MediaRepositoryImpl extends MediaRepository {
  new({
    required this.pickerDataSource,
    required this.storageDataSource,
  });

  final MediaPickerDataSource pickerDataSource;
  final MediaStorageDataSource storageDataSource;

  @override
  Future<Either<Failure, PickedMedia?>> pickImageFromCamera({int imageQuality = 85}) async {
    try {
      final PickedMedia? media = await pickerDataSource.pickImageFromCamera(imageQuality: imageQuality);
      return Right<Failure, PickedMedia?>(media);
    } on Exception catch (e, stack) {
      if (kDebugMode) {
        print('Erreur pickImageFromCamera: $e\n$stack');
      }
      return const Left<Failure, PickedMedia?>(BadRequestFailure());
    }
  }

  @override
  Future<Either<Failure, PickedMedia?>> pickImageFromGallery({int imageQuality = 85}) async {
    try {
      final PickedMedia? media = await pickerDataSource.pickImageFromGallery(imageQuality: imageQuality);
      return Right<Failure, PickedMedia?>(media);
    } on Exception catch (e, stack) {
      if (kDebugMode) {
        print('Erreur pickImageFromGallery: $e\n$stack');
      }
      return const Left<Failure, PickedMedia?>(BadRequestFailure());
    }
  }

  @override
  Future<Either<Failure, PickedMedia?>> pickVideoFromGallery() async {
    try {
      final PickedMedia? media = await pickerDataSource.pickVideoFromGallery();
      return Right<Failure, PickedMedia?>(media);
    } on Exception catch (e, stack) {
      if (kDebugMode) {
        print('Erreur pickVideoFromGallery: $e\n$stack');
      }
      return const Left<Failure, PickedMedia?>(BadRequestFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadPublicAvatar({
    required Uint8List bytes,
    required String fileExtension,
    String? customPrefix,
  }) async {
    try {
      final String publicUrl = await storageDataSource.uploadPublicAvatar(
        bytes: bytes,
        fileExtension: fileExtension,
        customPrefix: customPrefix,
      );
      return Right<Failure, String>(publicUrl);
    } on Exception catch (e, stack) {
      if (kDebugMode) {
        print('Erreur uploadPublicAvatar: $e\n$stack');
      }
      return const Left<Failure, String>(ServerFailure());
    }
  }
}
