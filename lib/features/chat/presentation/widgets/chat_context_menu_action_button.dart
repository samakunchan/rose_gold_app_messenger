import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ChatContextMenuActionButton extends StatelessWidget {
  const new({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
    super.key,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color foregroundColor = isDestructive ? theme.colorScheme.error : theme.colorScheme.onSurface;

    return Material(
      type: .transparency,
      child: InkWell(
        borderRadius: .circular(AppRadius.sm.value),
        onTap: onTap,
        child: Padding(
          padding: .symmetric(
            horizontal: AppSpacing.spaceMd.value,
            vertical: AppSpacing.spaceSm.value,
          ),
          child: Row(
            spacing: AppSpacing.spaceMd.value,
            children: <Widget>[
              Icon(
                icon,
                size: 20,
                color: foregroundColor,
              ),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: foregroundColor,
                    fontWeight: .w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
