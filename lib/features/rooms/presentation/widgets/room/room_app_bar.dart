import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/moderation/presentation/widgets/report_room_bottom_sheet.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/screens/edit_room_screen.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_view_model.dart';
import 'package:signals_flutter/signals_flutter.dart';

class RoomAppBar extends SignalWidget implements PreferredSizeWidget {
  const new({
    required this.name,
    required this.roomId,
    required this.isCurrentUserOwner,
    this.currentRoom,
    this.ownerId,
    this.ownerUsername,
    super.key,
  });
  final String name;
  final String roomId;
  final bool isCurrentUserOwner;
  final RoomViewModel? currentRoom;
  final String? ownerId;
  final String? ownerUsername;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String roomName = currentRoom?.name ?? name;
    final String? roomDescription = currentRoom?.description;
    final String? roomAvatarUrl = currentRoom?.avatarUrl;

    return AppBar(
      title: Text(
        roomName,
        style: theme.textTheme.displayMedium?.copyWith(fontWeight: .bold, color: theme.colorScheme.onSurface),
      ),
      actions: <Widget>[
        if (!isCurrentUserOwner)
          IconButton(
            tooltip: 'Signaler ce salon',
            icon: const Icon(Icons.flag_outlined),
            onPressed: () {
              unawaited(
                ReportRoomBottomSheet.show(
                  context,
                  roomId: roomId,
                  roomName: roomName,
                  ownerId: ownerId ?? currentRoom?.createdBy,
                  ownerUsername: ownerUsername,
                ),
              );
            },
          ),
        IconButton(
          tooltip: 'Paramètres du salon',
          icon: const Icon(Icons.settings_outlined),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (_) => EditRoomScreen(
                  roomId: roomId,
                  initialName: roomName,
                  initialDescription: roomDescription,
                  initialAvatarUrl: roomAvatarUrl,
                  isOwner: isCurrentUserOwner,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size(20, 55);
}
