import 'package:rose_gold_app_messenger/features/presences/domain/entities/user_presence_entity.dart';

class UserPresenceViewModel {
  new(UserPresenceEntity entity) : _entity = entity;

  final UserPresenceEntity _entity;
  UserPresenceEntity get entity => _entity;

  String get userId => _entity.userId;
  String get username => _entity.username;
  String get device => _entity.device;
  String get onlineAt => _entity.onlineAt;
}
