import 'package:rose_gold_app_messenger/extensions/string_extension.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/entities/profile_entity.dart';

class ProfileViewModel {
  new(ProfileEntity entity) : _entity = entity;

  final ProfileEntity _entity;
  ProfileEntity get entity => _entity;

  String get id => _entity.id;
  String get username => _entity.username;
  String get userTag => _entity.userTag;
  String get displayName => '@$userTag';
  String? get avatarUrl => _entity.avatarUrl;
  String? get phone => _entity.phone;
  String? get publicKey => _entity.publicKey;
  String? get createdAt => _entity.createdAt;
  String? get updatedAt => _entity.updatedAt;

  String get initial => _entity.username.isNotEmpty ? _entity.username.getInitialAvatar() : '?';
  bool get hasAvatar => _entity.avatarUrl != null && _entity.avatarUrl!.isNotEmpty;
}
