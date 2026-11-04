import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/signals/chat_signals.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/view_models/message_view_model.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ChatBlockedMessageBanner extends StatelessWidget {
  const new({
    required this.message,
    super.key,
  });

  final MessageViewModel message;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ChatSignals chatSignals = kGetIt<ChatSignals>();

    return Padding(
      padding: .symmetric(
        horizontal: AppSpacing.spaceMd.value,
        vertical: AppSpacing.space2xs.value,
      ),
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.88),
          padding: .symmetric(
            horizontal: AppSpacing.spaceMd.value,
            vertical: AppSpacing.spaceXs.value,
          ),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
            borderRadius: .circular(AppRadius.md.value),
            border: .all(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.35),
              width: 0.8,
            ),
          ),
          child: Row(
            mainAxisSize: .min,
            spacing: AppSpacing.spaceSm.value,
            children: <Widget>[
              Icon(
                Icons.block_rounded,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.7),
              ),
              Flexible(
                child: Text(
                  'Message masqué de ${message.senderUsername}',
                  overflow: .ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontStyle: .italic,
                  ),
                ),
              ),
              InkWell(
                borderRadius: .circular(AppRadius.xs.value),
                onTap: () => chatSignals.revealBlockedMessage(message.id),
                child: Padding(
                  padding: .symmetric(
                    horizontal: AppSpacing.spaceXs.value,
                    vertical: AppSpacing.space2xs.value,
                  ),
                  child: Text(
                    'Afficher',
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: .bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
