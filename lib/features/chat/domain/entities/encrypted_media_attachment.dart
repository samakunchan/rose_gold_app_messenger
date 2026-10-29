import 'package:equatable/equatable.dart';

class EncryptedMediaAttachment extends Equatable {
  const new({
    required this.storagePath,
    required this.fileKeyBase64,
    required this.nonceBase64,
    required this.fileName,
    required this.fileSize,
    required this.mimeType,
  });

  factory fromJson(Map<String, dynamic> json) {
    return .new(
      storagePath: json['storage_path'] as String,
      fileKeyBase64: json['file_key'] as String,
      nonceBase64: json['nonce'] as String,
      fileName: json['file_name'] as String,
      fileSize: (json['file_size'] as num).toInt(),
      mimeType: json['mime_type'] as String,
    );
  }

  final String storagePath;
  final String fileKeyBase64;
  final String nonceBase64;
  final String fileName;
  final int fileSize;
  final String mimeType;

  Map<String, dynamic> toJson() => <String, dynamic>{
    'storage_path': storagePath,
    'file_key': fileKeyBase64,
    'nonce': nonceBase64,
    'file_name': fileName,
    'file_size': fileSize,
    'mime_type': mimeType,
  };

  @override
  List<Object?> get props => <Object?>[
    storagePath,
    fileKeyBase64,
    nonceBase64,
    fileName,
    fileSize,
    mimeType,
  ];
}
