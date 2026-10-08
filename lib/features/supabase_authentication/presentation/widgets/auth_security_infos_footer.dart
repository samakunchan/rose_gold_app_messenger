import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class AuthSecurityInfosFooter extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Align(
      alignment: .bottomCenter,
      child: Padding(
        padding: .all(AppSpacing.spaceLg.value),
        child: Row(
          mainAxisAlignment: .center,
          spacing: AppSpacing.spaceXs.value,
          children: <Widget>[
            Icon(Icons.verified_user_outlined, size: 16, color: theme.colorScheme.secondary),
            Text(
              'CHIFFREMENT PRIVÉ DE HAUTE SÉCURITÉ',
              style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.secondary, letterSpacing: 1.2, fontWeight: .w500),
            ),
          ],
        ),
      ),
    );
  }
}
