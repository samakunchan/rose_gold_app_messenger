import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/chat/data/models/message_model.dart';
import 'package:rose_gold_app_messenger/features/chat/data/models/user_public_key_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ChatRemoteDataSource {
  Future<void> publishPublicKey({
    required String publicKey,
    required String fingerprint,
  });
  Future<UserPublicKeyModel?> getPeerPublicKey({required String userId});
  Future<List<String>> getActiveRoomPeerPublicKeys({required String roomId});
  Future<List<String>> getPublicKeysByUserIds({required List<String> userIds});
  Future<List<Map<String, dynamic>>> getRoomKeysForUser({required String roomId, required String userId});
  Future<Map<String, dynamic>?> getLatestRoomKeyForUser({required String roomId, required String userId});
  Future<void> saveRoomKeys({required List<Map<String, dynamic>> roomKeys});
  Future<Map<String, String>> getRoomMembersPublicKeys({required String roomId});
  Future<List<String>> getExistingRoomKeyUserIds({required String roomId, String? fingerprint});
  Future<({DateTime? joinedAt, DateTime? updatedAt})?> getMemberTimestamps({
    required String roomId,
    required String userId,
  });
  Future<Map<String, ({String username, String? avatarUrl})>> getProfilesByUserIds({
    required List<String> userIds,
  });
  Future<MessageModel> sendMessage({
    required String roomId,
    required String ciphertext,
    required String nonce,
    required String fingerprint,
    String? mediaUrl,
  });
  Stream<List<MessageModel>> messagesStream({required String roomId});
  Future<String> uploadEncryptedMedia({
    required Uint8List encryptedBytes,
    required String fileExtension,
  });
  Future<Uint8List> downloadEncryptedMedia({required String storagePath});
}

class ChatRemoteDataSourceImpl extends ChatRemoteDataSource {
  new({required this.client});

  final SupabaseClient client;

  @override
  Future<void> publishPublicKey({required String publicKey, required String fingerprint}) async {
    final User? user = client.auth.currentUser;
    if (user == null) {
      return;
    }

    final Map<String, dynamic> data = <String, dynamic>{
      'user_id': user.id,
      'public_key': publicKey,
      'key_fingerprint': fingerprint,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
    };

    await client.from('user_public_keys').upsert(data);
  }

  @override
  Future<UserPublicKeyModel?> getPeerPublicKey({required String userId}) async {
    final PostgrestMap? data = await client.from('user_public_keys').select().eq('user_id', userId).maybeSingle();

    if (data == null) {
      return null;
    }
    return UserPublicKeyModel.fromJson(data);
  }

  @override
  Future<List<String>> getActiveRoomPeerPublicKeys({required String roomId}) async {
    final String currentUserId = client.auth.currentUser?.id ?? '';
    final List<Map<String, dynamic>> members = await client
        .from('room_members')
        .select('user_id')
        .eq('room_id', roomId)
        .neq('user_id', currentUserId);

    if (members.isEmpty) {
      return <String>[];
    }

    final List<String> peerUserIds = members.map((Map<String, dynamic> m) => m['user_id'] as String).toList();

    return await getPublicKeysByUserIds(userIds: peerUserIds);
  }

  @override
  Future<List<String>> getPublicKeysByUserIds({required List<String> userIds}) async {
    if (userIds.isEmpty) {
      return <String>[];
    }

    final List<Map<String, dynamic>> keysData = await client.from('user_public_keys').select('public_key').inFilter('user_id', userIds);

    return keysData.map((Map<String, dynamic> k) => k['public_key'] as String).toList();
  }

