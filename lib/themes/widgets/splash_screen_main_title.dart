import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class SplashScreenMainTitle extends StatelessWidget {
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
          style: theme.textTheme.displayMedium?.copyWith(
            letterSpacing: 10,
            fontWeight: .w300,
            color: theme.colorScheme.onSurface,
          ),
        ),
        Text(
          tagline,
          textAlign: .center,
          style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary, letterSpacing: 3, fontWeight: .w600),
        ),
      ],
    );
  }
}
