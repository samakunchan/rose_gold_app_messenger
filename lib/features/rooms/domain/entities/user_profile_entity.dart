import 'package:equatable/equatable.dart';

class UserProfileEntity extends Equatable {
  const new({
    required this.id,
    required this.username,
    required this.userTag,
    this.avatarUrl,
  });

  final String id;
  final String username;
  final String userTag;
  final String? avatarUrl;

  @override
  List<Object?> get props => <Object?>[id, username, userTag, avatarUrl];
}
