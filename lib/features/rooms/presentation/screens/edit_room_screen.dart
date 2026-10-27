import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_members_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/rooms_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/edit/edit_room_member_view.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/edit/edit_room_owner_form.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class EditRoomScreen extends StatelessWidget {
  const new({
    required this.roomId,
    required this.initialName,
    required this.isOwner,
    this.initialDescription,
    this.initialAvatarUrl,
    this.roomsSignals,
    this.roomMembersSignals,
    super.key,
  });

  final String roomId;
  final String initialName;
  final bool isOwner;
  final String? initialDescription;
  final String? initialAvatarUrl;
  final RoomsSignals? roomsSignals;
  final RoomMembersSignals? roomMembersSignals;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isOwner ? 'Paramètres du salon' : 'Informations du salon',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: .bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: .symmetric(
            horizontal: AppSpacing.spaceLg.value,
            vertical: AppSpacing.spaceMd.value,
          ),
          child: isOwner
              ? EditRoomOwnerForm(
                  roomId: roomId,
                  initialName: initialName,
                  initialDescription: initialDescription,
                  initialAvatarUrl: initialAvatarUrl,
                  roomsSignals: roomsSignals,
                )
              : EditRoomMemberView(
                  roomId: roomId,
                  roomName: initialName,
                  roomDescription: initialDescription,
                  roomAvatarUrl: initialAvatarUrl,
                  roomMembersSignals: roomMembersSignals,
                ),
        ),
      ),
    );
  }
}
