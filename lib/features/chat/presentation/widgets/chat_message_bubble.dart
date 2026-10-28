import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/view_models/message_view_model.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ChatMessageBubble extends StatelessWidget {
  const new({
    required this.message,
    super.key,
  });

  final MessageViewModel message;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ChatThemeExtension chatTheme = theme.extension<ChatThemeExtension>() ?? .light;
    final bool isMe = message.isMe;

    final Alignment bubbleAlignment = isMe ? .centerRight : .centerLeft;
    final BoxDecoration bubbleDecoration = isMe
        ? BoxDecoration(
            gradient: chatTheme.outgoingBubbleGradient,
            borderRadius: chatTheme.outgoingBorderRadius,
            border: chatTheme.outgoingBorder,
            boxShadow: chatTheme.outgoingShadows,
            // color: chatTheme.incomingBubbleColor,
          )
        : BoxDecoration(
            color: chatTheme.incomingBubbleColor,
            borderRadius: chatTheme.incomingBorderRadius,
            border: chatTheme.incomingBorder,
            boxShadow: chatTheme.incomingShadows,
          );

    final Color textColor = isMe ? chatTheme.outgoingTextColor : chatTheme.incomingTextColor;

    return Align(
      alignment: bubbleAlignment,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: MediaQuery.sizeOf(context).width * 0.75),
        child: Container(
          margin: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceXs.value),
          padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceSm.value),
          decoration: bubbleDecoration,
          child: Column(
            crossAxisAlignment: isMe ? .end : .start,
            mainAxisSize: .min,
            spacing: AppSpacing.spaceXs.value,
            children: <Widget>[
              Text(message.content, style: theme.textTheme.bodyMedium?.copyWith(color: textColor)),
              Row(
                mainAxisSize: .min,
                children: <Widget>[
                  Text(
                    message.createdAt,
                    style: theme.textTheme.labelSmall?.copyWith(color: textColor.withValues(alpha: 0.7), fontSize: 10),
                  ),
                  if (isMe) ...<Widget>[
                    const SizedBox(width: 4),
                    Icon(
                      Icons.done_all,
                      size: 14,
                      color: textColor.withValues(alpha: 0.7),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
