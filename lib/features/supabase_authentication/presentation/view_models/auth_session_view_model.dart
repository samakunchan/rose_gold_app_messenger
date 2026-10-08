import 'dart:ui';

import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/auth_session_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class AuthSessionViewModel {
  new(AuthSessionEntity entity) : _entity = entity, _locale = PlatformDispatcher.instance.locale.languageCode;

  final AuthSessionEntity _entity;
  final String _locale;
  AuthSessionEntity get entity => _entity;

  String get username => _entity.username ?? '';
  String get lastConnectionAt => timeago.format(DateTime.parse(_entity.lastSignInAt ?? DateTime.now().toString()), locale: _locale);
  String get accountCreatedAt => timeago.format(DateTime.parse(_entity.createdAt), locale: _locale);
}
