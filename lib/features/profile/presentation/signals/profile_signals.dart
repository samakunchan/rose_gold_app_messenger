import 'dart:async';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/entities/profile_entity.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/usecases/update_profile_use_case.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/usecases/watch_profiles_use_case.dart';
import 'package:rose_gold_app_messenger/features/profile/presentation/view_models/profile_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_members_signals.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ProfileSignals {
  new({required this.getProfileUseCase, required this.updateProfileUseCase, required this.watchProfilesUseCase});

  final GetProfileUseCase getProfileUseCase;
  final UpdateProfileUseCase updateProfileUseCase;
  final WatchProfilesUseCase watchProfilesUseCase;

  late final FlutterSignal<ProfileViewModel?> currentProfile = signal(null);
  late final FlutterSignal<bool> isLoading = signal(false);
  late final FlutterSignal<String?> errorMessage = signal(null);

  StreamSubscription<ProfileEntity>? _profilesSubscription;

  /// Écoute les modifications de profils en temps réel via Supabase Realtime (événement unitaire)
  void startListeningRealtime({RoomMembersSignals? roomMembersSignals}) {
    unawaited(_profilesSubscription?.cancel());
    _profilesSubscription = watchProfilesUseCase().listen(
      (ProfileEntity entity) {
        if (currentProfile.value?.id == entity.id) {
          currentProfile.value = ProfileViewModel(entity);
        }

        (roomMembersSignals ?? kGetIt<RoomMembersSignals>()).updateMemberProfile(
          userId: entity.id,
          username: entity.username,
          avatarUrl: entity.avatarUrl,
        );
      },
      onError: (Object error) {
        if (kDebugMode) {
          print('Erreur Realtime profiles: $error');
        }
      },
    );
  }

  /// Arrête l'écoute temps réel
  void stopListeningRealtime() {
    unawaited(_profilesSubscription?.cancel());
    _profilesSubscription = null;
  }

  Future<void> fetchProfile({required String userId}) async {
    isLoading.value = true;
    errorMessage.value = null;

    final Either<Failure, ProfileEntity?> result = await getProfileUseCase(userId: userId);

    result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print('Erreur fetchProfile: ${failure.message}');
        }
        errorMessage.value = failure.message;
      },
      ifRight: (ProfileEntity? entity) {
        if (entity != null) {
          currentProfile.value = ProfileViewModel(entity);
        }
        errorMessage.value = null;
      },
    );

    isLoading.value = false;
  }

  Future<bool> updateProfile({required String userId, String? username, String? avatarUrl, String? phone}) async {
    isLoading.value = true;
    errorMessage.value = null;

    final Either<Failure, ProfileEntity> result = await updateProfileUseCase(
      userId: userId,
      username: username,
      avatarUrl: avatarUrl,
      phone: phone,
    );

    bool success = false;
    result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print('Erreur updateProfile: ${failure.message}');
        }
        errorMessage.value = failure.message;
      },
      ifRight: (ProfileEntity entity) {
        currentProfile.value = ProfileViewModel(entity);
        errorMessage.value = null;
        success = true;
      },
    );

    isLoading.value = false;
    return success;
  }
}
