import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/view_models/message_view_model.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_media_attachment_bubble.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/widgets/monogram_user.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ChatMessageBubble extends StatelessWidget {
  const new({required this.message, super.key});

  final MessageViewModel message;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ChatThemeExtension chatTheme = theme.extension<ChatThemeExtension>() ?? .light;
    final bool isMe = message.isMe;

    final BoxDecoration bubbleDecoration = isMe
        ? BoxDecoration(
            gradient: chatTheme.outgoingBubbleGradient,
            borderRadius: chatTheme.outgoingBorderRadius,
            border: chatTheme.outgoingBorder,
            boxShadow: chatTheme.outgoingShadows,
          )
        : BoxDecoration(
            color: chatTheme.incomingBubbleColor,
            borderRadius: chatTheme.incomingBorderRadius,
            border: chatTheme.incomingBorder,
            boxShadow: chatTheme.incomingShadows,
          );

    final Color textColor = isMe ? chatTheme.outgoingTextColor : chatTheme.incomingTextColor;
    final Color usernameColor = isMe ? textColor.withValues(alpha: 0.9) : theme.colorScheme.primary;

    return Padding(
      padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceXs.value),
      child: Row(
        mainAxisAlignment: isMe ? .end : .start,
        crossAxisAlignment: .end,
        spacing: AppSpacing.spaceSm.value,
        children: <Widget>[
          if (!isMe) MonogramUser(username: message.senderUsername, avatarUrl: message.senderAvatarUrl, size: 34),
          Flexible(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.82),
              child: Container(
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

                    /// Si c'est une message
                    if (message.content.isNotEmpty)
                      Text(
                        message.content,
                        style: theme.textTheme.bodyMedium?.copyWith(color: textColor),
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
        ],
      ),
    );
  }
}
