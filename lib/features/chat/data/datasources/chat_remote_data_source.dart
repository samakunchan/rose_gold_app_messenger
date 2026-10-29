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
  Future<Map<String, dynamic>?> getRoomKeyForUser({required String roomId, required String userId});
  Future<void> saveRoomKeys({required List<Map<String, dynamic>> roomKeys});
  Future<Map<String, String>> getRoomMembersPublicKeys({required String roomId});
  Future<List<String>> getExistingRoomKeyUserIds({required String roomId});
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
  Future<Map<String, dynamic>?> getRoomKeyForUser({required String roomId, required String userId}) async {
    try {
      final PostgrestMap? data = await client
          .from('room_keys')
          .select()
          .eq('room_id', roomId)
          .eq('user_id', userId)
          .maybeSingle();
      return data;
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Erreur getRoomKeyForUser: $e');
      }
      return null;
    }
  }

  @override
  Future<void> saveRoomKeys({required List<Map<String, dynamic>> roomKeys}) async {
    if (roomKeys.isEmpty) return;
    try {
      await client.from('room_keys').upsert(roomKeys, onConflict: 'room_id,user_id');
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Erreur saveRoomKeys: $e');
      }
    }
  }

  @override
  Future<Map<String, String>> getRoomMembersPublicKeys({required String roomId}) async {
    try {
      final List<Map<String, dynamic>> members = await client
          .from('room_members')
          .select('user_id')
          .eq('room_id', roomId);
      final List<String> userIds = members.map((Map<String, dynamic> m) => m['user_id'] as String).toList();
      if (userIds.isEmpty) return <String, String>{};

      final List<Map<String, dynamic>> keysData = await client
          .from('user_public_keys')
          .select('user_id, public_key')
          .inFilter('user_id', userIds);

      return <String, String>{
        for (final Map<String, dynamic> row in keysData)
          row['user_id'] as String: row['public_key'] as String,
      };
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Erreur getRoomMembersPublicKeys: $e');
      }
      return <String, String>{};
    }
  }

  @override
  Future<List<String>> getExistingRoomKeyUserIds({required String roomId}) async {
    try {
      final List<Map<String, dynamic>> data = await client
          .from('room_keys')
          .select('user_id')
          .eq('room_id', roomId);
      return data.map((Map<String, dynamic> row) => row['user_id'] as String).toList();
    } on Exception catch (_) {
      return <String>[];
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

    await client.storage.from('chat-attachments-encrypted').uploadBinary(
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
