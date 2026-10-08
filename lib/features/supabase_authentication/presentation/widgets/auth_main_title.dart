import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class AuthMainTitle extends StatelessWidget {
  const new({required this.title, required this.tagline, super.key});
  final String title;
  final String tagline;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      spacing: AppSpacing.spaceSm.value,
      children: <Widget>[
        Text(
          title,
          textAlign: .center,
          style: theme.textTheme.headlineMedium?.copyWith(fontWeight: .w600, color: theme.colorScheme.onSurface),
        ),
        Text(
          tagline,
          textAlign: .center,
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}
