import 'dart:async';

import 'package:rose_gold_app_messenger/features/profile/data/models/profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class ProfileRemoteDataSource {
  Future<ProfileModel?> getProfile({required String userId});
  Future<ProfileModel> updateProfile({required String userId, String? username, String? avatarUrl, String? phone});
  Stream<ProfileModel> watchProfiles();
}

class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  new({required this.client});

  final SupabaseClient client;
  RealtimeChannel? _profilesChannel;
  StreamController<ProfileModel>? _controller;

  @override
  Future<ProfileModel?> getProfile({required String userId}) async {
    final Map<String, dynamic>? data = await client.from('profiles').select().eq('id', userId).maybeSingle();

    if (data == null) return null;
    return ProfileModel.fromJson(data);
  }

  @override
  Future<ProfileModel> updateProfile({required String userId, String? username, String? avatarUrl, String? phone}) async {
    final Map<String, dynamic> updates = <String, dynamic>{
      'updated_at': DateTime.now().toUtc().toIso8601String(),
      'username': ?username,
      'avatar_url': ?avatarUrl,
      'phone': ?phone,
    };

    final List<Map<String, dynamic>> updatedRows = await client.from('profiles').update(updates).eq('id', userId).select();

    if (updatedRows.isNotEmpty) {
      return ProfileModel.fromJson(updatedRows.first);
    }

    final User? currentUser = client.auth.currentUser;
    final String fallbackTag =
        currentUser?.userMetadata?['user_tag'] as String? ??
        '${(username ?? 'user').toLowerCase().replaceAll(RegExp('[^a-z0-9]'), '')}${DateTime.now().millisecondsSinceEpoch % 10000}';
    final Map<String, dynamic> insertData = <String, dynamic>{
      'id': userId,
      'username': username ?? currentUser?.userMetadata?['username'] as String? ?? 'Utilisateur',
      'user_tag': fallbackTag,
      'updated_at': DateTime.now().toUtc().toIso8601String(),
      'avatar_url': ?avatarUrl,
      'phone': ?phone,
    };

    final Map<String, dynamic> inserted = await client.from('profiles').insert(insertData).select().single();

    return ProfileModel.fromJson(inserted);
  }

  @override
  Stream<ProfileModel> watchProfiles() {
    if (_controller != null && !_controller!.isClosed) {
      return _controller!.stream;
    }

    final StreamController<ProfileModel> controller = StreamController<ProfileModel>.broadcast();
    _controller = controller;

    if (_profilesChannel != null) {
      unawaited(_profilesChannel!.unsubscribe());
      unawaited(client.removeChannel(_profilesChannel!));
    }

    final RealtimeChannel channel = client.channel('realtime:profiles_changes');
    _profilesChannel = channel;

    channel
        .onPostgresChanges(
          event: PostgresChangeEvent.all,
          schema: 'public',
          table: 'profiles',
          callback: (PostgresChangePayload payload) {
            final Map<String, dynamic> record = payload.newRecord;
            if (record.isNotEmpty) {
              controller.add(ProfileModel.fromJson(record));
            }
          },
        )
        .subscribe();

    controller.onCancel = () {
      unawaited(channel.unsubscribe());
      unawaited(client.removeChannel(channel));
      _profilesChannel = null;
      _controller = null;
    };

    return controller.stream;
  }
}
