import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/rooms_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/forms/create_room_dialog.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/main/empty_rooms_view.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/room/room_card_tile.dart';
import 'package:rose_gold_app_messenger/themes/extensions/rooms_theme_extension.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SliversRoomsAvailable extends SignalWidget {
  const new({this.roomsSignals, super.key});
  final RoomsSignals? roomsSignals;

  @override
  Widget build(BuildContext context) {
    final RoomsSignals signals = roomsSignals ?? kGetIt<RoomsSignals>();
    final String? currentUserId = kGetIt<SupabaseClient>().auth.currentUser?.id;
    final ThemeData theme = Theme.of(context);
    final RoomsThemeExtension roomsTheme = theme.extension<RoomsThemeExtension>() ?? .light;
    final List<RoomViewModel> rooms = signals.rooms.value;

    if (rooms.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: EmptyRoomsView(
          onCreateRoom: () => _showCreateRoomDialog(context, signals),
        ),
      );
    }

    return SliverPadding(
      padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceSm.value),
      sliver: SliverList.separated(
        itemCount: rooms.length + 1,
        separatorBuilder: (_, int index) => SizedBox(
          height: index == 0 ? AppSpacing.spaceMd.value : AppSpacing.spaceSm.value,
        ),
        itemBuilder: (BuildContext context, int index) {
          if (index == 0) {
            // En-tête avec compteur doré et bouton Nouveau
            return Row(
              mainAxisAlignment: .spaceBetween,
              children: <Widget>[
                Row(
                  spacing: AppSpacing.spaceSm.value,
                  children: <Widget>[
                    Text(
                      'Mes salons',
                      style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurface),
                    ),
                    Container(
                      padding: const .symmetric(horizontal: 8, vertical: 2),
                      decoration: roomsTheme.badgeSecondaryDecoration,
                      child: Text(
                        '${rooms.length}',
                        style: theme.textTheme.labelMedium?.copyWith(color: roomsTheme.secondaryTextColor),
                      ),
                    ),
                  ],
                ),
                ElevatedButton.icon(
                  style: roomsTheme.secondaryDecorationButton,
                  onPressed: () => _showCreateRoomDialog(context, signals),
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: const Text('Nouveau'),
                ),
              ],
            );
          }

          final RoomViewModel room = rooms[index - 1];
          final bool isCurrentUserOwner = room.createdBy == currentUserId;

          return RoomCardTile(room: room, isCurrentUserOwner: isCurrentUserOwner);
        },
      ),
    );
  }

  Future<void> _showCreateRoomDialog(BuildContext context, RoomsSignals signals) async {
    await showDialog<void>(
      context: context,
      builder: (_) => CreateRoomDialog(roomsSignals: signals),
    );
  }
}
