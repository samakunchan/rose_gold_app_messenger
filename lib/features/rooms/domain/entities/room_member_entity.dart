import 'package:equatable/equatable.dart';

class RoomMemberEntity extends Equatable {
  const new({
    required this.id,
    required this.role,
    required this.roomId,
    required this.userId,
    required this.joinedAt,
    this.username,
    this.avatarUrl,
  });

  final String id;
  final String role; // owner, admin, member
  final String roomId;
  final String userId;
  final String joinedAt;
  final String? username;
  final String? avatarUrl;

  @override
  List<Object?> get props => <Object?>[id, role, roomId, userId, joinedAt];
}
