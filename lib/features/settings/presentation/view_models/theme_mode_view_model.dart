import 'dart:ui';

import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/entities/theme_mode_entity.dart';

class ThemeModeViewModel {
  new(ThemeModeEntity entity) : _entity = entity, _locale = PlatformDispatcher.instance.locale.languageCode;

  final ThemeModeEntity _entity;
  final String _locale;
  ThemeModeEntity get entity => _entity;

  String get label => _entity.label;
  ThemeMode get mode => _entity.mode;
  String get locale => _locale;
}
