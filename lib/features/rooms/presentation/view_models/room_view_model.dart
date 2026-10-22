import 'dart:ui';

import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_entity.dart';
import 'package:timeago/timeago.dart' as timeago;

class RoomViewModel {
  new(RoomEntity entity) : _entity = entity, _locale = PlatformDispatcher.instance.locale.languageCode;

  final RoomEntity _entity;
  final String _locale;
  RoomEntity get entity => _entity;

  String get id => _entity.id;
  String get name => _entity.name;
  String get createdBy => _entity.createdBy;
  String get createdAt => timeago.format(DateTime.parse(_entity.createdAt), locale: _locale);
  String get updatedAt => timeago.format(DateTime.parse(_entity.updatedAt), locale: _locale);
  String? get avatarUrl => _entity.avatarUrl;
  String? get description => _entity.description;
}
