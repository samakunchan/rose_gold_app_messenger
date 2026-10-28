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
  Future<MessageModel> sendMessage({
    required String roomId,
    required String ciphertext,
    required String nonce,
    required String fingerprint,
    String? mediaUrl,
  });
  Stream<List<MessageModel>> messagesStream({required String roomId});
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
}
