import 'dart:ui';

import 'package:rose_gold_app_messenger/features/rooms/domain/entities/inviter_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_invitation_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class RoomInvitationViewModel {
  new(RoomInvitationEntity entity) : _entity = entity, _locale = PlatformDispatcher.instance.locale.languageCode;

  final RoomInvitationEntity _entity;
  final String _locale;
  RoomInvitationEntity get entity => _entity;

  String get id => _entity.id;
  String get roomId => _entity.roomId;
  String get inviterId => _entity.inviterId;
  String get invitedUserId => _entity.invitedUserId;
  String get createdAt => _entity.createdAt;
  String get updatedAt => _entity.updatedAt;
  String get status => _entity.status;

  InviterEntity? get inviter => _entity.inviter;
  RoomEntity? get room => _entity.room;

  String get roomName => _entity.room?.name ?? 'Salon';
  String get inviterName => _entity.inviter?.username ?? 'Un utilisateur';
  String? get inviterTag => _entity.inviter?.userTag;
  String? get inviterAvatarUrl => _entity.inviter?.avatarUrl;

  String get inviterDisplayName => inviterTag != null && inviterTag!.isNotEmpty ? '@$inviterTag' : inviterName;
  String get inviterInitial => inviterName.isNotEmpty ? inviterName[0].toUpperCase() : '?';

  String get timeAgo {
    final DateTime? parsed = DateTime.tryParse(_entity.createdAt);
    if (parsed == null) return '';
    return timeago.format(parsed, locale: _locale);
  }
}
