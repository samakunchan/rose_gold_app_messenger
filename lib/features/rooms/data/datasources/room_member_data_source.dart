import 'package:rose_gold_app_messenger/features/rooms/data/models/room_member_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/models/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RoomMemberDataSource {
  Stream<List<RoomMemberModel>> roomMembersStream({required String roomId});
  Future<List<UserProfileModel>> getCoMembers();
  Future<bool> removeCoMembers({required String roomId});
}

/// Uniquement après être entrer dans un salon
class RoomMemberDataSourceImpl extends RoomMemberDataSource {
  new({required this.client});

  final SupabaseClient client;

  @override
  Future<List<UserProfileModel>> getCoMembers() async {
    final List<Map<String, dynamic>> response = await client.rpc('get_my_co_members');
    return response.map(UserProfileModel.fromJson).toList();
  }

  @override
  Stream<List<RoomMemberModel>> roomMembersStream({required String roomId}) {
    return client.from('room_members').stream(primaryKey: const <String>['id']).eq('room_id', roomId).order('joined_at').asyncMap((
      List<Map<String, dynamic>> membersData,
    ) async {
      if (membersData.isEmpty) return <RoomMemberModel>[];

      // 1. On extrait tous les IDs des membres du salon
      final List<String> userIds = membersData.map((Map<String, dynamic> m) => m['user_id'] as String).toList();

      // 2. On récupère les profils en UNE SEULE requête groupée
      final List<Map<String, dynamic>> profiles = await client.from('profiles').select('id, username, avatar_url').inFilter('id', userIds);

      final Map<String, Map<String, dynamic>> profileMap = <String, Map<String, dynamic>>{
        for (final Map<String, dynamic> p in profiles) p['id'] as String: p,
      };

      // 3. On fusionne les membres avec leur profil
      return membersData.map((Map<String, dynamic> m) {
        final Map<String, dynamic>? profile = profileMap[m['user_id']];
        return RoomMemberModel(
          id: m['id'] as String,
          role: m['role'] as String,
          roomId: m['room_id'] as String,
          userId: m['user_id'] as String,
          joinedAt: m['joined_at'] as String,
          username: profile?['username'] as String?,
          avatarUrl: profile?['avatar_url'] as String?,
        );
      }).toList();
    });
  }

  @override
  Future<bool> removeCoMembers({required String roomId}) async {
    final Map<String, dynamic>? deletedRow = await client
        .from('room_members')
        .delete()
        .eq('room_id', roomId)
        .eq('user_id', client.auth.currentUser!.id)
        .select()
        .maybeSingle();
    final bool hasLeft = deletedRow != null;

    return hasLeft;
  }
}
