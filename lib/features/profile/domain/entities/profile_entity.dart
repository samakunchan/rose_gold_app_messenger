import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
  const new({
    required this.id,
    required this.username,
    required this.userTag,
    this.avatarUrl,
    this.phone,
    this.publicKey,
    this.createdAt,
    this.updatedAt,
  });

  final String id;
  final String username;
  final String userTag;
  final String? avatarUrl;
  final String? phone;
  final String? publicKey;
  final String? createdAt;
  final String? updatedAt;

  @override
  List<Object?> get props => <Object?>[id, username, userTag, avatarUrl, phone, publicKey, createdAt, updatedAt];
}
