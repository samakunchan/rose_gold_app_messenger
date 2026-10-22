import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class UserPresenceItem extends StatelessWidget {
  const new({
    required this.initial,
    required this.displayName,
    this.isOnline = false,
    this.size = 48,
    this.onTap,
    super.key,
  });

  final String initial;
  final String displayName;
  final bool isOnline;
  final double size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    final Widget content = Column(
      mainAxisSize: .min,
      spacing: AppSpacing.spaceXs.value,
      children: <Widget>[
        MonogramUser(username: displayName, isOnline: isOnline, size: size),
        SizedBox(
          width: size * 1.4,
          child: Text(
            displayName,
            overflow: .ellipsis,
            textAlign: .center,
            maxLines: 1,
            style: theme.textTheme.labelSmall?.copyWith(
              fontWeight: isOnline ? .bold : .w500,
              color: isOnline ? theme.colorScheme.onSurface : theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ],
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: .all(.circular(AppRadius.defaultValue.value)),
        child: content,
      );
    }

    return content;
  }
}