  @override
  Future<List<Map<String, dynamic>>> getRoomKeysForUser({required String roomId, required String userId}) async {
    try {
      final List<Map<String, dynamic>> data = await client
          .from('room_keys')
          .select()
          .eq('room_id', roomId)
          .eq('user_id', userId)
          .order('created_at', ascending: true);
      return data;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Erreur getRoomKeysForUser: $e');
      }
      return <Map<String, dynamic>>[];
    }
  }

  @override
  Future<Map<String, dynamic>?> getLatestRoomKeyForUser({required String roomId, required String userId}) async {
    try {
      final List<Map<String, dynamic>> data = await client
          .from('room_keys')
          .select()
          .eq('room_id', roomId)
          .eq('user_id', userId)
          .order('created_at', ascending: false)
          .limit(1);
      return data.isNotEmpty ? data.first : null;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Erreur getLatestRoomKeyForUser: $e');
      }
      return null;
    }
  }

  @override
  Future<void> saveRoomKeys({required List<Map<String, dynamic>> roomKeys}) async {
    if (roomKeys.isEmpty) return;
    try {
      await client.from('room_keys').upsert(roomKeys, onConflict: 'room_id,user_id,key_fingerprint');
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Erreur saveRoomKeys: $e');
      }
    }
  }

  @override
  Future<Map<String, String>> getRoomMembersPublicKeys({required String roomId}) async {
    try {
      final List<Map<String, dynamic>> members = await client.from('room_members').select('user_id').eq('room_id', roomId);
      final List<String> userIds = members.map((Map<String, dynamic> m) => m['user_id'] as String).toList();
      if (userIds.isEmpty) return <String, String>{};

      final List<Map<String, dynamic>> keysData = await client
          .from('user_public_keys')
          .select('user_id, public_key')
          .inFilter('user_id', userIds);

      return <String, String>{
        for (final Map<String, dynamic> row in keysData) row['user_id'] as String: row['public_key'] as String,
      };
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Erreur getRoomMembersPublicKeys: $e');
      }
      return <String, String>{};
    }
  }

  @override
  Future<List<String>> getExistingRoomKeyUserIds({required String roomId, String? fingerprint}) async {
    try {
      PostgrestFilterBuilder<List<Map<String, dynamic>>> query = client.from('room_keys').select('user_id').eq('room_id', roomId);
      if (fingerprint != null) {
        query = query.eq('key_fingerprint', fingerprint);
      }
      final List<Map<String, dynamic>> data = await query;
      return data.map((Map<String, dynamic> row) => row['user_id'] as String).toList();
    } on Exception catch (_) {
      return <String>[];
    }
  }

  @override
  Future<({DateTime? joinedAt, DateTime? updatedAt})?> getMemberTimestamps({
    required String roomId,
    required String userId,
  }) async {
    try {
      final PostgrestMap? row = await client
          .from('room_members')
          .select('joined_at, updated_at')
          .eq('room_id', roomId)
          .eq('user_id', userId)
          .maybeSingle();
      if (row == null) return null;
      final String? joinedRaw = row['joined_at'] as String?;
      final String? updatedRaw = row['updated_at'] as String?;
      return (
        joinedAt: joinedRaw != null ? DateTime.tryParse(joinedRaw)?.toUtc() : null,
        updatedAt: updatedRaw != null ? DateTime.tryParse(updatedRaw)?.toUtc() : null,
      );
    } on Exception catch (_) {
      return null;
    }
  }

  @override
  Future<Map<String, ({String username, String? avatarUrl})>> getProfilesByUserIds({
    required List<String> userIds,
  }) async {
    if (userIds.isEmpty) {
      return <String, ({String username, String? avatarUrl})>{};
    }
    try {
      final List<Map<String, dynamic>> rows = await client
          .from('profiles')
          .select('id, username, user_tag, avatar_url')
          .inFilter('id', userIds);

      final Map<String, ({String username, String? avatarUrl})> result =
          <String, ({String username, String? avatarUrl})>{};
      for (final Map<String, dynamic> row in rows) {
        final String id = row['id'] as String;
        final String? rawUsername = row['username'] as String?;
        final String? rawTag = row['user_tag'] as String?;
        final String username = (rawUsername != null && rawUsername.trim().isNotEmpty)
            ? rawUsername.trim()
            : ((rawTag != null && rawTag.trim().isNotEmpty) ? rawTag.trim() : 'Utilisateur');
        final String? avatarUrl = row['avatar_url'] as String?;
        result[id] = (username: username, avatarUrl: avatarUrl);
      }
      return result;
    } on Exception catch (_) {
      return <String, ({String username, String? avatarUrl})>{};
    }
  }

  @override
  Future<MessageModel> sendMessage({
    required String roomId,
    required String ciphertext,
    required String nonce,
    required String fingerprint,
    String? mediaUrl,
  }) async {
    final String currentUserId = client.auth.currentUser!.id;
    final Map<String, dynamic> data = <String, dynamic>{
      'room_id': roomId,
      'sender_id': currentUserId,
      'ciphertext': ciphertext,
      'nonce': nonce,
      'key_fingerprint': fingerprint,
      'media_url': mediaUrl,
    };

    final PostgrestMap created = await client.from('messages').insert(data).select().single();

    return MessageModel.fromJson(created);
  }

  @override
  Stream<List<MessageModel>> messagesStream({required String roomId}) {
    return client
        .from('messages')
        .stream(primaryKey: <String>['id'])
        .eq('room_id', roomId)
        .order('created_at', ascending: true)
        .map((List<Map<String, dynamic>> list) => list.map(MessageModel.fromJson).toList());
  }

  @override
  Future<String> uploadEncryptedMedia({
    required Uint8List encryptedBytes,
    required String fileExtension,
  }) async {
    final String currentUserId = client.auth.currentUser!.id;
    final int timestamp = DateTime.now().millisecondsSinceEpoch;
    final int randomSuffix = Random.secure().nextInt(1000000);
    final String ext = fileExtension.replaceAll('.', '');
    final String path = '$currentUserId/${timestamp}_$randomSuffix.$ext.enc';

    await client.storage
        .from('chat-attachments-encrypted')
        .uploadBinary(
          path,
          encryptedBytes,
          fileOptions: const FileOptions(
            contentType: 'application/octet-stream',
          ),
        );

    return path;
  }

  @override
  Future<Uint8List> downloadEncryptedMedia({required String storagePath}) async {
    final Uint8List bytes = await client.storage.from('chat-attachments-encrypted').download(storagePath);
    return bytes;
  }
}
