import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/signals/chat_signals.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/media/domain/entities/picked_media.dart';
import 'package:rose_gold_app_messenger/features/media/presentation/widgets/app_media_picker_bottom_sheet.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ChatInputField extends StatefulWidget {
  const new({
    required this.roomId,
    this.peerPublicKeyBase64,
    this.onMessageSent,
    super.key,
  });

  final String roomId;
  final String? peerPublicKeyBase64;
  final VoidCallback? onMessageSent;

  @override
  State<ChatInputField> createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleSend() async {
    final String text = _controller.text.trim();
    if (text.isEmpty) {
      return;
    }

    final ChatSignals chatSignals = kGetIt<ChatSignals>();
    _controller.clear();

    final bool success = await chatSignals.sendMessage(
      roomId: widget.roomId,
      plainText: text,
      peerPublicKeyBase64: widget.peerPublicKeyBase64,
    );
    if (success) {
      widget.onMessageSent?.call();
    }
  }

  Future<void> _handlePickMedia() async {
    final PickedMedia? media = await AppMediaPickerBottomSheet.show(
      context,
      title: 'Joindre un média chiffré',
      allowVideo: true,
    );
    if (media == null || !mounted) {
      return;
    }

    final ChatSignals chatSignals = kGetIt<ChatSignals>();
    final String text = _controller.text.trim();
    _controller.clear();

    final bool success = await chatSignals.sendMessage(
      roomId: widget.roomId,
      plainText: text,
      peerPublicKeyBase64: widget.peerPublicKeyBase64,
      mediaBytes: media.bytes,
      mediaFileName: media.fileName,
      mediaMimeType: media.mimeType,
    );
    if (success) {
      widget.onMessageSent?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ChatSignals chatSignals = kGetIt<ChatSignals>();

    return SignalBuilder(
      builder: (_) {
        final bool isSending = chatSignals.isSending.value;

        return Container(
          padding: .only(
            left: AppSpacing.spaceSm.value,
            right: AppSpacing.spaceSm.value,
            top: AppSpacing.spaceSm.value,
            bottom: AppSpacing.spaceSm.value,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: isSending ? null : _handlePickMedia,
                  icon: Icon(Icons.add_photo_alternate_outlined, color: theme.colorScheme.primary),
                  tooltip: 'Joindre un média chiffré',
                ),
                Expanded(
                  child: TextField(
                    controller: _controller,
                    textCapitalization: .sentences,
                    maxLines: 4,
                    minLines: 1,
                    keyboardType: .multiline,
                    decoration: InputDecoration(
                      hintText: 'Message chiffré...',
                      hintStyle: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.outline),
                      border: OutlineInputBorder(borderRadius: .circular(AppRadius.bubble.value), borderSide: .none),
                      filled: true,
                      fillColor: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      contentPadding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceSm.value),
                    ),
                    onSubmitted: (_) => _handleSend(),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: isSending ? null : _handleSend,
                  icon: isSending
                      ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                      : const Icon(Icons.send_rounded),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
