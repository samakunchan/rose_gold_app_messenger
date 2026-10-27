import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ZoneDangerActions extends StatelessWidget {
  const new({required this.title, required this.titleButton, required this.description, this.onPressed, super.key});
  final void Function()? onPressed;
  final String title;
  final String titleButton;
  final String description;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: .infinity,
      padding: .all(AppSpacing.spaceMd.value),
      decoration: BoxDecoration(
        color: theme.colorScheme.errorContainer.withValues(alpha: 0.25),
        borderRadius: .all(.circular(AppRadius.defaultValue.value)),
        border: .all(color: theme.colorScheme.error.withValues(alpha: 0.4), width: 0.8),
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppSpacing.spaceSm.value,
        children: <Widget>[
          Text(
            title,
            style: theme.textTheme.titleSmall?.copyWith(fontWeight: .bold, color: theme.colorScheme.error),
          ),
          Text(
            description,
            style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          SizedBox(
            width: .infinity,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: theme.colorScheme.error,
                side: BorderSide(color: theme.colorScheme.error),
                padding: .symmetric(vertical: AppSpacing.spaceMd.value),
              ),
              onPressed: onPressed,
              icon: const Icon(Icons.logout_rounded),
              label: Text(titleButton),
            ),
          ),
        ],
      ),
    );
  }
}
