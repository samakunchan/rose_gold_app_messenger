import 'dart:ui';

import 'package:rose_gold_app_messenger/features/settings/domain/entities/language_entity.dart';

class LanguagesViewModel {
  new(LanguageEntity entity) : _entity = entity, _locale = PlatformDispatcher.instance.locale.languageCode;

  final LanguageEntity _entity;
  final String _locale;
  LanguageEntity get entity => _entity;

  String get label => _entity.label;
  String get languageCode => _entity.languageCode;
  String get locale => _locale;
}
