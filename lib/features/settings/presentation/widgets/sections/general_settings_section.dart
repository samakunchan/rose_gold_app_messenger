import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/languages_signals.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/theme_mode_signals.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/widgets/modals/appearance_bottom_sheet.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/widgets/modals/language_bottom_sheet.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:signals_flutter/signals_flutter.dart';

class GeneralSettingsSection extends AbstractSettingsSection {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeModeSignals themeModeSignals = kGetIt<ThemeModeSignals>();
    final LanguagesSignals languagesSignals = kGetIt<LanguagesSignals>();

    return SettingsSection(
      title: const Text('Général'),
      tiles: <AbstractSettingsTile>[
        SettingsTile.navigation(
          leading: const Icon(Icons.brightness_6_outlined),
          title: const Text('Apparence'),
          value: SignalBuilder(builder: (_) => Text(themeModeSignals.themeModeLabel.value)),
          onPressed: (BuildContext context) => _openAppearanceBottomSheet(context, themeModeSignals),
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.language),
          title: const Text('Langue'),
          value: SignalBuilder(builder: (_) => Text(languagesSignals.languageLabel.value)),
          onPressed: (BuildContext context) => _openLanguageBottomSheet(context, languagesSignals),
        ),
        SettingsTile.switchTile(
          leading: const Icon(Icons.notifications_outlined),
          title: const Text('Notifications'),
          initialValue: true,
          onToggle: (bool value) {},
        ),
      ],
    );
  }

  Future<void> _openAppearanceBottomSheet(BuildContext context, ThemeModeSignals signals) async {
    final ThemeMode? selectedMode = await showModalBottomSheet<ThemeMode>(
      context: context,
      showDragHandle: true,
      builder: (_) => const AppearanceBottomSheet(),
    );

    if (selectedMode != null && selectedMode != signals.themeMode.value) {
      await signals.changeThemeMode(selectedMode: selectedMode);
    }
  }

  Future<void> _openLanguageBottomSheet(BuildContext context, LanguagesSignals signals) async {
    final String? selectedLanguage = await showModalBottomSheet<String>(
      context: context,
      showDragHandle: true,
      builder: (_) => const LanguageBottomSheet(),
    );

    if (selectedLanguage != null && selectedLanguage != signals.code.value) {
      await signals.changeLangues(languageCode: selectedLanguage);
    }
  }
}
