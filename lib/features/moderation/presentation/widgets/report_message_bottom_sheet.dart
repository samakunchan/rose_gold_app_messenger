import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/view_models/message_view_model.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/moderation/presentation/signals/moderation_signals.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ReportMessageBottomSheet extends StatefulWidget {
  const new({
    required this.message,
    required this.roomId,
    super.key,
  });

  final MessageViewModel message;
  final String roomId;

  static Future<bool?> show(
    BuildContext context, {
    required MessageViewModel message,
    required String roomId,
  }) {
    return showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => ReportMessageBottomSheet(
        message: message,
        roomId: roomId,
      ),
    );
  }

  @override
  State<ReportMessageBottomSheet> createState() => _ReportMessageBottomSheetState();
}

class _ReportMessageBottomSheetState extends State<ReportMessageBottomSheet> {
  static const List<String> _reasons = <String>[
    'Contenu haineux, menaces ou violence',
    'Harcèlement ou intimidation',
    'Spam, arnaque ou lien malveillant',
    'Nudité ou contenu à caractère sexuel',
    'Désinformation ou usurpation d’identité',
    'Autre motif',
  ];

  String? _selectedReason;
  bool _blockUser = true;
  final TextEditingController _detailsController = TextEditingController();

  @override
  void dispose() {
    _detailsController.dispose();
    super.dispose();
  }

  Future<void> _submitReport(BuildContext context, ModerationSignals moderationSignals) async {
    if (_selectedReason == null) {
      return;
    }

    final bool success = await moderationSignals.reportMessage(
      reportedUserId: widget.message.senderId,
      roomId: widget.roomId,
      messageId: widget.message.id,
      reason: _selectedReason!,
      details: _detailsController.text.trim().isEmpty ? null : _detailsController.text.trim(),
      blockUser: _blockUser,
    );

    if (!context.mounted) {
      return;
    }

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_blockUser ? 'Message signalé et utilisateur bloqué' : 'Message signalé avec succès'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      Navigator.of(context).pop(true);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(moderationSignals.errorMessage.value ?? 'Erreur lors du signalement du message'),
          backgroundColor: Theme.of(context).colorScheme.error,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ModerationSignals moderationSignals = kGetIt<ModerationSignals>();

    return Padding(
      padding: .only(
        left: AppSpacing.spaceLg.value,
        right: AppSpacing.spaceLg.value,
        bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.spaceLg.value,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: .stretch,
          mainAxisSize: .min,
          spacing: AppSpacing.spaceMd.value,
          children: <Widget>[
            Row(
              spacing: AppSpacing.spaceSm.value,
              children: <Widget>[
                Icon(Icons.flag_rounded, color: theme.colorScheme.error),
                Expanded(
                  child: Text(
                    'Signaler un message',
                    style: theme.textTheme.titleLarge?.copyWith(fontWeight: .bold),
                  ),
                ),
              ],
            ),
            Container(
              padding: .all(AppSpacing.spaceSm.value),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                borderRadius: .circular(AppRadius.sm.value),
              ),
              child: Column(
                crossAxisAlignment: .start,
                spacing: AppSpacing.space2xs.value,
                children: <Widget>[
                  Text(
                    widget.message.senderUsername,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: .bold,
                    ),
                  ),
                  Text(
                    widget.message.content.isEmpty && widget.message.hasMedia ? '[Image jointe]' : widget.message.content,
                    maxLines: 2,
                    overflow: .ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Pour quelle raison signalez-vous ce message ?',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            ..._reasons.map((String reason) {
              final bool isSelected = _selectedReason == reason;
              return InkWell(
                onTap: () {
                  setState(() {
                    _selectedReason = reason;
                  });
                },
                borderRadius: .circular(AppRadius.md.value),
                child: Container(
                  padding: .symmetric(
                    horizontal: AppSpacing.spaceMd.value,
                    vertical: AppSpacing.spaceSm.value,
                  ),
                  decoration: BoxDecoration(
                    color: isSelected ? theme.colorScheme.primaryContainer.withValues(alpha: 0.4) : Colors.transparent,
                    borderRadius: .circular(AppRadius.md.value),
                    border: .all(
                      color: isSelected ? theme.colorScheme.primary : theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
                      width: isSelected ? 1.5 : 1.0,
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          reason,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isSelected ? theme.colorScheme.primary : theme.colorScheme.onSurface,
                            fontWeight: isSelected ? .bold : .normal,
                          ),
                        ),
                      ),
                      if (isSelected)
                        Icon(
                          Icons.check_circle_rounded,
                          color: theme.colorScheme.primary,
                          size: 20,
                        ),
                    ],
                  ),
                ),
              );
            }),
            TextField(
              controller: _detailsController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Précisions supplémentaires (facultatif)',
                hintText: 'Dites-nous en plus sur ce qui pose problème...',
              ),
            ),
            SwitchListTile.adaptive(
              contentPadding: .zero,
              title: Text(
                'Bloquer également ${widget.message.senderUsername}',
                style: theme.textTheme.bodyMedium?.copyWith(fontWeight: .w600),
              ),
              subtitle: Text(
                'Ses messages seront masqués dans ce salon et il ne pourra plus interagir avec vous.',
                style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
              ),
              value: _blockUser,
              onChanged: (bool value) {
                setState(() {
                  _blockUser = value;
                });
              },
            ),
            SignalBuilder(
              builder: (_) {
                final bool isSubmitting = moderationSignals.isLoading.value;
                return ElevatedButton(
                  onPressed: _selectedReason == null || isSubmitting ? null : () => _submitReport(context, moderationSignals),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: theme.colorScheme.error,
                    foregroundColor: theme.colorScheme.onError,
                    padding: .symmetric(vertical: AppSpacing.spaceMd.value),
                  ),
                  child: isSubmitting
                      ? SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: theme.colorScheme.onError,
                          ),
                        )
                      : const Text('Confirmer le signalement'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
