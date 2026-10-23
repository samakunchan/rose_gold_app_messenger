import 'package:material_ui/material_ui.dart';

class DeleteAccountDialog extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return AlertDialog(
      title: const Text('Supprimer mon compte ?'),
      content: const Text(
        'Cette action est irréversible. Votre compte ainsi que toutes vos données associées seront définitivement supprimés.',
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.of(context).pop<bool>(false),
          child: const Text('Annuler'),
        ),
        FilledButton(
          style: FilledButton.styleFrom(
            backgroundColor: theme.colorScheme.error,
            foregroundColor: theme.colorScheme.onError,
          ),
          onPressed: () => Navigator.of(context).pop<bool>(true),
          child: const Text('Supprimer'),
        ),
      ],
    );
  }
}
