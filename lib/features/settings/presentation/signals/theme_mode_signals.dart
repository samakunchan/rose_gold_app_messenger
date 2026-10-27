import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/entities/theme_mode_entity.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/theme_mode_repository.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/change_theme_mode_use_case.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/use_cases/params.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/view_models/theme_mode_view_model.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ThemeModeSignals {
  new({
    required this.changeThemeModeUseCase,
    required this.themeModeRepository,
  }) {
    final ThemeModeViewModel saved = ThemeModeViewModel(themeModeRepository.getSavedThemeMode());
    themeMode.value = saved.mode;
    themeModeLabel.value = saved.label;
  }

  final ChangeThemeModeUseCase changeThemeModeUseCase;
  final ThemeModeRepository themeModeRepository;
  final Signal<ThemeMode> themeMode = Signal<ThemeMode>(.system);
  final Signal<String> themeModeLabel = Signal<String>('Système');

  Future<void> changeThemeMode({required ThemeMode selectedMode}) async {
    final Either<Failure, ThemeModeEntity> result = await changeThemeModeUseCase(
      ThemeModeParams(selectedThemeMode: selectedMode),
    );

    await result.fold(
      ifLeft: (Failure failure) async {
        if (kDebugMode) {
          print(failure);
        }
      },
      ifRight: (ThemeModeEntity entity) async {
        final ThemeModeViewModel viewModel = ThemeModeViewModel(entity);
        themeModeLabel.value = viewModel.label;
        themeMode.value = viewModel.mode;
      },
    );
  }
}
