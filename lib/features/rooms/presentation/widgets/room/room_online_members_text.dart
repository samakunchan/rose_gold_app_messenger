import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_member_view_model.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class RoomOnlineMembersText extends StatelessWidget {
  const new({
    required this.onlineMembers,
    super.key,
  });

  final List<RoomMemberViewModel> onlineMembers;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      width: .infinity,
      padding: .all(AppSpacing.spaceMd.value),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: .all(.circular(AppRadius.defaultValue.value)),
        border: .all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          width: 0.8,
        ),
      ),
      child: Column(
        crossAxisAlignment: .start,
        spacing: AppSpacing.spaceSm.value,
        children: <Widget>[
          Row(
            spacing: AppSpacing.spaceXs.value,
            children: <Widget>[
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: kSuccessColor,
                  shape: .circle,
                ),
              ),
              Text(
                'En ligne sur ce salon (${onlineMembers.length})',
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: .bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ],
          ),
          if (onlineMembers.isEmpty)
            Text(
              'Aucun membre connecté actuellement.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
                fontStyle: FontStyle.italic,
              ),
            )
          else
            Column(
              crossAxisAlignment: .start,
              spacing: AppSpacing.spaceXs.value,
              children: <Widget>[
                for (final RoomMemberViewModel member in onlineMembers)
                  Text.rich(
                    TextSpan(
                      children: <InlineSpan>[
                        TextSpan(
                          text: '• ${member.username ?? "Utilisateur"}',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: .w600,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        if (member.role == 'owner')
                          TextSpan(
                            text: ' (Propriétaire)',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: .w500,
                              color: theme.colorScheme.primary,
                            ),
                          )
                        else if (member.role == 'admin')
                          TextSpan(
                            text: ' (Admin)',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: .w500,
                              color: theme.colorScheme.secondary,
                            ),
                          ),
                        if (member.device != null && member.device!.isNotEmpty)
                          TextSpan(
                            text: ' — ${member.device}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.outline,
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}
