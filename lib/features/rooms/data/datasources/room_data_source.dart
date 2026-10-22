import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/models/room_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class RoomDataSource {
  Future<RoomModel> createRoom({required String name, String? description, String? avatarUrl});
  Future<RoomModel> updateRoom({required String name, required String roomId, String? description, String? avatarUrl});
  Stream<List<RoomModel>> roomsStream();
  Future<void> deleteRoom({required String roomId});
}

class RoomDataSourceImpl extends RoomDataSource {
  new({required this.client});

  final SupabaseClient client;

  @override
  Future<RoomModel> createRoom({required String name, String? description, String? avatarUrl}) async {
    final Map<String, dynamic> json = <String, String?>{
      'name': name,
      'description': description,
      'avatar_url': avatarUrl,
    };
    final PostgrestMap createdRoom = await client
        .from('rooms')
        .insert(json)
        .select() // Permet de récupérer immédiatement le salon créé avec son nouvel id
        .single();
    return RoomModel.fromJson(createdRoom);
  }

  @override
  Future<RoomModel> updateRoom({required String name, required String roomId, String? description, String? avatarUrl}) async {
    final Map<String, dynamic> json = <String, String?>{
      'name': name,
      'description': description,
      'avatar_url': avatarUrl, // 'https://...'  si vous changez l'image
    };
    final PostgrestMap updatedRoom = await client
        .from('rooms')
        .update(json)
        .eq('id', roomId)
        .select() // Retourne l'objet à jour
        .single();
    // if (kDebugMode) {
    //   print('Résultat du update room $updatedRoom');
    // }
    return RoomModel.fromJson(updatedRoom);
  }

  @override
  Stream<List<RoomModel>> roomsStream() {
    if (client.auth.currentUser == null) {
      return const Stream<List<RoomModel>>.empty();
    }
    final String currentUserId = client.auth.currentUser!.id;

    return client.from('room_members').stream(primaryKey: <String>['id']).eq('user_id', currentUserId).asyncMap((
      List<Map<String, dynamic>> memberRows,
    ) async {
      if (memberRows.isEmpty) {
        return <RoomModel>[];
      }

      final List<String> roomIds = memberRows.map((Map<String, dynamic> row) => row['room_id'] as String).toList();

      final List<Map<String, dynamic>> roomsData = await client.from('rooms').select().inFilter('id', roomIds).order('created_at');

      return roomsData.map(RoomModel.fromJson).toList();
    });
  }

  @override
  Future<void> deleteRoom({required String roomId}) async {
    await client.from('rooms').delete().eq('id', roomId);
    if (kDebugMode) {
      print('Salon $roomId supprimé avec succès');
    }
  }
}
