import 'package:equatable/equatable.dart';

class BlockUserParams extends Equatable {
  const new({required this.blockedUserId});

  final String blockedUserId;

  @override
  List<Object?> get props => <Object?>[blockedUserId];
}

class UnblockUserParams extends Equatable {
  const new({required this.blockedUserId});

  final String blockedUserId;

  @override
  List<Object?> get props => <Object?>[blockedUserId];
}

class ReportInvitationParams extends Equatable {
  const new({
    required this.reportedUserId,
    required this.roomId,
    required this.invitationId,
    required this.reason,
    this.details,
    this.blockUser = true,
  });

  final String reportedUserId;
  final String roomId;
  final String invitationId;
  final String reason;
  final String? details;
  final bool blockUser;

  @override
  List<Object?> get props => <Object?>[reportedUserId, roomId, invitationId, reason, details, blockUser];
}

class ReportRoomParams extends Equatable {
  const new({
    required this.reportedUserId,
    required this.roomId,
    required this.reason,
    this.details,
    this.blockOwner = false,
  });

  final String reportedUserId;
  final String roomId;
  final String reason;
  final String? details;
  final bool blockOwner;

  @override
  List<Object?> get props => <Object?>[reportedUserId, roomId, reason, details, blockOwner];
}

class ReportMessageParams extends Equatable {
  const new({
    required this.reportedUserId,
    required this.roomId,
    required this.messageId,
    required this.reason,
    this.details,
    this.blockUser = false,
  });

  final String reportedUserId;
  final String roomId;
  final String messageId;
  final String reason;
  final String? details;
  final bool blockUser;

  @override
  List<Object?> get props => <Object?>[reportedUserId, roomId, messageId, reason, details, blockUser];
}
