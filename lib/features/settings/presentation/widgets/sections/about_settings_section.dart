import 'package:feedback/feedback.dart';
import 'package:material_ui/material_ui.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/feedback/services/feedback_service.dart';
import 'package:settings_ui/settings_ui.dart';

class AboutSettingsSection extends AbstractSettingsSection {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final PackageInfo packageInfo = kGetIt<PackageInfo>();

    return SettingsSection(
      title: const Text('À propos & Légal'),
      tiles: <AbstractSettingsTile>[
        SettingsTile.navigation(
          leading: const Icon(Icons.bug_report_outlined),
          title: const Text('Signaler un bug / Envoyer un retour'),
          onPressed: (BuildContext tileContext) {
            BetterFeedback.of(tileContext).show(
              (UserFeedback feedback) => FeedbackService.submitFeedback(
                tileContext,
                feedback,
                const <String>['settings'],
              ),
            );
          },
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
          value: Text('${packageInfo.version} (${packageInfo.buildNumber})'),
        ),
      ],
    );
  }
}
