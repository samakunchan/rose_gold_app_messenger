import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MediaStorageDataSource {
  Future<String> uploadPublicAvatar({required Uint8List bytes, required String fileExtension, String? mimeType, String? customPrefix});
}

class MediaStorageDataSourceImpl extends MediaStorageDataSource {
  new({required this.client});

  final SupabaseClient client;

  @override
  Future<String> uploadPublicAvatar({required Uint8List bytes, required String fileExtension, String? mimeType, String? customPrefix}) async {
    final String currentUserId = client.auth.currentUser!.id;
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    final int randomSuffix = Random.secure().nextInt(1000000);
    final String ext = fileExtension.replaceAll('.', '').toLowerCase();

    final String prefix = customPrefix != null ? '${customPrefix}_' : '';
    final String path = '$currentUserId/$prefix${timestamp}_$randomSuffix.$ext';
    final String resolvedContentType = _resolveMimeType(ext, mimeType);

    await client.storage.from('avatars').uploadBinary(path, bytes, fileOptions: FileOptions(contentType: resolvedContentType));

    return client.storage.from('avatars').getPublicUrl(path);
  }

  String _resolveMimeType(String ext, String? explicitMimeType) {
    final String? mime = explicitMimeType?.toLowerCase().trim();
    if (mime != null && mime.isNotEmpty) {
      if (mime == 'image/jpg') {
        return 'image/jpeg';
      }
      return mime;
    }
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'webp':
        return 'image/webp';
      case 'gif':
        return 'image/gif';
      default:
        return 'image/jpeg';
    }
  }
}
