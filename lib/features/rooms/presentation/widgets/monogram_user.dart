import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/extensions/rooms_theme_extension.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class MonogramUser extends StatelessWidget {
  const new({required this.username, this.isOnline = false, this.size = 44, this.badgeBorderColor, this.statusColor, this.avatarUrl, super.key});

  final String username;
  final String? avatarUrl;
  final bool isOnline;
  final double size;
  final Color? badgeBorderColor;
  final Color? statusColor;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final RoomsThemeExtension roomsTheme = theme.extension<RoomsThemeExtension>() ?? .light;
    final double fontSize = (size * 0.41).clamp(10, 24);
    final double indicatorSize = (size * 0.28).clamp(10, 16);
    final double indicatorBorderWidth = (size * 0.045).clamp(1.5, 2.5);
    final String initial = username.isNotEmpty ? username[0].toUpperCase() : '#';

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        clipBehavior: .none,
        children: <Widget>[
          Container(
            width: size,
            height: size,
            decoration: roomsTheme.avatarContainerDecoration,
            clipBehavior: .antiAlias,
            alignment: .center,
            child: (avatarUrl != null && avatarUrl!.isNotEmpty)
                ? Image.network(
                    avatarUrl!,
                    width: size,
                    height: size,
                    fit: .cover,
                    errorBuilder: (_, _, _) => Text(
                      initial,
                      style: theme.textTheme.headlineMedium?.copyWith(color: roomsTheme.primaryTextColor, fontSize: fontSize),
                    ),
                  )
                : Text(
                    initial,
                    style: theme.textTheme.headlineMedium?.copyWith(color: roomsTheme.primaryTextColor, fontSize: fontSize),
                  ),
          ),
          if (isOnline)
            Positioned(
              right: 0,
              bottom: 0,
              child: Container(
                width: indicatorSize,
                height: indicatorSize,
                decoration: BoxDecoration(
                  color: statusColor ?? kSuccessColor,
                  shape: .circle,
                  border: .all(color: badgeBorderColor ?? theme.scaffoldBackgroundColor, width: indicatorBorderWidth),
                  boxShadow: <BoxShadow>[
                    BoxShadow(color: (statusColor ?? kSuccessColor).withValues(alpha: 0.35), blurRadius: 4, offset: const Offset(0, 1)),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
