import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/settings/data/models/theme_mode_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ThemeModeDataSources {
  Future<ThemeModeModel> changeThemeMode({required ThemeMode themeMode});
  ThemeModeModel getSavedThemeMode();
}

class ThemeModeDataSourcesImpl implements ThemeModeDataSources {
  new({required this.preferences});

  static const String _themeModeKey = 'local_theme_mode';
  final SharedPreferencesWithCache preferences;

  ThemeModeModel _fromThemeMode(ThemeMode themeMode) {
    return switch (themeMode) {
      .system => ThemeModeModel(label: 'Système', mode: .system),
      .light => ThemeModeModel(label: 'Clair', mode: .light),
      .dark => ThemeModeModel(label: 'Sombre', mode: .dark),
    };
  }

  @override
  Future<ThemeModeModel> changeThemeMode({required ThemeMode themeMode}) async {
    await preferences.setString(_themeModeKey, themeMode.name);

    return _fromThemeMode(themeMode);
  }

  @override
  ThemeModeModel getSavedThemeMode() {
    final String? savedMode = preferences.getString(_themeModeKey);
    final ThemeMode mode = switch (savedMode) {
      'light' => .light,
      'dark' => .dark,
      _ => .system,
    };

    return _fromThemeMode(mode);
  }
}
