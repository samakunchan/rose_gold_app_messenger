import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/change_theme_mode_use_case.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/params.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ThemeModeSignals {
  new({required this.changeThemeModeUseCase});
  final ChangeThemeModeUseCase changeThemeModeUseCase;
  final Signal<ThemeMode> themeMode = Signal<ThemeMode>(.system);
  final Signal<String> themeModeLabel = Signal<String>('Système');

  Future<void> changeThemeMode({required ThemeMode selectedMode}) async {
    final Either<Failure, ThemeMode> result = await changeThemeModeUseCase(
      ThemeModeParams(selectedThemeMode: selectedMode),
    );

    await result.fold(
      ifLeft: (Failure failure) async {
        if (kDebugMode) {
          print(failure);
        }
      },
      ifRight: (ThemeMode mode) async {
        themeMode.value = mode;
        themeModeLabel.value = switch (mode) {
          .system => 'Système',
          .light => 'Clair',
          .dark => 'Sombre',
        };
      },
    );
  }
}
