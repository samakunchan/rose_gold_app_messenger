import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ChatEmptyView extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: .all(AppSpacing.spaceLg.value),
        child: Column(
          mainAxisSize: .min,
          children: <Widget>[
            Icon(Icons.mark_chat_read_outlined, size: 56, color: theme.colorScheme.primary.withValues(alpha: 0.6)),
            const SizedBox(height: 16),
            Text(
              "Aucun message pour l'instant",
              style: theme.textTheme.titleMedium?.copyWith(fontWeight: .bold, color: theme.colorScheme.onSurface),
            ),
            const SizedBox(height: 8),
            Text(
              'Envoyez le premier message chiffré de bout en bout dans ce salon !',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
              textAlign: .center,
            ),
          ],
        ),
      ),
    );
  }
}
