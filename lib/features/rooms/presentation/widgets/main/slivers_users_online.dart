import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/presences/presentation/signals/user_presence_signals.dart';
import 'package:rose_gold_app_messenger/features/presences/presentation/view_models/user_presence_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_members_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/user_profile_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/main/user_presence_item.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class SliversUsersOnline extends SignalWidget {
  const new({this.roomMembersSignals, this.userPresenceSignals, super.key});

  final RoomMembersSignals? roomMembersSignals;
  final UserPresenceSignals? userPresenceSignals;

  @override
  Widget build(BuildContext context) {
    final RoomMembersSignals membersSignals = roomMembersSignals ?? kGetIt<RoomMembersSignals>();
    final UserPresenceSignals presenceSignals = userPresenceSignals ?? kGetIt<UserPresenceSignals>();
    final ThemeData theme = Theme.of(context);

    final List<UserProfileViewModel> coMembers = membersSignals.coMembers.value;
    final List<UserPresenceViewModel> onlineUsers = presenceSignals.onlineUsers.value;

    if (coMembers.isEmpty) {
      return const SliverToBoxAdapter(child: SizedBox.shrink());
    }

    final Set<String> onlineUserIds = onlineUsers.map((UserPresenceViewModel u) => u.userId).toSet();

    // Tri : En ligne en premier, puis par ordre alphabétique
    final List<UserProfileViewModel> sortedCoMembers = coMembers.toList()
      ..sort((UserProfileViewModel a, UserProfileViewModel b) {
        final bool aOnline = onlineUserIds.contains(a.id);
        final bool bOnline = onlineUserIds.contains(b.id);
        if (aOnline != bOnline) {
          return aOnline ? -1 : 1;
        }
        return a.username.toLowerCase().compareTo(b.username.toLowerCase());
      });

    final int onlineCount = sortedCoMembers.where((UserProfileViewModel m) => onlineUserIds.contains(m.id)).length;

    return SliverPadding(
      padding: .symmetric(
        horizontal: AppSpacing.spaceMd.value,
        vertical: AppSpacing.spaceSm.value,
      ),
      sliver: SliverToBoxAdapter(
        child: Column(
          crossAxisAlignment: .start,
          spacing: AppSpacing.spaceSm.value,
          children: <Widget>[
            Row(
              mainAxisAlignment: .spaceBetween,
              children: <Widget>[
                Text(
                  'En ligne & salons',
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: .bold, color: theme.colorScheme.onSurface),
                ),
                if (onlineCount > 0)
                  Container(
                    padding: const .symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: kSuccessColor.withValues(alpha: 0.15),
                      borderRadius: .all(.circular(AppRadius.full.value)),
                      border: .all(
                        color: kSuccessColor.withValues(alpha: 0.35),
                        width: 0.8,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: .min,
                      spacing: 4,
                      children: <Widget>[
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: kSuccessColor,
                            shape: .circle,
                          ),
                        ),
                        Text(
                          '$onlineCount en ligne',
                          style: theme.textTheme.labelSmall?.copyWith(
                            fontWeight: .w600,
                            color: kSuccessColor,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: .horizontal,
              clipBehavior: .none,
              child: Row(
                spacing: AppSpacing.spaceMd.value,
                children: <Widget>[
                  for (final UserProfileViewModel member in sortedCoMembers)
                    UserPresenceItem(
                      initial: member.initial,
                      displayName: member.username,
                      isOnline: onlineUserIds.contains(member.id),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
