import 'dart:ui';

import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/auth_session_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class AuthSessionViewModel {
  new(AuthSessionEntity entity) : _entity = entity, _locale = PlatformDispatcher.instance.locale.languageCode;

  final AuthSessionEntity _entity;
  final String _locale;
  AuthSessionEntity get entity => _entity;

  String get userId => _entity.id;
  String get username => _entity.username ?? '';
  String get userTag => _entity.userMetadataEntity.userTag ?? '';
  String get avatarUrl => _entity.avatarUrl ?? _entity.userMetadataEntity.avatarUrl ?? '';
  String get phoneNumber => _entity.phoneNumber ?? _entity.userMetadataEntity.phoneNumber ?? '';
  String get lastConnectionAt => timeago.format(DateTime.parse(_entity.lastSignInAt ?? DateTime.now().toString()), locale: _locale);
  String get accountCreatedAt => timeago.format(DateTime.parse(_entity.createdAt), locale: _locale);
}
