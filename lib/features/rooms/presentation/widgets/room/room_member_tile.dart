import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_member_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class RoomMemberTile extends StatelessWidget {
  const new({
    required this.member,
    required this.isOnline,
    super.key,
  });

  final RoomMemberViewModel member;
  final bool isOnline;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final String username = member.username ?? '#';

    return Container(
      padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceSm.value),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: .all(.circular(AppRadius.defaultValue.value)),
        border: .all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3), width: 0.8),
      ),
      child: Row(
        spacing: AppSpacing.spaceMd.value,
        children: <Widget>[
          MonogramUser(username: username, isOnline: isOnline, size: 40),
          Expanded(
            child: Column(
              crossAxisAlignment: .start,
              mainAxisSize: .min,
              children: <Widget>[
                Row(
                  spacing: AppSpacing.spaceXs.value,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        member.username ?? 'Utilisateur',
                        style: theme.textTheme.titleSmall?.copyWith(fontWeight: .w600, color: theme.colorScheme.onSurface),
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),
                    ),
                    if (member.role == 'owner')
                      Container(
                        padding: const .symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primary.withValues(alpha: 0.12),
                          borderRadius: .all(.circular(AppRadius.full.value)),
                          border: .all(color: theme.colorScheme.primary.withValues(alpha: 0.3), width: 0.6),
                        ),
                        child: Text(
                          'Owner',
                          style: theme.textTheme.labelSmall?.copyWith(fontWeight: .bold, color: theme.colorScheme.primary, fontSize: 10),
                        ),
                      )
                    else if (member.role == 'admin')
                      Container(
                        padding: const .symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary.withValues(alpha: 0.12),
                          borderRadius: .all(.circular(AppRadius.full.value)),
                          border: .all(color: theme.colorScheme.secondary.withValues(alpha: 0.3), width: 0.6),
                        ),
                        child: Text(
                          'Admin',
                          style: theme.textTheme.labelSmall?.copyWith(fontWeight: .bold, color: theme.colorScheme.secondary, fontSize: 10),
                        ),
                      ),
                  ],
                ),
                Text(
                  'Rejoint ${member.joinedAt}',
                  style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.outline),
                ),
              ],
            ),
          ),
          if (isOnline)
            Container(
              padding: const .symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(
                color: kSuccessColor.withValues(alpha: 0.12),
                borderRadius: .all(.circular(AppRadius.full.value)),
                border: .all(color: kSuccessColor.withValues(alpha: 0.3), width: 0.6),
              ),
              child: Text(
                'En ligne',
                style: theme.textTheme.labelSmall?.copyWith(color: kSuccessColor, fontWeight: .w600, fontSize: 10),
              ),
            ),
        ],
      ),
    );
  }
}
