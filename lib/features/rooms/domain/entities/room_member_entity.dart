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

  RoomMemberEntity copyWith({String? id, String? role, String? roomId, String? userId, String? joinedAt, String? username, String? avatarUrl}) =>
      RoomMemberEntity(
        id: id ?? this.id,
        role: role ?? this.role,
        roomId: roomId ?? this.roomId,
        userId: userId ?? this.userId,
        joinedAt: joinedAt ?? this.joinedAt,
        username: username ?? this.username,
        avatarUrl: avatarUrl ?? this.avatarUrl,
      );
}
