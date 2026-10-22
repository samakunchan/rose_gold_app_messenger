import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_member_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/themes/extensions/rooms_theme_extension.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class RoomHeaderCompleteInfos extends StatelessWidget {
  const new({required this.members, this.currentRoom, super.key, this.owner});
  final RoomViewModel? currentRoom;
  final RoomMemberViewModel? owner;
  final List<RoomMemberViewModel> members;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final RoomsThemeExtension roomsTheme = theme.extension<RoomsThemeExtension>() ?? .light;
    final String roomName = currentRoom?.name ?? '#';
    final String? roomDescription = currentRoom?.description;
    final String? roomAvatarUrl = currentRoom?.avatarUrl;

    return Container(
      width: .infinity,
      padding: .all(AppSpacing.spaceLg.value),
      decoration: roomsTheme.userInfoCardDecoration,
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppSpacing.spaceMd.value,
        children: <Widget>[
          Row(
            spacing: AppSpacing.spaceMd.value,
            children: <Widget>[
              MonogramUser(username: roomName, avatarUrl: roomAvatarUrl, size: 56),

              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  spacing: AppSpacing.spaceXs.value,
                  children: <Widget>[
                    Text(
                      roomName,
                      style: theme.textTheme.titleLarge?.copyWith(fontWeight: .bold, color: theme.colorScheme.onSurface),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (roomDescription != null && roomDescription.isNotEmpty)
            Text(
              roomDescription,
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            )
          else
            Text(
              'Aucune description.',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline, fontStyle: .italic),
            ),
          const Divider(height: 1),
          Row(
            mainAxisAlignment: .spaceBetween,
            children: <Widget>[
              Text(
                'Propriétaire : ${owner?.username ?? "Chargement..."}',
                style: theme.textTheme.labelMedium?.copyWith(color: theme.colorScheme.outline),
              ),
              Text(
                '${members.length} membre(s)',
                style: theme.textTheme.labelMedium?.copyWith(fontWeight: .w600, color: theme.colorScheme.primary),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
