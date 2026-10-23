import 'package:material_ui/material_ui.dart';
import 'package:settings_ui/settings_ui.dart';

class AboutSettingsSection extends AbstractSettingsSection {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: const Text('À propos & Légal'),
      tiles: <AbstractSettingsTile>[
        SettingsTile.navigation(
          leading: const Icon(Icons.bug_report_outlined),
          title: const Text('Signaler un bug / Envoyer un retour'),
          onPressed: (_) {},
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.privacy_tip_outlined),
          title: const Text('Politique de confidentialité'),
          onPressed: (_) {},
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.description_outlined),
          title: const Text('Conditions Générales d’Utilisation'),
          onPressed: (_) {},
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.code_outlined),
          title: const Text('Licences open-source'),
          onPressed: (BuildContext context) => showLicensePage(context: context),
        ),
        SettingsTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('Version'),
          value: const Text('0.6.0 (1)'),
        ),
      ],
    );
  }
}
