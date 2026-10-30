import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/screens/room_screen.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/themes/extensions/rooms_theme_extension.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class RoomCardTile extends StatelessWidget {
  const new({required this.room, required this.isCurrentUserOwner, super.key});

  final RoomViewModel room;
  final bool isCurrentUserOwner;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final RoomsThemeExtension roomsTheme = theme.extension<RoomsThemeExtension>() ?? .light;
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;

    return Container(
      decoration: BoxDecoration(
        color: frontTheme.satinFrostOverlayColor,
        borderRadius: .all(.circular(AppRadius.lg.value)),
        border: .all(color: frontTheme.incomingBorderColor, width: 0.8),
        boxShadow: <BoxShadow>[
          BoxShadow(color: frontTheme.onlineRingColor.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 4)),
          BoxShadow(color: theme.colorScheme.shadow.withValues(alpha: 0.03), blurRadius: 4, offset: const Offset(0, 1)),
        ],
      ),
      child: InkWell(
        borderRadius: .all(.circular(AppRadius.lg.value)),
        onTap: () async {
          await HapticFeedback.lightImpact();
          if (context.mounted) {
            Navigator.push(
              context,
              MaterialPageRoute<void>(
                builder: (_) => RoomScreen(roomId: room.id, roomName: room.name),
              ),
            );
          }
        },
        child: Padding(
          padding: .all(AppSpacing.spaceMd.value),
          child: Row(
            spacing: AppSpacing.spaceMd.value,
            children: <Widget>[
              // Médaillon élégant du salon avec dégradé Rose Gold
              MonogramUser(username: room.name, avatarUrl: room.avatarUrl, size: 50),

              // Informations textuelles du salon
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  spacing: AppSpacing.spaceXs.value,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(
                            room.name,
                            style: theme.textTheme.titleMedium?.copyWith(fontWeight: .bold, color: theme.colorScheme.onSurface),
                            maxLines: 1,
                            overflow: .ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        // Badge de rôle du salon
                        if (isCurrentUserOwner)
                          Container(
                            padding: const .symmetric(horizontal: 8, vertical: 3),
                            decoration: roomsTheme.badgePrimaryDecoration,
                            child: Row(
                              mainAxisSize: .min,
                              spacing: 3,
                              children: <Widget>[
                                Icon(Icons.star_rounded, size: 13, color: roomsTheme.primaryTextColor),
                                Text(
                                  'Fondateur',
                                  style: theme.textTheme.labelSmall?.copyWith(fontWeight: .bold, color: roomsTheme.primaryTextColor),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            padding: const .symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                              borderRadius: .all(.circular(AppRadius.defaultValue.value)),
                            ),
                            child: Text(
                              'Membre',
                              style: theme.textTheme.labelSmall?.copyWith(fontWeight: .w600, color: kTaupeMutedTextColor),
                            ),
                          ),
                      ],
                    ),

                    // Description facultative
                    if (room.description != null && room.description!.trim().isNotEmpty)
                      Text(
                        room.description!,
                        style: theme.textTheme.bodySmall?.copyWith(color: kTaupeMutedTextColor),
                        maxLines: 1,
                        overflow: .ellipsis,
                      ),

                    // Horodatage de dernière activité
                    Row(
                      spacing: 4,
                      children: <Widget>[
                        const Icon(Icons.access_time_rounded, size: 12, color: kTaupeMutedTextColor),
                        Text(
                          'Actif ${room.updatedAt}',
                          style: theme.textTheme.labelSmall?.copyWith(color: kTaupeMutedTextColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Chevron subtil doré
              Icon(Icons.chevron_right_rounded, size: 20, color: frontTheme.onlineRingColor.withValues(alpha: 0.6)),
            ],
          ),
        ),
      ),
    );
  }
}
