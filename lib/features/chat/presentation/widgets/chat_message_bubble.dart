import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/signals/chat_signals.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/view_models/message_view_model.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_media_attachment_bubble.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ChatMessageBubble extends StatelessWidget {
  const new({required this.message, super.key});

  final MessageViewModel message;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ChatThemeExtension chatTheme = theme.extension<ChatThemeExtension>() ?? .light;
    final ChatSignals chatSignals = kGetIt<ChatSignals>();
    final bool isMe = message.isMe;

    final Color textColor = isMe ? chatTheme.outgoingTextColor : chatTheme.incomingTextColor;
    final Color usernameColor = isMe ? textColor.withValues(alpha: 0.9) : theme.colorScheme.primary;

    return SignalBuilder(
      builder: (_) {
        final bool isSelected = chatSignals.selectedMessageId.value == message.id;

        final BoxDecoration bubbleDecoration = isMe
            ? (isSelected
                  ? chatTheme.selectedOutgoingBubbleDecoration
                  : BoxDecoration(
                      gradient: chatTheme.outgoingBubbleGradient,
                      borderRadius: chatTheme.outgoingBorderRadius,
                      border: chatTheme.outgoingBorder,
                      boxShadow: chatTheme.outgoingShadows,
                    ))
            : (isSelected
                  ? chatTheme.selectedIncomingBubbleDecoration
                  : BoxDecoration(
                      color: chatTheme.incomingBubbleColor,
                      borderRadius: chatTheme.incomingBorderRadius,
                      border: chatTheme.incomingBorder,
                      boxShadow: chatTheme.incomingShadows,
                    ));

        return Padding(
          padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceXs.value),
          child: Row(
            mainAxisAlignment: isMe ? .end : .start,
            crossAxisAlignment: .end,
            spacing: AppSpacing.spaceSm.value,
            children: <Widget>[
              if (!isMe) MonogramUser(username: message.senderUsername, avatarUrl: message.senderAvatarUrl, size: 34),
              Flexible(
                child: GestureDetector(
                  onLongPress: () => chatSignals.toggleSelectedMessage(message.id),
                  onTap: isSelected ? chatSignals.clearSelectedMessage : null,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.82),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      curve: Curves.easeOut,
                      padding: .symmetric(horizontal: AppSpacing.spaceLg.value, vertical: AppSpacing.spaceSm.value),
                      decoration: bubbleDecoration,
                      child: Column(
                        crossAxisAlignment: isMe ? .end : .start,
                        mainAxisSize: .min,
                        spacing: AppSpacing.spaceXs.value,
                        children: <Widget>[
                          /// Expediteur
                          Row(
                            mainAxisSize: .min,
                            spacing: AppSpacing.spaceXs.value,
                            children: <Widget>[
                              Text(
                                message.senderUsername,
                                style: theme.textTheme.labelMedium?.copyWith(color: usernameColor, fontWeight: .bold),
                              ),
                              Text(
                                '- ${message.createdAt}',
                                style: theme.textTheme.labelSmall?.copyWith(color: textColor.withValues(alpha: 0.7)),
                              ),
                            ],
                          ),

                          /// Si c'est une image
                          if (message.hasMedia) ChatMediaAttachmentBubble(message: message),

                          /// Si c'est un message
                          if (message.content.isNotEmpty)
                            Container(
                              padding: isSelected
                                  ? .symmetric(horizontal: AppSpacing.spaceXs.value, vertical: AppSpacing.space2xs.value)
                                  : .zero,
                              decoration: isSelected
                                  ? (isMe
                                        ? chatTheme.selectedOutgoingTextHighlightDecoration
                                        : chatTheme.selectedIncomingTextHighlightDecoration)
                                  : null,
                              child: Text(
                                message.content,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: textColor,
                                  fontWeight: isSelected ? .w600 : null,
                                ),
                              ),
                            ),
                          Row(
                            mainAxisSize: .min,
                            spacing: AppSpacing.spaceXs.value,
                            children: <Widget>[
                              Text(
                                message.hourTime,
                                style: theme.textTheme.labelSmall?.copyWith(color: textColor.withValues(alpha: 0.7)),
                              ),
                              if (isMe)
                                Icon(
                                  message.isRead ? Icons.done_all : Icons.done,
                                  size: 14,
                                  color: textColor.withValues(alpha: message.isRead ? 1.0 : 0.7),
                                ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
