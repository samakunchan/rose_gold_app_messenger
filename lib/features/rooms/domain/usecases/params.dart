import 'package:equatable/equatable.dart';

class CreateRoomParams extends Equatable {
  const new({required this.name, this.description, this.avatarUrl});

  final String name;
  final String? description;
  final String? avatarUrl;

  @override
  List<Object?> get props => <Object?>[name];
}

class UpdateRoomParams extends Equatable {
  const new({required this.name, required this.roomId, this.description, this.avatarUrl});

  final String roomId;
  final String name;
  final String? description;
  final String? avatarUrl;

  @override
  List<Object?> get props => <Object?>[roomId, name];
}

class DeleteRoomParams extends Equatable {
  const new({required this.roomId});

  final String roomId;

  @override
  List<Object?> get props => <Object?>[roomId];
}

class GetRoomMembersParams extends Equatable {
  const new({required this.roomId});

  final String roomId;

  @override
  List<Object?> get props => <Object?>[roomId];
}

class SendInvitationParams extends Equatable {
  const new({required this.roomId, required this.invitedUserId});

  /// Id de l'invitation.
  final String invitedUserId;

  /// Id du salon.
  final String roomId;

  @override
  List<Object?> get props => <Object?>[roomId, invitedUserId];
}

class InvitationParams extends Equatable {
  const new({required this.invitationId});

  /// Id de l'invitation.
  final String invitationId;

  @override
  List<Object?> get props => <Object?>[invitationId];
}

class InvitationUserParams extends Equatable {
  const new({required this.invitedUserId});

  /// Id de l'utilisateur qui invite.
  final String invitedUserId;

  @override
  List<Object?> get props => <Object?>[invitedUserId];
}

class SearchUserByTagParams extends Equatable {
  const new({required this.userTag});

  final String userTag;

  @override
  List<Object?> get props => <Object?>[userTag];
}
