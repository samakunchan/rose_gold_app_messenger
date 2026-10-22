import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_invitations_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_invitation_view_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/themes/extensions/rooms_theme_extension.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class InvitationsList extends SignalWidget {
  const new({this.roomInvitationsSignals, super.key});
  final RoomInvitationsSignals? roomInvitationsSignals;

  @override
  Widget build(BuildContext context) {
    final RoomInvitationsSignals signals = roomInvitationsSignals ?? kGetIt<RoomInvitationsSignals>();
    final List<RoomInvitationViewModel> invitations = signals.invitations.value;
    if (invitations.isEmpty) {
      return const SizedBox.shrink();
    }

    final ThemeData theme = Theme.of(context);
    final RoomsThemeExtension roomsTheme = theme.extension<RoomsThemeExtension>() ?? .light;

    return Column(
      crossAxisAlignment: .start,
      spacing: AppSpacing.spaceSm.value,
      children: <Widget>[
        Padding(
          padding: .symmetric(horizontal: AppSpacing.spaceXs.value),
          child: Row(
            spacing: AppSpacing.spaceXs.value,
            children: <Widget>[
              Icon(Icons.mail_outline_rounded, size: 18, color: theme.colorScheme.primary),
              Text(
                'Invitations en attente (${invitations.length})',
                style: theme.textTheme.titleSmall?.copyWith(fontWeight: .bold, color: theme.colorScheme.primary),
              ),
            ],
          ),
        ),
        ...List<Widget>.generate(
          invitations.length,
          (int index) {
            final RoomInvitationViewModel invitation = invitations[index];
            final String invitationId = invitation.id;

            return Container(
              margin: .symmetric(vertical: AppSpacing.spaceXs.value),
              padding: .all(AppSpacing.spaceMd.value),
              decoration: roomsTheme.invitationCardDecoration,
              child: Column(
                crossAxisAlignment: .start,
                spacing: AppSpacing.spaceSm.value,
                children: <Widget>[
                  Row(
                    spacing: AppSpacing.spaceMd.value,
                    children: <Widget>[
                      MonogramUser(username: invitation.inviterDisplayName),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: .start,
                          children: <Widget>[
                            Text.rich(
                              TextSpan(
                                children: <InlineSpan>[
                                  TextSpan(
                                    text: invitation.inviterDisplayName,
                                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: .bold, color: theme.colorScheme.onSurface),
                                  ),
                                  const TextSpan(text: ' vous invite à rejoindre :'),
                                ],
                              ),
                              style: theme.textTheme.bodyMedium,
                            ),
                            Text(
                              invitation.roomName,
                              style: theme.textTheme.titleMedium?.copyWith(fontWeight: .bold, color: theme.colorScheme.primary),
                              maxLines: 1,
                              overflow: .ellipsis,
                            ),
                            if (invitation.timeAgo.isNotEmpty)
                              Text(
                                invitation.timeAgo,
                                style: theme.textTheme.labelSmall?.copyWith(color: kTaupeMutedTextColor),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: .end,
                    spacing: AppSpacing.spaceSm.value,
                    children: <Widget>[
                      OutlinedButton(
                        style: roomsTheme.primaryOutlinedDecorationButton,
                        onPressed: () => signals.declineInvitation(invitationId: invitationId),
                        child: const Text('Refuser'),
                      ),
                      ElevatedButton(
                        style: roomsTheme.primaryDecorationButton,
                        onPressed: () => signals.acceptInvitation(invitationId: invitationId),
                        child: const Text('Accepter'),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
