import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class E2eeSecurityBanner extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      margin: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceSm.value),
      padding: .all(AppSpacing.spaceSm.value),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
        borderRadius: .circular(AppRadius.card.value),
        border: Border.all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4)),
      ),
      child: Row(
        mainAxisSize: .min,
        children: <Widget>[
          Icon(Icons.lock_outline, size: 16, color: theme.colorScheme.primary),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              'Les messages de ce salon sont chiffrés de bout en bout (Zero-Knowledge). Ni le serveur ni aucun tiers ne peut les lire.',
              style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              textAlign: .center,
            ),
          ),
        ],
      ),
    );
  }
}
