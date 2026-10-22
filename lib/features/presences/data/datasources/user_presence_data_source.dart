import 'dart:async';

import 'package:rose_gold_app_messenger/features/presences/data/models/user_presence_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class UserPresenceDataSource {
  /// Join le canal global
  Future<RealtimeChannel> joinGlobalChannel();

  /// Se désabonne et nettoie le canal (ex: au Logout)
  Future<void> leaveGlobalChannel();

  /// Signale la présence de l'utilisateur connecté (ID, pseudo, etc.)
  Future<ChannelResponse> trackPresence({required String userId, required String username, required String device});

  /// Arrête le signalement (passe hors ligne)
  Future<ChannelResponse> untrackPresence();

  /// Diffuse la liste des utilisateurs en ligne dès qu'un sync se produit
  Stream<List<UserPresenceModel>> presenceStream();
}

class UserPresenceDataSourceImpl extends UserPresenceDataSource {
  new({required this.client});

  final SupabaseClient client;
  final StreamController<List<SinglePresenceState>> _presenceController = StreamController<List<SinglePresenceState>>.broadcast();
  RealtimeChannel? _globalChannel;

  @override
  Future<RealtimeChannel> joinGlobalChannel() async {
    final RealtimeChannel channel = client.channel('messenger_online_users');
    _globalChannel = channel;

    return channel
        .onPresenceSync((_) {
          final List<SinglePresenceState> newState = channel.presenceState();
          // if (kDebugMode) {
          //   print('sync: $newState');
          // }
          _presenceController.add(newState);
        })
        .onPresenceJoin((RealtimePresenceJoinPayload payload) {
          // « Jean Dupont vient de se connecter » (en lisant payload.newPresences).
          // Un petit signal sonore discret quand un ami se connecte.
        })
        .onPresenceLeave((RealtimePresenceLeavePayload payload) {
          // « Marie a quitté l'application » (en lisant payload.leftPresences).
          // Un petit signal sonore discret quand un ami se connecte.
        })
        .subscribe();
  }

  @override
  Future<void> leaveGlobalChannel() async {
    if (_globalChannel != null) {
      await _globalChannel!.unsubscribe();
      await client.removeChannel(_globalChannel!);
      _globalChannel = null;
      _presenceController.add(<SinglePresenceState>[]); // Réinitialise l'état à vide
    }
  }

  @override
  Stream<List<UserPresenceModel>> presenceStream() => _presenceController.stream.map((List<SinglePresenceState> states) {
    return states
        .expand((SinglePresenceState state) => state.presences) // Aplati toutes les présences
        .map((Presence presence) => UserPresenceModel.fromJson(presence.payload))
        .toList();
  });

  @override
  Future<ChannelResponse> trackPresence({required String userId, required String username, required String device}) async {
    final Map<String, dynamic> userStatus = <String, dynamic>{
      'user_id': userId,
      'username': username,
      'online_at': DateTime.now().toIso8601String(),
      'device': device,
    };

    // Si le canal n'est pas encore initialisé, on le récupère
    final RealtimeChannel channel = _globalChannel ?? client.channel('messenger_online_users');

    return await channel.track(userStatus);
  }

  @override
  Future<ChannelResponse> untrackPresence() async {
    if (_globalChannel != null) {
      return await _globalChannel!.untrack();
    }
    return .ok;
  }
}
