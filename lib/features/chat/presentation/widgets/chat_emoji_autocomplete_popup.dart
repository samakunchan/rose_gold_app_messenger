import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/utils/emoji_catalog.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ChatEmojiAutocompletePopup extends StatelessWidget {
  const new({required this.suggestions, required this.onSelectEmoji, super.key});

  final List<EmojiData> suggestions;
  final ValueChanged<EmojiData> onSelectEmoji;

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    final ThemeData theme = Theme.of(context);
    final ChatThemeExtension chatTheme = theme.extension<ChatThemeExtension>() ?? .light;

    return Container(
      constraints: const BoxConstraints(maxHeight: 180),
      margin: .symmetric(
        horizontal: AppSpacing.spaceMd.value,
        vertical: AppSpacing.space2xs.value,
      ),
      decoration: BoxDecoration(
        color: chatTheme.incomingBubbleColor,
        borderRadius: .circular(AppRadius.md.value),
        border: .all(color: chatTheme.onlineRingColor.withValues(alpha: 0.65), width: 1),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: chatTheme.onlineRingColor.withValues(alpha: 0.18),
            blurRadius: 12,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: .circular(AppRadius.md.value),
        child: ListView.separated(
          shrinkWrap: true,
          padding: .symmetric(vertical: AppSpacing.space2xs.value),
          itemCount: suggestions.length,
          separatorBuilder: (_, _) => Divider(height: 1, color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3)),
          itemBuilder: (BuildContext context, int index) {
            final EmojiData item = suggestions[index];
            return Material(
              type: .transparency,
              child: InkWell(
                onTap: () => onSelectEmoji(item),
                child: Padding(
                  padding: .symmetric(horizontal: AppSpacing.spaceMd.value, vertical: AppSpacing.spaceXs.value),
                  child: Row(
                    spacing: AppSpacing.spaceSm.value,
                    children: <Widget>[
                      Text(item.emoji, style: const TextStyle(fontSize: 20)),
                      Text(
                        ':${item.shortcode}:',
                        style: theme.textTheme.labelMedium?.copyWith(fontWeight: .bold, color: theme.colorScheme.primary),
                      ),
                      Expanded(
                        child: Text(
                          item.name,
                          overflow: .ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
