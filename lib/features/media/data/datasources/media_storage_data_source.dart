import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class MediaStorageDataSource {
  Future<String> uploadPublicAvatar({
    required Uint8List bytes,
    required String fileExtension,
    String? customPrefix,
  });
}

class MediaStorageDataSourceImpl extends MediaStorageDataSource {
  new({required this.client});

  final SupabaseClient client;

  @override
  Future<String> uploadPublicAvatar({
    required Uint8List bytes,
    required String fileExtension,
    String? customPrefix,
  }) async {
    final String currentUserId = client.auth.currentUser!.id;
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    final int randomSuffix = Random.secure().nextInt(1000000);
    final String ext = fileExtension.replaceAll('.', '').toLowerCase();

    final String prefix = customPrefix != null ? '${customPrefix}_' : '';
    final String path = '$currentUserId/$prefix${timestamp}_$randomSuffix.$ext';

    await client.storage.from('avatars').uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(
            contentType: 'image/$ext',
          ),
        );

    return client.storage.from('avatars').getPublicUrl(path);
  }
}
