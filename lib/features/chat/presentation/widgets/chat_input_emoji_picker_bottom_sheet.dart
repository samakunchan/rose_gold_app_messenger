import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/utils/emoji_catalog.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/widgets/chat_reaction_item_button.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ChatInputEmojiPickerBottomSheet extends StatelessWidget {
  const new({required this.onSelectEmoji, super.key});

  final ValueChanged<String> onSelectEmoji;

  static Future<void> show(BuildContext context, {required ValueChanged<String> onSelectEmoji}) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) => ChatInputEmojiPickerBottomSheet(onSelectEmoji: onSelectEmoji),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ChatThemeExtension chatTheme = theme.extension<ChatThemeExtension>() ?? .light;
    const List<EmojiData> allEmojis = EmojiData.catalog;

    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.sizeOf(context).height * 0.55,
      ),
      padding: .symmetric(horizontal: AppSpacing.spaceLg.value, vertical: AppSpacing.spaceMd.value),
      decoration: BoxDecoration(
        color: chatTheme.incomingBubbleColor,
        borderRadius: .only(topLeft: .circular(AppRadius.xl.value), topRight: .circular(AppRadius.xl.value)),
        border: .all(color: chatTheme.onlineRingColor.withValues(alpha: 0.65), width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: chatTheme.onlineRingColor.withValues(alpha: 0.22),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: .stretch,
        spacing: AppSpacing.spaceMd.value,
        children: <Widget>[
          Center(
            child: Container(
              width: 36,
              height: 4,
              decoration: BoxDecoration(
                color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                borderRadius: .circular(AppRadius.full.value),
              ),
            ),
          ),
          Text(
            'Insérer un émoticône',
            style: theme.textTheme.titleMedium?.copyWith(fontWeight: .bold, color: theme.colorScheme.onSurface),
          ),
          Expanded(
            child: GridView.builder(
              physics: const BouncingScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5, mainAxisSpacing: 12, crossAxisSpacing: 12),
              itemCount: allEmojis.length,
              itemBuilder: (BuildContext context, int index) {
                final String emoji = allEmojis[index].emoji;

                return Center(
                  child: ChatReactionItemButton(
                    emoji: emoji,
                    onTap: () {
                      Navigator.of(context).pop();
                      onSelectEmoji(emoji);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
