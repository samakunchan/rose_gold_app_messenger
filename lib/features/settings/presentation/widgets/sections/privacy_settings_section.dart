import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/e2ee_passphrase_bottom_sheet.dart';
import 'package:rose_gold_app_messenger/features/moderation/presentation/screens/blocked_users_screen.dart';
import 'package:settings_ui/settings_ui.dart';

class PrivacySettingsSection extends AbstractSettingsSection {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsSection(
      title: const Text('Confidentialité & RGPD'),
      tiles: <AbstractSettingsTile>[
        SettingsTile.navigation(
          leading: const Icon(Icons.vpn_key_outlined),
          title: const Text('Phrase secrète de chiffrement'),
          description: const Text('Afficher, copier ou changer votre phrase secrète E2EE'),
          onPressed: (_) {
            unawaited(E2eePassphraseBottomSheet.show(context));
          },
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.block_outlined),
          title: const Text('Utilisateurs bloqués'),
          onPressed: (_) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(builder: (_) => const BlockedUsersScreen()),
            );
          },
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.download_outlined),
          title: const Text('Exporter mes données'),
          description: const Text('Télécharger une copie de vos données personnelles'),
          onPressed: (_) {},
        ),
        SettingsTile.switchTile(
          leading: const Icon(Icons.analytics_outlined),
          title: const Text('Partage des données de diagnostic'),
          description: const Text('Aider à améliorer l’application'),
          initialValue: true,
          onToggle: (bool value) {},
        ),
        SettingsTile(
          leading: const Icon(Icons.cleaning_services_outlined),
          title: const Text('Vider le cache local'),
          description: const Text('Effacer les messages et médias stockés sur cet appareil'),
          onPressed: (_) {},
        ),
      ],
    );
  }
}
