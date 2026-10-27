import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/moderation/presentation/signals/moderation_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/view_models/room_invitation_view_model.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ReportInvitationBottomSheet extends StatefulWidget {
  const new({required this.invitation, super.key});

  final RoomInvitationViewModel invitation;

  @override
  State<ReportInvitationBottomSheet> createState() => _ReportInvitationBottomSheetState();
}

class _ReportInvitationBottomSheetState extends State<ReportInvitationBottomSheet> {
  static const List<String> _reasons = <String>[
    'Spam / Invitations répétées',
    'Harcèlement ou comportement abusif',
    'Nom de salon inapproprié ou offensant',
    'Autre',
  ];

  final TextEditingController _detailsController = TextEditingController();
  late final FlutterSignal<String> _selectedReason = signal<String>(_reasons.first);
  late final FlutterSignal<bool> _blockUser = signal<bool>(true);

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ModerationSignals moderationSignals = kGetIt<ModerationSignals>();

    return SafeArea(
      child: SingleChildScrollView(
        padding: .only(
          left: AppSpacing.spaceBase.value,
          right: AppSpacing.spaceBase.value,
          bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.spaceBase.value,
        ),
        child: SignalBuilder(
          builder: (_) {
            final String currentReason = _selectedReason.value;
            final bool shouldBlock = _blockUser.value;
            final bool isLoading = moderationSignals.isLoading.value;

            return Column(
              mainAxisSize: .min,
              crossAxisAlignment: .stretch,
              spacing: AppSpacing.spaceSm.value,
              children: <Widget>[
                Text(
                  'Signaler l’invitation de ${widget.invitation.inviterDisplayName}',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: .bold),
                ),
                Text(
                  'Salon : ${widget.invitation.roomName}',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                ...List<Widget>.generate(_reasons.length, (int index) {
                  final String reason = _reasons[index];
                  final bool isSelected = currentReason == reason;
                  return ListTile(
                    contentPadding: .zero,
                    leading: Icon(
                      isSelected ? Icons.radio_button_checked : Icons.radio_button_off,
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outline,
                    ),
                    title: Text(reason, style: theme.textTheme.bodyMedium),
                    onTap: () => _selectedReason.value = reason,
                  );
                }),
                TextField(
                  controller: _detailsController,
                  maxLines: 2,
                  decoration: const InputDecoration(
                    hintText: 'Détails supplémentaires (optionnel)...',
                  ),
                ),
                SwitchListTile(
                  contentPadding: .zero,
                  title: Text(
                    'Bloquer également ${widget.invitation.inviterDisplayName}',
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: .w600),
                  ),
                  subtitle: Text(
                    'Cet utilisateur ne pourra plus vous envoyer d’invitations.',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  value: shouldBlock,
                  onChanged: (bool value) => _blockUser.value = value,
                ),
                ElevatedButton.icon(
                  onPressed: isLoading ? null : _submitReport,
                  icon: isLoading
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.flag_outlined, size: 18),
                  label: Text(
                    isLoading
                        ? 'Envoi en cours...'
                        : (shouldBlock ? 'Signaler et bloquer' : 'Envoyer le signalement'),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Future<void> _submitReport() async {
    final ModerationSignals moderationSignals = kGetIt<ModerationSignals>();

    final bool success = await moderationSignals.reportInvitation(
      reportedUserId: widget.invitation.inviterId,
      roomId: widget.invitation.roomId,
      invitationId: widget.invitation.id,
      reason: _selectedReason.value,
      details: _detailsController.text,
      blockUser: _blockUser.value,
    );

    if (!mounted) {
      return;
    }

    if (success) {
      Navigator.of(context).pop<bool>(true);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _blockUser.value
                ? 'Signalement envoyé et ${widget.invitation.inviterDisplayName} a été bloqué.'
                : 'Signalement envoyé.',
          ),
          behavior: .floating,
        ),
      );
    }
  }
}
