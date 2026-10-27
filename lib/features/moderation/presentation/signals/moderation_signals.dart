import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/entities/blocked_user_entity.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/usecases/block_user_use_case.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/usecases/get_blocked_users_use_case.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/usecases/params.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/usecases/report_invitation_use_case.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/usecases/unblock_user_use_case.dart';
import 'package:rose_gold_app_messenger/features/moderation/presentation/view_models/blocked_user_view_model.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ModerationSignals {
  new({
    required this.getBlockedUsersUseCase,
    required this.blockUserUseCase,
    required this.unblockUserUseCase,
    required this.reportInvitationUseCase,
  });

  final GetBlockedUsersUseCase getBlockedUsersUseCase;
  final BlockUserUseCase blockUserUseCase;
  final UnblockUserUseCase unblockUserUseCase;
  final ReportInvitationUseCase reportInvitationUseCase;

  final Signal<List<BlockedUserViewModel>> blockedUsers = signal<List<BlockedUserViewModel>>(<BlockedUserViewModel>[]);
  final Signal<bool> isLoading = signal<bool>(false);
  final Signal<String?> errorMessage = signal<String?>(null);

  Future<void> fetchBlockedUsers() async {
    isLoading.value = true;
    errorMessage.value = null;

    final Either<Failure, List<BlockedUserEntity>> result = await getBlockedUsersUseCase();

    result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print(failure);
        }
        errorMessage.value = failure.message;
        isLoading.value = false;
      },
      ifRight: (List<BlockedUserEntity> entities) {
        blockedUsers.value = entities.map(BlockedUserViewModel.new).toList();
        isLoading.value = false;
      },
    );
  }

  Future<bool> blockUser({required String blockedUserId}) async {
    isLoading.value = true;
    errorMessage.value = null;

    final Either<Failure, bool> result = await blockUserUseCase(
      BlockUserParams(blockedUserId: blockedUserId),
    );

    bool success = false;
    await result.fold(
      ifLeft: (Failure failure) async {
        errorMessage.value = failure.message;
      },
      ifRight: (bool value) async {
        success = value;
        await fetchBlockedUsers();
      },
    );

    isLoading.value = false;
    return success;
  }

  Future<bool> unblockUser({required String blockedUserId}) async {
    isLoading.value = true;
    errorMessage.value = null;

    final Either<Failure, bool> result = await unblockUserUseCase(
      UnblockUserParams(blockedUserId: blockedUserId),
    );

    bool success = false;
    result.fold(
      ifLeft: (Failure failure) {
        errorMessage.value = failure.message;
      },
      ifRight: (bool value) {
        success = value;
        blockedUsers.value = blockedUsers.value
            .where((BlockedUserViewModel u) => u.blockedUserId != blockedUserId)
            .toList();
      },
    );

    isLoading.value = false;
    return success;
  }

  Future<bool> reportInvitation({
    required String reportedUserId,
    required String roomId,
    required String invitationId,
    required String reason,
    String? details,
    bool blockUser = true,
  }) async {
    isLoading.value = true;
    errorMessage.value = null;

    final Either<Failure, bool> result = await reportInvitationUseCase(
      ReportInvitationParams(
        reportedUserId: reportedUserId,
        roomId: roomId,
        invitationId: invitationId,
        reason: reason,
        details: details,
        blockUser: blockUser,
      ),
    );

    bool success = false;
    await result.fold(
      ifLeft: (Failure failure) async {
        errorMessage.value = failure.message;
      },
      ifRight: (bool value) async {
        success = value;
        if (blockUser) {
          await fetchBlockedUsers();
        }
      },
    );

    isLoading.value = false;
    return success;
  }
}
