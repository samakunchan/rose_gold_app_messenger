import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/languages_signals.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';

class LanguageBottomSheet extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final LanguagesSignals signals = kGetIt<LanguagesSignals>();

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
              child: Text('Sélection des langues', style: theme.textTheme.titleMedium),
            ),
            ListTile(
              title: const Text('Français'),
              trailing: signals.code.value == 'fr' ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
              onTap: () => Navigator.of(context).pop<String>('fr'),
            ),
            ListTile(
              title: const Text('English'),
              trailing: signals.code.value == 'en' ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
              onTap: () => Navigator.of(context).pop<String>('en'),
            ),
            ListTile(
              title: const Text('Español'),
              trailing: signals.code.value == 'es' ? Icon(Icons.check, color: theme.colorScheme.primary) : null,
              onTap: () => Navigator.of(context).pop<String>('es'),
            ),
          ],
        ),
      ),
    );
  }
}
