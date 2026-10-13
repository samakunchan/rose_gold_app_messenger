import 'dart:async';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/entities/user_presence_entity.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/usecases/get_connected_users.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/usecases/join_global_channel_use_case.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/usecases/leave_global_channel_use_case.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/usecases/params.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/usecases/track_presence_use_case.dart';
import 'package:rose_gold_app_messenger/features/presences/presentation/view_models/user_presence_view_model.dart';
import 'package:signals_flutter/signals_core.dart';

class UserPresenceSignals {
  new({
    required this.joinGlobalChannelUseCase,
    required this.trackPresenceUseCase,
    required this.getConnectedUsersUseCase,
    required this.leaveGlobalChannelUseCase,
  });
  final JoinGlobalChannelUseCase joinGlobalChannelUseCase;
  final TrackPresenceUseCase trackPresenceUseCase;
  final GetConnectedUsersUseCase getConnectedUsersUseCase;
  final LeaveGlobalChannelUseCase leaveGlobalChannelUseCase;

  final Signal<bool> isConnectedToGlobalChannel = signal<bool>(false);
  final Signal<bool> isPresenceTracked = signal<bool>(false);
  final Signal<List<UserPresenceViewModel>> onlineUsers = signal<List<UserPresenceViewModel>>(<UserPresenceViewModel>[]);

  StreamSubscription<List<UserPresenceEntity>>? _presenceSubscription;

  Future<void> joinGlobalChannel({required String userId, required String username, required String device}) async {
    // 1. Ecouter les utilisateurs
    await _startListeningToUsers();
    // 2. Rejoindre le canal Supabase
    final Either<Failure, bool> result = await joinGlobalChannelUseCase();

    await result.fold(
      ifLeft: (Failure failure) async {
        await _presenceSubscription?.cancel();
        _presenceSubscription = null;
        isConnectedToGlobalChannel.value = false;
      },
      ifRight: (bool value) async {
        isConnectedToGlobalChannel.value = value;
        await _trackPresence(userId: userId, username: username, device: device);
      },
    );
  }

  Future<void> leaveGlobalChannel() async {
    await _presenceSubscription?.cancel();
    _presenceSubscription = null;
    onlineUsers.value = <UserPresenceViewModel>[];

    final Either<Failure, bool> result = await leaveGlobalChannelUseCase();

    await result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print('ifLeft: $failure');
        }
        isConnectedToGlobalChannel.value = false;
      },
      ifRight: (bool value) async {
        isConnectedToGlobalChannel.value = false;
        isPresenceTracked.value = false;
      },
    );
  }

  Future<void> _trackPresence({required String userId, required String username, required String device}) async {
    final Either<Failure, bool> result = await trackPresenceUseCase(
      PresenceParams(userId: userId, username: username, device: device),
    );

    result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print('ifLeft: $failure');
        }
        isPresenceTracked.value = false;
      },
      ifRight: (bool value) {
        isPresenceTracked.value = value;
      },
    );
  }

  /// A exécuter en premier. S'abonner au flux EN PREMIER pour ne rien rater.
  Future<void> _startListeningToUsers() async {
    await _presenceSubscription?.cancel(); // Évite les doublons d'abonnements
    _presenceSubscription = getConnectedUsersUseCase().listen((List<UserPresenceEntity> users) {
      onlineUsers.value = users.map(UserPresenceViewModel.new).toList();
    });
  }
}
