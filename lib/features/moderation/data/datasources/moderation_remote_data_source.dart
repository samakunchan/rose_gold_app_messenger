import 'package:rose_gold_app_messenger/features/moderation/data/models/blocked_user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ModerationRemoteDataSource {
  Future<List<BlockedUserModel>> getBlockedUsers();
  Future<bool> blockUser({required String blockedUserId});
  Future<bool> unblockUser({required String blockedUserId});
  Future<bool> reportInvitation({
    required String reportedUserId,
    required String roomId,
    required String invitationId,
    required String reason,
    String? details,
    bool blockUser = true,
  });
}

class ModerationRemoteDataSourceImpl implements ModerationRemoteDataSource {
  new({required this.client});

  final SupabaseClient client;

  @override
  Future<List<BlockedUserModel>> getBlockedUsers() async {
    final String? currentUserId = client.auth.currentUser?.id;
    if (currentUserId == null) {
      return <BlockedUserModel>[];
    }

    final List<Map<String, dynamic>> rows = await client
        .from('blocked_users')
        .select('id, blocker_id, blocked_id, created_at')
        .eq('blocker_id', currentUserId)
        .order('created_at', ascending: false);

    if (rows.isEmpty) {
      return <BlockedUserModel>[];
    }

    final List<String> blockedIds = rows.map((Map<String, dynamic> r) => r['blocked_id'] as String).toList();
    final List<Map<String, dynamic>> profiles = await client
        .from('profiles')
        .select('id, username, user_tag, avatar_url')
        .inFilter('id', blockedIds);

    final Map<String, Map<String, dynamic>> profileMap = <String, Map<String, dynamic>>{
      for (final Map<String, dynamic> p in profiles) p['id'] as String: p,
    };

    return rows.map((Map<String, dynamic> r) {
      final Map<String, dynamic>? profile = profileMap[r['blocked_id'] as String];
      return BlockedUserModel(
        id: r['id'] as String,
        blockerId: r['blocker_id'] as String,
        blockedId: r['blocked_id'] as String,
        createdAt: r['created_at'] as String,
        username: profile?['username'] as String?,
        userTag: profile?['user_tag'] as String?,
        avatarUrl: profile?['avatar_url'] as String?,
      );
    }).toList();
  }

  @override
  Future<bool> blockUser({required String blockedUserId}) async {
    final String? currentUserId = client.auth.currentUser?.id;
    if (currentUserId == null) {
      return false;
    }

    await client.from('blocked_users').upsert(
      <String, dynamic>{
        'blocker_id': currentUserId,
        'blocked_id': blockedUserId,
      },
      onConflict: 'blocker_id,blocked_id',
    );

    return true;
  }

  @override
  Future<bool> unblockUser({required String blockedUserId}) async {
    final String? currentUserId = client.auth.currentUser?.id;
    if (currentUserId == null) {
      return false;
    }

    await client
        .from('blocked_users')
        .delete()
        .eq('blocker_id', currentUserId)
        .eq('blocked_id', blockedUserId);

    return true;
  }

  @override
  Future<bool> reportInvitation({
    required String reportedUserId,
    required String roomId,
    required String invitationId,
    required String reason,
    String? details,
    bool blockUser = true,
  }) async {
    final String? currentUserId = client.auth.currentUser?.id;
    if (currentUserId == null) {
      return false;
    }

    await client.from('reports').insert(<String, dynamic>{
      'reporter_id': currentUserId,
      'reported_user_id': reportedUserId,
      'room_id': roomId,
      'invitation_id': invitationId,
      'reason': reason,
      if (details != null && details.trim().isNotEmpty) 'details': details.trim(),
    });

    await client
        .from('room_invitations')
        .update(<String, dynamic>{'status': 'reported'})
        .eq('id', invitationId);

    if (blockUser) {
      await this.blockUser(blockedUserId: reportedUserId);
    }

    return true;
  }
}
