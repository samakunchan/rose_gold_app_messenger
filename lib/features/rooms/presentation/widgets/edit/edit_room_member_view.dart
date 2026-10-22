import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_members_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/forms/zone_danger_actions.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/themes/extensions/rooms_theme_extension.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class EditRoomMemberView extends StatelessWidget {
  const new({
    required this.roomId,
    required this.roomName,
    this.roomDescription,
    this.roomAvatarUrl,
    this.roomMembersSignals,
    super.key,
  });

  final String roomId;
  final String roomName;
  final String? roomDescription;
  final String? roomAvatarUrl;
  final RoomMembersSignals? roomMembersSignals;

  Future<void> _confirmLeave(BuildContext context) async {
    final ThemeData theme = Theme.of(context);
    final RoomMembersSignals membersSignals = roomMembersSignals ?? kGetIt<RoomMembersSignals>();

    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext ctx) => AlertDialog(
        title: const Text('Quitter ce salon ?'),
        content: const Text(
          'Voulez-vous vraiment quitter ce salon ? Vous ne recevrez plus les notifications et messages de ce groupe.',
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Annuler'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: theme.colorScheme.error),
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Quitter'),
          ),
        ],
      ),
    );

    if (confirm == true && context.mounted) {
      await membersSignals.leaveRoom(roomId: roomId);
      if (context.mounted) {
        Navigator.of(context).popUntil((Route<dynamic> route) => route.isFirst);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final RoomsThemeExtension roomsTheme = theme.extension<RoomsThemeExtension>() ?? .light;
    final String avatarUrl = roomAvatarUrl ?? '';

    return Column(
      crossAxisAlignment: .start,
      spacing: AppSpacing.spaceXl.value,
      children: <Widget>[
        // Aperçu du salon
        Center(
          child: Column(
            spacing: AppSpacing.spaceSm.value,
            children: <Widget>[
              MonogramUser(username: roomName, avatarUrl: avatarUrl, size: 84),
              Text(
                roomName,
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: .bold, color: theme.colorScheme.onSurface),
              ),
              if (roomDescription != null && roomDescription!.isNotEmpty)
                Text(
                  roomDescription!,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  textAlign: .center,
                )
              else
                Text(
                  'Aucune description.',
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline, fontStyle: .italic),
                ),
            ],
          ),
        ),

        // Carte d'information membre
        Container(
          width: .infinity,
          padding: .all(AppSpacing.spaceMd.value),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.35),
            borderRadius: .all(.circular(AppRadius.defaultValue.value)),
            border: .all(color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5), width: 0.8),
          ),
          child: Row(
            spacing: AppSpacing.spaceMd.value,
            children: <Widget>[
              Icon(Icons.info_outline, color: theme.colorScheme.primary),
              Expanded(
                child: Text(
                  'Vous participez à ce salon en tant que membre. Seul le propriétaire peut modifier ses paramètres.',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ),
            ],
          ),
        ),

        const Divider(),

        // Au bottom pour le membre : Bouton Quitter ce salon
        ZoneDangerActions(
          title: 'Quitter le groupe',
          description: 'En quittant ce salon, vous ne pourrez plus voir ses conversations à moins d’être réinvité.',
          titleButton: 'Quitter ce salon',
          onPressed: () => _confirmLeave(context),
        ),
      ],
    );
  }
}
