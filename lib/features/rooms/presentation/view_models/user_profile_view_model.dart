import 'package:rose_gold_app_messenger/features/rooms/domain/entities/user_profile_entity.dart';

class UserProfileViewModel {
  new(UserProfileEntity entity) : _entity = entity;

  final UserProfileEntity _entity;
  UserProfileEntity get entity => _entity;

  String get id => _entity.id;
  String get username => _entity.username;
  String get userTag => _entity.userTag;
  String? get avatarUrl => _entity.avatarUrl;

  String get initial => _entity.username.isNotEmpty ? _entity.username[0].toUpperCase() : '?';
  String get displayName => '@$userTag';

  UserProfileViewModel copyWith({String? username, String? userTag, String? avatarUrl}) =>
      UserProfileViewModel(_entity.copyWith(username: username, userTag: userTag, avatarUrl: avatarUrl));
}
