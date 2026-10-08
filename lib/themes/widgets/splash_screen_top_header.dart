import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class SplashScreenTopHeader extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;

    return Row(
      mainAxisAlignment: .spaceBetween,
      children: <Widget>[
        Container(
          padding: .symmetric(horizontal: AppSpacing.spaceBase.value, vertical: AppSpacing.spaceSm.value),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: .all(.circular(AppRadius.full.value)),
            border: .all(color: frontTheme.onlineRingColor, width: 0.8),
          ),
          child: Text(
            'ÉDITION PRIVÉE',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.secondary,
              letterSpacing: 2.2,
              fontWeight: .w600,
            ),
          ),
        ),
        Container(
          padding: .symmetric(horizontal: AppSpacing.spaceBase.value, vertical: AppSpacing.spaceSm.value),
          decoration: BoxDecoration(
            color: frontTheme.satinFrostOverlayColor,
            borderRadius: .all(.circular(AppRadius.full.value)),
            border: .all(color: frontTheme.conversationDividerColor, width: 0.8),
          ),
          child: Row(
            spacing: AppSpacing.spaceXs.value,
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(shape: .circle, color: theme.colorScheme.primaryContainer),
              ),
              Text(
                'Chiffrement bout en bout',
                style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
