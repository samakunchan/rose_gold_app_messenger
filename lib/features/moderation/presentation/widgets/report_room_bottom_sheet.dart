import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/moderation/presentation/signals/moderation_signals.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/signals/room_members_signals.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ReportRoomBottomSheet extends StatefulWidget {
  const new({
    required this.roomId,
    required this.roomName,
    this.ownerId,
    this.ownerUsername,
    super.key,
  });

  final String roomId;
  final String roomName;
  final String? ownerId;
  final String? ownerUsername;

  static Future<bool?> show(
    BuildContext context, {
    required String roomId,
    required String roomName,
    String? ownerId,
    String? ownerUsername,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ReportRoomBottomSheet(
        roomId: roomId,
        roomName: roomName,
        ownerId: ownerId,
        ownerUsername: ownerUsername,
      ),
    );
  }

  @override
  State<ReportRoomBottomSheet> createState() => _ReportRoomBottomSheetState();
}

class _ReportRoomBottomSheetState extends State<ReportRoomBottomSheet> {
  static const List<String> _reasons = <String>[
    'Nom, description ou avatar inapproprié / offensant',
    'Salon dédié au harcèlement ou à la haine',
    'Spam, arnaque ou activité frauduleuse',
    'Contenu illégal ou dangereux',
    'Usurpation d’identité',
    'Autre',
  ];

  final TextEditingController _detailsController = TextEditingController();
  late final FlutterSignal<String> _selectedReason = signal<String>(_reasons.first);
  late final FlutterSignal<bool> _leaveRoom = signal<bool>(true);
  late final FlutterSignal<bool> _blockOwner = signal<bool>(false);

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ModerationSignals moderationSignals = kGetIt<ModerationSignals>();
    final String ownerDisplay = (widget.ownerUsername != null && widget.ownerUsername!.trim().isNotEmpty)
        ? ' (${widget.ownerUsername!.trim()})'
        : '';

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
            final bool shouldLeave = _leaveRoom.value;
            final bool shouldBlock = _blockOwner.value;
            final bool isLoading = moderationSignals.isLoading.value;

            return Column(
              mainAxisSize: .min,
              crossAxisAlignment: .stretch,
              spacing: AppSpacing.spaceSm.value,
              children: <Widget>[
                Text(
                  'Signaler le salon « ${widget.roomName} »',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: .bold),
                ),
                Text(
                  'Sélectionnez le motif du signalement :',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
                ...List<Widget>.generate(_reasons.length, (int index) {
                  final String reason = _reasons[index];
                  final bool isSelected = currentReason == reason;
                  return ListTile(
                    contentPadding: .zero,
                    dense: true,
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
                    'Quitter ce salon immédiatement',
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: .w600),
                  ),
                  subtitle: Text(
                    'Vous ne recevrez plus les messages de ce salon.',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  value: shouldLeave,
                  onChanged: (bool value) => _leaveRoom.value = value,
                ),
                SwitchListTile(
                  contentPadding: .zero,
                  title: Text(
                    'Bloquer également le créateur du salon$ownerDisplay',
                    style: theme.textTheme.bodyMedium?.copyWith(fontWeight: .w600),
                  ),
                  subtitle: Text(
                    'Cet utilisateur ne pourra plus vous envoyer d’invitations.',
                    style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                  ),
                  value: shouldBlock,
                  onChanged: (bool value) => _blockOwner.value = value,
                ),
                ElevatedButton.icon(
                  onPressed: isLoading ? null : _submitReport,
                  icon: isLoading
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.flag_outlined, size: 18),
                  label: Text(
                    isLoading
                        ? 'Envoi en cours...'
                        : (shouldLeave ? 'Signaler et quitter le salon' : 'Envoyer le signalement'),
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
    final bool shouldLeave = _leaveRoom.value;
    final bool shouldBlock = _blockOwner.value;

    final bool success = await moderationSignals.reportRoom(
      reportedUserId: widget.ownerId ?? '',
      roomId: widget.roomId,
      reason: _selectedReason.value,
      details: _detailsController.text,
      blockOwner: shouldBlock,
    );

    if (!mounted) {
      return;
    }

    if (success) {
      if (shouldLeave) {
        await kGetIt<RoomMembersSignals>().leaveRoom(roomId: widget.roomId);
      }

      if (!mounted) {
        return;
      }

      final ScaffoldMessengerState messenger = ScaffoldMessenger.of(context);
      final NavigatorState navigator = Navigator.of(context);

      if (shouldLeave) {
        navigator
          ..pop<bool>(true)
          ..popUntil((Route<dynamic> route) => route.isFirst);
      } else {
        navigator.pop<bool>(true);
      }

      final String message = shouldLeave
          ? 'Salon signalé et quitté.'
          : (shouldBlock ? 'Salon signalé et créateur bloqué.' : 'Signalement du salon envoyé.');

      messenger.showSnackBar(
        SnackBar(
          content: Text(message),
          behavior: .floating,
        ),
      );
    }
  }
}
