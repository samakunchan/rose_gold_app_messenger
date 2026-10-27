import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/themes/themes_statics_export.dart';
import 'package:settings_ui/settings_ui.dart';

class LogoutSettingsSection extends AbstractSettingsSection {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthSignals authSignals = kGetIt<AuthSignals>();

    return CustomSettingsSection(
      child: Padding(
        padding: .symmetric(horizontal: AppSpacing.spaceLg.value, vertical: AppSpacing.spaceMd.value),
        child: SizedBox(
          width: .infinity,
          child: ElevatedButton.icon(
            icon: const Icon(Icons.logout),
            label: const Text('Se déconnecter'),
            onPressed: () async {
              await authSignals.signOut();
              if (context.mounted) {
                Navigator.of(context).pop();
              }
            },
          ),
        ),
      ),
    );
  }
}
