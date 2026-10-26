import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/widgets/modals/delete_account_dialog.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/screens/change_password_settings_screen.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:settings_ui/settings_ui.dart';

class AccountSettingsSection extends AbstractSettingsSection {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthSignals authSignals = kGetIt<AuthSignals>();

    return SettingsSection(
      title: const Text('Compte & Sécurité'),
      tiles: <AbstractSettingsTile>[
        SettingsTile.navigation(
          leading: const Icon(Icons.person_outline),
          title: const Text('Modifier le profil'),
          onPressed: (_) {},
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.lock_outline),
          title: const Text('Changer le mot de passe'),
          onPressed: (_) {
            Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const ChangePasswordSettingScreen()));
          },
        ),
        SettingsTile.navigation(
          leading: const Icon(Icons.delete_forever_outlined),
          title: const Text('Supprimer mon compte'),
          description: const Text('Suppression définitive du compte et des données'),
          onPressed: (BuildContext context) => _confirmDeleteAccount(context, authSignals),
        ),
      ],
    );
  }

  Future<void> _confirmDeleteAccount(BuildContext context, AuthSignals authSignals) async {
    final bool? confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => const DeleteAccountDialog(),
    );

    if ((confirmed ?? false) && context.mounted) {
      await authSignals.deleteAppMessengerAccount();
      if (context.mounted) {
        Navigator.of(context).pop();
      }
    }
  }
}
