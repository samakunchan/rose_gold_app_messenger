import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/message_reaction_group_entity.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/signals/chat_signals.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/view_models/message_view_model.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ChatReactionsRow extends StatelessWidget {
  const new({required this.message, super.key});

  final MessageViewModel message;

  @override
  Widget build(BuildContext context) {
    if (!message.hasReactions) {
      return const SizedBox.shrink();
    }

    final ThemeData theme = Theme.of(context);
    final ChatThemeExtension chatTheme = theme.extension<ChatThemeExtension>() ?? .light;
    final ChatSignals chatSignals = kGetIt<ChatSignals>();

    return Padding(
      padding: .only(top: AppSpacing.space2xs.value),
      child: Wrap(
        spacing: AppSpacing.space2xs.value,
        runSpacing: AppSpacing.space2xs.value,
        alignment: message.isMe ? WrapAlignment.end : WrapAlignment.start,
        children: message.reactions.map((MessageReactionGroupEntity group) {
          final bool hasReacted = group.hasReacted;

          return Material(
            type: .transparency,
            child: InkWell(
              borderRadius: .circular(AppRadius.full.value),
              onTap: () async {
                await chatSignals.toggleReaction(messageId: message.id, emoji: group.emoji);
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                padding: .symmetric(horizontal: AppSpacing.spaceSm.value, vertical: AppSpacing.space2xs.value),
                decoration: BoxDecoration(
                  color: hasReacted ? chatTheme.waveformBackgroundColor : theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.6),
                  borderRadius: .circular(AppRadius.full.value),
                  border: .all(
                    color: hasReacted ? chatTheme.onlineRingColor : theme.colorScheme.outlineVariant.withValues(alpha: 0.35),
                    width: hasReacted ? 1.2 : 0.8,
                  ),
                ),
                child: Row(
                  mainAxisSize: .min,
                  spacing: 4,
                  children: <Widget>[
                    Text(group.emoji, style: theme.textTheme.labelMedium?.copyWith(fontSize: 20)),
                    Text(
                      '${group.count}',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: hasReacted ? .bold : .normal,
                        color: hasReacted ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
