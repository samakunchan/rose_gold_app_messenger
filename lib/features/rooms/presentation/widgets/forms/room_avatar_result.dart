import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/themes/extensions/rooms_theme_extension.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class RoomAvatarResult extends StatelessWidget {
  const new({required this.currentAvatarUrl, required this.roomName, this.roomDescription, super.key});
  final String currentAvatarUrl;
  final String roomName;
  final String? roomDescription;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final RoomsThemeExtension roomsTheme = theme.extension<RoomsThemeExtension>() ?? .light;

    return Center(
      child: Column(
        spacing: AppSpacing.spaceSm.value,
        children: <Widget>[
          MonogramUser(username: roomName, avatarUrl: currentAvatarUrl, size: 84),
          Text(
            'Avatar du salon',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: .w600, color: theme.colorScheme.onSurface),
          ),
          // if (roomDescription != null && roomDescription!.isNotEmpty)
          Text(
            // roomDescription!,
            'Personnalisez l’icône ou saisissez l’URL d’une image ci-dessous',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
            textAlign: .center,
          ),
        ],
      ),
    );
  }
}
