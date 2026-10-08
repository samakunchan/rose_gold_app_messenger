import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class AuthTopHeader extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: <Widget>[
        if (Navigator.of(context).canPop())
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, size: 18),
            onPressed: Navigator.of(context).pop,
          )
        else
          const SizedBox(width: 40, height: 40),
        Container(
          padding: .symmetric(horizontal: AppSpacing.spaceLg.value, vertical: AppSpacing.spaceSm.value),
          decoration: BoxDecoration(
            color: frontTheme.satinFrostOverlayColor,
            borderRadius: .all(.circular(AppRadius.full.value)),
            border: .all(color: frontTheme.incomingBorderColor, width: 0.8),
          ),
          child: Text(
            'ROSEGOLD MESSENGER',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.primary,
              letterSpacing: 5,
              fontWeight: .w600,
            ),
          ),
        ),
        const SizedBox(width: 40, height: 40),
      ],
    );
  }
}
