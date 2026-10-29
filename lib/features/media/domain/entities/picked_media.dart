import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class PickedMedia extends Equatable {
  const new({
    required this.bytes,
    required this.fileName,
    required this.fileSize,
    required this.mimeType,
    this.path,
  });

  final Uint8List bytes;
  final String fileName;
  final int fileSize;
  final String mimeType;
  final String? path;

  bool get isImage => mimeType.startsWith('image/');
  bool get isVideo => mimeType.startsWith('video/');

  String get fileExtension {
    final List<String> parts = fileName.split('.');
    if (parts.length > 1) {
      return parts.last.toLowerCase();
    }
    if (mimeType.contains('/')) {
      return mimeType.split('/').last.toLowerCase();
    }
    return 'bin';
  }

  @override
  List<Object?> get props => <Object?>[fileName, fileSize, mimeType, path];
}
