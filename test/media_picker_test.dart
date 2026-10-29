import 'dart:convert';
import 'dart:typed_data';

import 'package:dart_either/dart_either.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/media/domain/entities/picked_media.dart';
import 'package:rose_gold_app_messenger/features/media/domain/repositories/media_repository.dart';
import 'package:rose_gold_app_messenger/features/media/domain/usecases/pick_image_use_case.dart';
import 'package:rose_gold_app_messenger/features/media/domain/usecases/pick_video_use_case.dart';
import 'package:rose_gold_app_messenger/features/media/domain/usecases/upload_public_avatar_use_case.dart';

class FakeMediaRepository implements MediaRepository {
  PickedMedia? stubPickedMedia;
  String? stubUploadedUrl;

  @override
  Future<Either<Failure, PickedMedia?>> pickImageFromCamera({int imageQuality = 85}) async {
    return Right<Failure, PickedMedia?>(stubPickedMedia);
  }

  @override
  Future<Either<Failure, PickedMedia?>> pickImageFromGallery({int imageQuality = 85}) async {
    return Right<Failure, PickedMedia?>(stubPickedMedia);
  }

  @override
  Future<Either<Failure, PickedMedia?>> pickVideoFromGallery() async {
    return Right<Failure, PickedMedia?>(stubPickedMedia);
  }

  @override
  Future<Either<Failure, String>> uploadPublicAvatar({
    required Uint8List bytes,
    required String fileExtension,
    String? mimeType,
    String? customPrefix,
  }) async {
    if (stubUploadedUrl != null) {
      return Right<Failure, String>(stubUploadedUrl!);
    }
    return const Left<Failure, String>(ServerFailure());
  }
}

void main() {
  test('PickedMedia entity computes properties correctly', () {
    final Uint8List fakeBytes = Uint8List.fromList(utf8.encode('image content'));
    final PickedMedia media = PickedMedia(
      bytes: fakeBytes,
      fileName: 'avatar.png',
      fileSize: fakeBytes.length,
      mimeType: 'image/png',
    );

    expect(media.isImage, isTrue);
    expect(media.isVideo, isFalse);
    expect(media.fileExtension, equals('png'));
  });

  test('PickImageUseCase calls camera or gallery', () async {
    final PickedMedia expected = PickedMedia(
      bytes: Uint8List.fromList(<int>[1, 2, 3]),
      fileName: 'photo.jpg',
      fileSize: 3,
      mimeType: 'image/jpeg',
    );
    final FakeMediaRepository repo = FakeMediaRepository()..stubPickedMedia = expected;

    final PickImageUseCase useCase = PickImageUseCase(repository: repo);
    final Either<Failure, PickedMedia?> result = await useCase(source: ImageSource.gallery);

    expect(result.isRight, isTrue);
    expect(result.getOrNull(), equals(expected));
  });

  test('PickVideoUseCase calls gallery video', () async {
    final PickedMedia expected = PickedMedia(
      bytes: Uint8List.fromList(<int>[4, 5, 6]),
      fileName: 'clip.mp4',
      fileSize: 3,
      mimeType: 'video/mp4',
    );
    final FakeMediaRepository repo = FakeMediaRepository()..stubPickedMedia = expected;

    final PickVideoUseCase useCase = PickVideoUseCase(repository: repo);
    final Either<Failure, PickedMedia?> result = await useCase();

    expect(result.isRight, isTrue);
    expect(result.getOrNull(), equals(expected));
  });

  test('UploadPublicAvatarUseCase returns public URL on success', () async {
    final FakeMediaRepository repo = FakeMediaRepository()
      ..stubUploadedUrl = 'https://supabase.example.com/storage/v1/object/public/avatars/user/avatar.jpg';

    final UploadPublicAvatarUseCase useCase = UploadPublicAvatarUseCase(repository: repo);
    final Either<Failure, String> result = await useCase(
      bytes: Uint8List.fromList(<int>[10, 20]),
      fileExtension: 'jpg',
      customPrefix: 'profile',
    );

    expect(result.isRight, isTrue);
    expect(result.getOrNull(), equals('https://supabase.example.com/storage/v1/object/public/avatars/user/avatar.jpg'));
  });
}
