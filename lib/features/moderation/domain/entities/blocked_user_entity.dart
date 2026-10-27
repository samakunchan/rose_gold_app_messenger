import 'package:equatable/equatable.dart';

class BlockedUserEntity extends Equatable {
  const new({
    required this.id,
    required this.blockerId,
    required this.blockedId,
    required this.createdAt,
    this.username,
    this.userTag,
    this.avatarUrl,
  });

  final String id;
  final String blockerId;
  final String blockedId;
  final String createdAt;
  final String? username;
  final String? userTag;
  final String? avatarUrl;

  @override
  List<Object?> get props => <Object?>[id, blockerId, blockedId, createdAt, username, userTag, avatarUrl];
}
