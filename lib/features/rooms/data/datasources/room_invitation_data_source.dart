import 'package:rose_gold_app_messenger/features/rooms/data/models/room_invitation_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/models/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RoomInvitationDataSource {
  Future<void> sendInvitation({required String roomId, required String invitedUserId});
  Future<void> acceptInvitation({required String invitationId});
  Future<void> declineInvitation({required String invitationId});
  Future<UserProfileModel?> searchUserByTag({required String userTag});
  Stream<List<RoomInvitationModel>> receivedInvitationsStream();
}

class RoomInvitationDataSourceImpl extends RoomInvitationDataSource {
  new({required this.client});

  final SupabaseClient client;

  @override
  Future<void> sendInvitation({required String roomId, required String invitedUserId}) async {
    await client.from('room_invitations').upsert(
      <String, String>{
        'room_id': roomId,
        'invited_user_id': invitedUserId,
        'status': 'pending',
      },
      onConflict: 'room_id,invited_user_id',
    );
  }

  @override
  Future<void> acceptInvitation({required String invitationId}) async {
    await client.from('room_invitations').update(<String, dynamic>{'status': 'accepted'}).eq('id', invitationId);
  }

  @override
  Future<void> declineInvitation({required String invitationId}) async {
    await client.from('room_invitations').update(<String, dynamic>{'status': 'declined'}).eq('id', invitationId);
  }

  @override
  Future<UserProfileModel?> searchUserByTag({required String userTag}) async {
    final String cleanTag = userTag.trim().replaceFirst(RegExp('^@'), '');
    if (cleanTag.isEmpty) return null;

    // 1. Chercher d'abord par user_tag exact (insensible à la casse)
    Map<String, dynamic>? data = await client
        .from('profiles')
        .select('id, username, user_tag, avatar_url')
        .eq('user_tag', cleanTag.toLowerCase())
        .maybeSingle();

    // 2. Si non trouvé, chercher par nom d'utilisateur exact
    data ??= await client.from('profiles').select('id, username, user_tag, avatar_url').ilike('username', cleanTag).maybeSingle();

    if (data == null) return null;
    return UserProfileModel.fromJson(data);
  }

  @override
  Stream<List<RoomInvitationModel>> receivedInvitationsStream() {
    if (client.auth.currentUser == null) {
      return const Stream<List<RoomInvitationModel>>.empty();
    }
    final String currentUserId = client.auth.currentUser!.id;
    return client.from('room_invitations').stream(primaryKey: const <String>['id']).eq('invited_user_id', currentUserId).asyncMap((
      List<Map<String, dynamic>> data,
    ) async {
      final List<Map<String, dynamic>> pending = data.where((Map<String, dynamic> item) => item['status'] == 'pending').toList();
      if (pending.isEmpty) {
        return <RoomInvitationModel>[];
      }

      try {
        final List<Map<String, dynamic>> response = await client
            .from('room_invitations')
            .select(
              'id, room_id, inviter_id, invited_user_id, status, created_at, updated_at, rooms(*), inviter:profiles!inviter_id(id, username, user_tag, avatar_url)',
            )
            .eq('invited_user_id', currentUserId)
            .eq('status', 'pending');

        return response.map(RoomInvitationModel.fromJson).toList();
      } on Exception catch (_) {
        return pending.map(RoomInvitationModel.fromJson).toList();
      }
    });
  }
}
