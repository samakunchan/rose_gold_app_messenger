import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/theme_mode_signals.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';

class AppearanceBottomSheet extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ThemeModeSignals signals = kGetIt<ThemeModeSignals>();

    return SafeArea(
      child: Padding(
        padding: .only(
          left: AppSpacing.spaceMd.value,
          right: AppSpacing.spaceMd.value,
          bottom: AppSpacing.spaceMd.value,
        ),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .start,
          spacing: AppSpacing.spaceXs.value,
          children: <Widget>[
            Padding(
              padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceXs.value),
              child: Text('Apparence', style: theme.textTheme.titleMedium),
            ),
            ListTile(
              leading: const Icon(Icons.brightness_auto_outlined),
              title: const Text('Système'),
              trailing: signals.themeMode.value == .system ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
              onTap: () => Navigator.of(context).pop<ThemeMode>(.system),
            ),
            ListTile(
              leading: const Icon(Icons.light_mode_outlined),
              title: const Text('Clair'),
              trailing: signals.themeMode.value == .light ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
              onTap: () => Navigator.of(context).pop<ThemeMode>(.light),
            ),
            ListTile(
              leading: const Icon(Icons.dark_mode_outlined),
              title: const Text('Sombre'),
              trailing: signals.themeMode.value == .dark ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
              onTap: () => Navigator.of(context).pop<ThemeMode>(.dark),
            ),
          ],
        ),
      ),
    );
  }
}
