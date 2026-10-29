import 'package:flutter/foundation.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/encrypted_media_attachment.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/signals/chat_signals.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/view_models/message_view_model.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_full_screen_image_viewer.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ChatMediaAttachmentBubble extends StatelessWidget {
  const new({required this.message, super.key});

  final MessageViewModel message;

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes o';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} Ko';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} Mo';
    }
  }

  @override
  Widget build(BuildContext context) {
    final EncryptedMediaAttachment? attachment = message.attachment;
    if (attachment == null) {
      return const SizedBox.shrink();
    }

    final ThemeData theme = Theme.of(context);
    final ChatSignals signals = kGetIt<ChatSignals>();

    return FutureBuilder<Uint8List?>(
      future: signals.getOrDownloadMedia(attachment),
      builder: (BuildContext context, AsyncSnapshot<Uint8List?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: 200,
            height: 120,
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.1),
              borderRadius: .circular(AppRadius.card.value),
            ),
            child: Column(
              mainAxisAlignment: .center,
              children: <Widget>[
                const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2)),
                const SizedBox(height: 8),
                Text('Déchiffrement...', style: theme.textTheme.labelSmall?.copyWith(fontWeight: .w500)),
                Text(
                  _formatFileSize(attachment.fileSize),
                  style: theme.textTheme.labelSmall?.copyWith(fontSize: 10, color: theme.colorScheme.outline),
                ),
              ],
            ),
          );
        }

        final Uint8List? bytes = snapshot.data;
        if (bytes == null || snapshot.hasError) {
          return Container(
            width: 200,
            padding: .all(AppSpacing.spaceSm.value),
            decoration: BoxDecoration(
              color: theme.colorScheme.errorContainer.withValues(alpha: 0.5),
              borderRadius: .circular(AppRadius.card.value),
            ),
            child: Row(
              children: <Widget>[
                Icon(Icons.broken_image_rounded, color: theme.colorScheme.error, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Média indisponible',
                    style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.error),
                  ),
                ),
              ],
            ),
          );
        }

        if (message.isImage) {
          return GestureDetector(
            onTap: () => ChatFullScreenImageViewer.show(context, imageBytes: bytes, title: attachment.fileName),
            child: ClipRRect(
              borderRadius: .circular(AppRadius.card.value),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 240,
                  maxWidth: 260,
                ),
                child: Image.memory(bytes, fit: .cover),
              ),
            ),
          );
        }

        return Container(
          width: 220,
          padding: .all(AppSpacing.spaceSm.value),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.15),
            borderRadius: .circular(AppRadius.card.value),
          ),
          child: Row(
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                  shape: .circle,
                ),
                child: Icon(Icons.play_arrow_rounded, color: theme.colorScheme.primary, size: 28),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: .start,
                  mainAxisSize: .min,
                  children: <Widget>[
                    Text(
                      attachment.fileName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(fontWeight: .bold),
                    ),
                    Text(
                      _formatFileSize(attachment.fileSize),
                      style: theme.textTheme.labelSmall?.copyWith(fontSize: 10, color: theme.colorScheme.outline),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
