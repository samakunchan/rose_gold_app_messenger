import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/settings_signals.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ClearCacheDialog extends StatelessWidget {
  const new({super.key});

  static Future<void> show(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (_) => const ClearCacheDialog(),
    );
  }

  Future<void> _confirmClear(BuildContext context) async {
    final SettingsSignals signals = kGetIt<SettingsSignals>();
    final int? deletedCount = await signals.clearLocalCache();
    if (!context.mounted) {
      return;
    }

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          deletedCount != null
              ? 'Cache local vidé ($deletedCount élément(s) supprimé(s) de cet appareil).'
              : 'Erreur lors du nettoyage du cache local.',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Vider le cache local ?'),
      content: const Text(
        'Cela effacera les messages déchiffrés en cache (SQLite), les médias déchiffrés en mémoire ainsi que les fichiers temporaires sur cet appareil. Vos messages chiffrés sur le serveur et votre phrase secrète E2EE seront conservés.',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: Navigator.of(context).pop,
          child: const Text('Annuler'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: kDangerColor, foregroundColor: kLightOnErrorColor),
          onPressed: () => _confirmClear(context),
          child: const Text('Vider le cache'),
        ),
      ],
    );
  }
}
