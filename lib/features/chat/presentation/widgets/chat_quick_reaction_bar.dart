import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_reaction_item_button.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_reaction_picker_bottom_sheet.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ChatQuickReactionBar extends StatelessWidget {
  const new({super.key});

  static const List<String> _initialEmojis = <String>[
    '❤️',
    '👍',
    '😂',
    '😮',
    '😢',
    '🔥',
    '🎉',
    '👏',
    '🙏',
    '💯',
  ];

  static const List<String> _allEmojis = <String>[
    '❤️',
    '👍',
    '😂',
    '😮',
    '😢',
    '🔥',
    '🎉',
    '👏',
    '🙏',
    '💯',
    '😍',
    '🥰',
    '😘',
    '🤩',
    '🥳',
    '😎',
    '🤔',
    '🤫',
    '🙄',
    '😴',
    '🤯',
    '😱',
    '😡',
    '🤬',
    '💩',
    '👻',
    '💀',
    '👀',
    '🚀',
    '✨',
  ];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ChatThemeExtension chatTheme = theme.extension<ChatThemeExtension>() ?? .light;

    return Container(
      width: .infinity,
      padding: .symmetric(
        horizontal: AppSpacing.spaceSm.value,
        vertical: AppSpacing.spaceSm.value,
      ),
      decoration: BoxDecoration(
        color: chatTheme.incomingBubbleColor,
        borderRadius: .circular(AppRadius.lg.value),
        border: .all(color: chatTheme.onlineRingColor.withValues(alpha: 0.65), width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: chatTheme.onlineRingColor.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: Row(
          spacing: AppSpacing.spaceSm.value,
          children: <Widget>[
            for (final String emoji in _initialEmojis)
              ChatReactionItemButton(
                emoji: emoji,
                onTap: () {},
              ),
            ChatReactionItemButton(
              icon: Icons.add_rounded,
              onTap: () {
                ChatReactionPickerBottomSheet.show(context, emojis: _allEmojis);
              },
            ),
          ],
        ),
      ),
    );
  }
}
