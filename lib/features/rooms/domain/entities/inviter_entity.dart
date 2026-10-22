import 'package:equatable/equatable.dart';

class InviterEntity extends Equatable {
  const new({
    required this.username,
    required this.userTag,
    this.id,
    this.avatarUrl,
  });

  final String? id;
  final String username;
  final String userTag;
  final String? avatarUrl;

  @override
  List<Object?> get props => <Object?>[id, username, userTag, avatarUrl];
}
