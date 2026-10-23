import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/settings/data/models/theme_mode_model.dart';

abstract class ThemeModeDataSources {
  Future<ThemeModeModel> changeThemeMode({required ThemeMode themeMode});
}

class ThemeModeDataSourcesImpl implements ThemeModeDataSources {
  @override
  Future<ThemeModeModel> changeThemeMode({required ThemeMode themeMode}) async {
    final ThemeModeModel mode = switch (themeMode) {
      .system => ThemeModeModel(label: 'Système', mode: .system),
      .light => ThemeModeModel(label: 'Clair', mode: .light),
      .dark => ThemeModeModel(label: 'Sombre', mode: .dark),
    };

    return mode;
  }
}
