import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class SplashScreenQuote extends StatelessWidget {
  const new({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Column(
      spacing: AppSpacing.spaceLg.value,
      children: <Widget>[
        Padding(
          padding: .symmetric(horizontal: AppSpacing.spaceXl.value),
          child: Text(
            message,
            textAlign: .center,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontStyle: .italic,
              fontWeight: .w300,
              height: 1.6,
            ),
          ),
        ),
      ],
    );
  }
}
