import 'dart:ui';

import 'package:rose_gold_app_messenger/features/moderation/domain/entities/blocked_user_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class BlockedUserViewModel {
  new(BlockedUserEntity entity) : _entity = entity, _locale = PlatformDispatcher.instance.locale.languageCode;

  final BlockedUserEntity _entity;
  final String _locale;

  BlockedUserEntity get entity => _entity;

  String get id => _entity.id;
  String get blockedUserId => _entity.blockedId;
  String get username => _entity.username ?? 'Utilisateur';
  String? get userTag => _entity.userTag;
  String? get avatarUrl => _entity.avatarUrl;

  String get displayName => userTag != null && userTag!.isNotEmpty ? '@$userTag' : username;

  String get blockedTimeAgo {
    final DateTime? parsed = DateTime.tryParse(_entity.createdAt);
    if (parsed == null) return '';
    return timeago.format(parsed, locale: _locale);
  }
}
