import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class FrontCardContainer extends StatelessWidget {
  const new({required this.child, super.key});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;

    return Container(
      width: .infinity,
      padding: .all(AppSpacing.spaceLg.value),
      decoration: BoxDecoration(
        color: frontTheme.satinFrostOverlayColor,
        borderRadius: .all(.circular(AppRadius.lg.value)),
        border: .all(color: frontTheme.incomingBorderColor),
        boxShadow: <BoxShadow>[
          BoxShadow(color: theme.colorScheme.onSurface.withValues(alpha: 0.05), blurRadius: 32, offset: const Offset(0, 10)),
        ],
      ),
      child: child,
    );
  }
}
