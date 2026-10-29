import 'dart:ui';

import 'package:rose_gold_app_messenger/features/presences/presentation/view_models/user_presence_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_member_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class RoomMemberViewModel {
  new(RoomMemberEntity entity, {this.onlineUsers = const <UserPresenceViewModel>[]})
    : _entity = entity,
      _locale = PlatformDispatcher.instance.locale.languageCode;

  final RoomMemberEntity _entity;
  final String _locale;
  RoomMemberEntity get entity => _entity;
  final List<UserPresenceViewModel> onlineUsers;

  String get id => _entity.id;
  String get role => _entity.role;
  String get roomId => _entity.roomId;
  String get userId => _entity.userId;
  String get joinedAt => timeago.format(DateTime.parse(_entity.joinedAt), locale: _locale);
  String? get username => _entity.username;
  String? get avatarUrl => _entity.avatarUrl;
  UserPresenceViewModel? get _presence => onlineUsers.where((UserPresenceViewModel u) => u.userId == userId).firstOrNull;
  bool get isOnline => _presence != null;
  String? get device => _presence?.device;

  RoomMemberViewModel copyWith({String? username, String? avatarUrl, List<UserPresenceViewModel>? onlineUsers}) => RoomMemberViewModel(
    _entity.copyWith(username: username, avatarUrl: avatarUrl),
    onlineUsers: onlineUsers ?? this.onlineUsers,
  );
}
