import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rose_gold_app_messenger/features/media/domain/entities/picked_media.dart';

abstract class MediaPickerDataSource {
  Future<PickedMedia?> pickImageFromCamera({int imageQuality = 85});
  Future<PickedMedia?> pickImageFromGallery({int imageQuality = 85});
  Future<PickedMedia?> pickVideoFromGallery();
}

class MediaPickerDataSourceImpl extends MediaPickerDataSource {
  new({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<PickedMedia?> _convertXFile(XFile? file, {required bool isVideo}) async {
    if (file == null) {
      return null;
    }

    final Uint8List bytes = await file.readAsBytes();
    final String fileName = file.name;
    final String extension = fileName.split('.').last.toLowerCase();

    String mimeType = file.mimeType ?? '';
    if (mimeType.isEmpty) {
      if (isVideo || extension == 'mp4' || extension == 'mov') {
        mimeType = 'video/$extension';
      } else {
        final String imgExt = extension == 'jpg' ? 'jpeg' : extension;
        mimeType = 'image/$imgExt';
      }
    }

    return PickedMedia(
      bytes: bytes,
      fileName: fileName,
      fileSize: bytes.length,
      mimeType: mimeType,
      path: file.path,
    );
  }

  @override
  Future<PickedMedia?> pickImageFromCamera({int imageQuality = 85}) async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: imageQuality,
    );
    return await _convertXFile(file, isVideo: false);
  }

  @override
  Future<PickedMedia?> pickImageFromGallery({int imageQuality = 85}) async {
    final XFile? file = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: imageQuality,
    );
    return await _convertXFile(file, isVideo: false);
  }

  @override
  Future<PickedMedia?> pickVideoFromGallery() async {
    final XFile? file = await _picker.pickVideo(source: ImageSource.gallery);
    return await _convertXFile(file, isVideo: true);
  }
}
