import 'dart:async';

import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/screens/chat_screen.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/presences/presentation/signals/user_presence_signals.dart';
import 'package:rose_gold_app_messenger/features/presences/presentation/view_models/user_presence_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_members_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/rooms_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_member_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/room/room_app_bar.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/room/room_header_complete_infos.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/room/room_invite_member_section.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/room/room_member_tile.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/room/room_online_members_text.dart';
import 'package:rose_gold_app_messenger/themes/extensions/rooms_theme_extension.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomScreen extends StatefulWidget {
  const new({required this.roomId, required this.roomName, super.key});

  final String roomId;
  final String roomName;

  @override
  State<RoomScreen> createState() => _RoomScreenState();
}

class _RoomScreenState extends State<RoomScreen> {
  @override
  void initState() {
    super.initState();
    final RoomMembersSignals roomMembers = kGetIt<RoomMembersSignals>();
    unawaited(roomMembers.getMembers(roomId: widget.roomId));
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final RoomsThemeExtension roomsTheme = theme.extension<RoomsThemeExtension>() ?? .light;

    return SignalBuilder(
      builder: (_) {
        final RoomMembersSignals roomMembersSignals = kGetIt<RoomMembersSignals>();
        final RoomsSignals roomsSignals = kGetIt<RoomsSignals>();
        final UserPresenceSignals presenceSignals = kGetIt<UserPresenceSignals>();
        final String? currentUserId = kGetIt<SupabaseClient>().auth.currentUser?.id;

        final List<RoomMemberViewModel> members = roomMembersSignals.members.value;
        final List<UserPresenceViewModel> onlineUsers = presenceSignals.onlineUsers.value;
        final Set<String> onlineUserIds = onlineUsers.map((UserPresenceViewModel u) => u.userId).toSet();

        final RoomViewModel? currentRoom = roomsSignals.rooms.value.where((RoomViewModel room) => room.id == widget.roomId).firstOrNull;

        final String roomName = currentRoom?.name ?? widget.roomName;

        final RoomMemberViewModel? owner = members.where((RoomMemberViewModel member) => member.role == 'owner').firstOrNull;

        final bool isCurrentUserOwner = owner != null && owner.userId == currentUserId;

        final List<RoomMemberViewModel> onlineMembers = members
            .where((RoomMemberViewModel member) => onlineUserIds.contains(member.userId))
            .toList();

        return Scaffold(
          appBar: RoomAppBar(currentRoom: currentRoom, roomId: widget.roomId, name: roomName, isCurrentUserOwner: isCurrentUserOwner),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceSm.value),
              child: Column(
                crossAxisAlignment: .start,
                spacing: AppSpacing.spaceLg.value,
                children: <Widget>[
                  // 1. En-tête complet du salon (Infos complètes)
                  RoomHeaderCompleteInfos(members: members, currentRoom: currentRoom, owner: owner),

                  // 2. Bouton principal "Joindre la conversation"
                  SizedBox(
                    width: .infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      style: roomsTheme.primaryDecorationButton,
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => ChatScreen(roomId: widget.roomId, roomName: roomName),
                          ),
                        );
                      },
                      icon: const Icon(Icons.forum_outlined),
                      label: Text(
                        'Joindre la conversation',
                        style: theme.textTheme.labelLarge?.copyWith(fontWeight: .bold, color: roomsTheme.primaryTextColor),
                      ),
                    ),
                  ),

                  // 3. Personnes connectées sur le salon (En texte seulement)
                  RoomOnlineMembersText(onlineMembers: onlineMembers),

                  // 4. Section pour inviter des membres (Owner uniquement)
                  if (isCurrentUserOwner)
                    RoomInviteMemberSection(
                      roomId: widget.roomId,
                      currentMemberIds: members.map((RoomMemberViewModel member) => member.userId).toList(),
                      currentUserId: currentUserId,
                    ),

                  // 5. Liste de tous les membres du salon
                  Column(
                    crossAxisAlignment: .start,
                    spacing: AppSpacing.spaceSm.value,
                    children: <Widget>[
                      Text(
                        'Tous les membres (${members.length})',
                        style: theme.textTheme.titleMedium?.copyWith(fontWeight: .bold, color: theme.colorScheme.onSurface),
                      ),
                      if (members.isEmpty)
                        Text('Chargement des membres...', style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline))
                      else
                        Column(
                          spacing: AppSpacing.spaceSm.value,
                          children: <Widget>[
                            for (final RoomMemberViewModel member in members)
                              RoomMemberTile(member: member, isOnline: onlineUserIds.contains(member.userId)),
                          ],
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
