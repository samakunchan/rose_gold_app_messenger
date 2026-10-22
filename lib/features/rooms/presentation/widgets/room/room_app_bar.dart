import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/screens/edit_room_screen.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_view_model.dart';
import 'package:signals_flutter/signals_flutter.dart';

class RoomAppBar extends SignalWidget implements PreferredSizeWidget {
  const new({
    required this.name,
    required this.roomId,
    required this.isCurrentUserOwner,
    // this.roomDescription,
    // this.roomAvatarUrl,
    this.currentRoom,
    super.key,
  });
  final String name;
  final String roomId;
  // final String? roomDescription;
  // final String? roomAvatarUrl;
  final bool isCurrentUserOwner;
  final RoomViewModel? currentRoom;

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
