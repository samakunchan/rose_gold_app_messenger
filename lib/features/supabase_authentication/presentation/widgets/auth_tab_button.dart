import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class AuthTabButton extends StatelessWidget {
  const new({required this.title, required this.setState, required this.isLoginTab, super.key});
  final String title;
  final bool isLoginTab;
  final void Function() setState;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return InkWell(
      onTap: setState,
      borderRadius: .all(.circular(AppRadius.sm.value)),
      child: Padding(
        padding: .symmetric(vertical: AppSpacing.spaceXs.value, horizontal: AppSpacing.spaceSm.value),
        child: Column(
          spacing: AppSpacing.space2xs.value,
          children: <Widget>[
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: isLoginTab ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                fontWeight: isLoginTab ? .w600 : .normal,
              ),
            ),
            Container(
              width: 32,
              height: 2,
              decoration: BoxDecoration(
                color: isLoginTab ? theme.colorScheme.secondary : Colors.transparent,
                borderRadius: .all(.circular(AppRadius.full.value)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
