import 'dart:async';

import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_invitation_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/user_profile_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/accept_invitation_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/decline_invitation_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/receive_invitation_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/search_user_by_tag_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/send_invitation_use_case.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_members_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/rooms_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_invitation_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/user_profile_view_model.dart';
import 'package:signals_flutter/signals_core.dart';

class RoomInvitationsSignals {
  new({
    required this.sendInvitationUseCase,
    required this.acceptInvitationUseCase,
    required this.declineInvitationUseCase,
    required this.receiveInvitationUseCase,
    required this.searchUserByTagUseCase,
    required this.roomsSignals,
  });

  final SendInvitationUseCase sendInvitationUseCase;
  final AcceptInvitationUseCase acceptInvitationUseCase;
  final DeclineInvitationUseCase declineInvitationUseCase;
  final ReceiveInvitationUseCase receiveInvitationUseCase;
  final SearchUserByTagUseCase searchUserByTagUseCase;
  final RoomsSignals roomsSignals;

  final Signal<bool> isLoading = .new(false);
  final Signal<String?> errorInvitation = .new(null);

  final Signal<UserProfileViewModel?> searchedUser = .new(null);
  final Signal<bool> isSearching = .new(false);
  final Signal<String?> searchError = .new(null);
  final Signal<String?> invitationSuccessMessage = .new(null);

  final Signal<List<RoomInvitationViewModel>> invitations = signal<List<RoomInvitationViewModel>>(<RoomInvitationViewModel>[]);

  StreamSubscription<List<RoomInvitationEntity>>? _invitationsSubscription;

  Future<void> sendInvitation({required String roomId, required String invitedUserId}) async {
    isLoading.value = true;
    errorInvitation.value = null;
    final Either<Failure, bool> result = await sendInvitationUseCase(SendInvitationParams(roomId: roomId, invitedUserId: invitedUserId));

    await result.fold(
      ifLeft: (Failure failure) async {
        isLoading.value = false;
        errorInvitation.value = failure.message;
        invitationSuccessMessage.value = null;
        if (kDebugMode) {
          print(failure);
        }
      },
      ifRight: (bool entity) async {
        isLoading.value = false;
        errorInvitation.value = null;
        invitationSuccessMessage.value = 'Invitation envoyée avec succès !';
      },
    );
  }

  Future<void> searchUserByTag({required String userTag}) async {
    final String cleanTag = userTag.trim().replaceFirst(RegExp('^@'), '');
    if (cleanTag.isEmpty) {
      searchError.value = 'Veuillez saisir un identifiant.';
      searchedUser.value = null;
      return;
    }

    isSearching.value = true;
    searchError.value = null;
    searchedUser.value = null;
    invitationSuccessMessage.value = null;

    final Either<Failure, UserProfileEntity?> result = await searchUserByTagUseCase(
      SearchUserByTagParams(userTag: cleanTag),
    );

    result.fold(
      ifLeft: (Failure failure) {
        isSearching.value = false;
        searchError.value = failure.message;
        searchedUser.value = null;
      },
      ifRight: (UserProfileEntity? entity) {
        isSearching.value = false;
        if (entity == null) {
          searchError.value = 'Aucun utilisateur trouvé avec l‘identifiant "$cleanTag".';
          searchedUser.value = null;
        } else {
          searchError.value = null;
          searchedUser.value = UserProfileViewModel(entity);
        }
      },
    );
  }

  void clearSearch() {
    searchedUser.value = null;
    searchError.value = null;
    invitationSuccessMessage.value = null;
  }

  Future<void> acceptInvitation({required String invitationId}) async {
    isLoading.value = true;
    final Either<Failure, bool> result = await acceptInvitationUseCase(InvitationParams(invitationId: invitationId));

    await result.fold(
      ifLeft: (Failure failure) async {
        isLoading.value = false;
        errorInvitation.value = failure.message;
        if (kDebugMode) {
          print(failure);
        }
      },
      ifRight: (bool entity) async {
        isLoading.value = false;
        errorInvitation.value = null;
        await roomsSignals.getRooms();
        unawaited(kGetIt<RoomMembersSignals>().fetchCoMembers());
      },
    );
  }

  Future<void> declineInvitation({required String invitationId}) async {
    isLoading.value = true;
    final Either<Failure, bool> result = await declineInvitationUseCase(InvitationParams(invitationId: invitationId));

    await result.fold(
      ifLeft: (Failure failure) async {
        isLoading.value = false;
        errorInvitation.value = failure.message;
        if (kDebugMode) {
          print(failure);
        }
      },
      ifRight: (bool entity) async {
        isLoading.value = false;
        errorInvitation.value = null;
        await roomsSignals.getRooms();
        unawaited(kGetIt<RoomMembersSignals>().fetchCoMembers());
      },
    );
  }

  Future<void> receiveInvitation({required String invitedUserId}) async {
    await _invitationsSubscription?.cancel();
    _invitationsSubscription = receiveInvitationUseCase().listen(
      (List<RoomInvitationEntity> invitationEntity) {
        invitations.value = invitationEntity.map(RoomInvitationViewModel.new).toList();
      },
      onError: (Object error) {
        if (kDebugMode) {
          print('RoomInvitationsSignals receiveInvitation error: $error');
        }
      },
    );
  }
}
