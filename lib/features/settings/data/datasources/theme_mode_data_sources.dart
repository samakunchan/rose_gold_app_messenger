import 'package:material_ui/material_ui.dart';

abstract class ThemeModeDataSources {
  Future<ThemeMode> changeThemeMode({required ThemeMode themeMode});
}

class ThemeModeDataSourcesImpl implements ThemeModeDataSources {
  @override
  Future<ThemeMode> changeThemeMode({required ThemeMode themeMode}) async {
    return themeMode;
  }
}
