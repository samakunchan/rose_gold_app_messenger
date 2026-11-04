import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/utils/emoji_catalog.dart';

class ChatMessageContentText extends StatelessWidget {
  const new({
    required this.content,
    required this.baseStyle,
    super.key,
  });

  final String content;
  final TextStyle? baseStyle;

  @override
  Widget build(BuildContext context) {
    final TextStyle defaultStyle = baseStyle ?? const TextStyle(fontSize: 15);
    final double defaultFontSize = defaultStyle.fontSize ?? 15;

    // 1. Si le message ne contient QUE des emojis (Solution 1 : Jumboji)
    if (EmojiData.isOnlyEmojis(content)) {
      final int count = EmojiData.countEmojis(content);
      final double emojiSize;
      if (count == 1) {
        emojiSize = 42;
      } else if (count <= 3) {
        emojiSize = 32;
      } else {
        emojiSize = 24;
      }

      return Text(
        content,
        style: defaultStyle.copyWith(
          fontSize: emojiSize,
          height: 1.25,
        ),
      );
    }

    // 2. Si le message contient du texte + des emojis (Solution 2 : Text.rich avec spans agrandis)
    final List<InlineSpan> spans = <InlineSpan>[];
    int lastEnd = 0;

    for (final Match match in EmojiData.emojiRegex.allMatches(content)) {
      if (match.start > lastEnd) {
        spans.add(
          TextSpan(
            text: content.substring(lastEnd, match.start),
            style: defaultStyle,
          ),
        );
      }

      spans.add(
        TextSpan(
          text: match.group(0),
          style: defaultStyle.copyWith(
            fontSize: defaultFontSize + 4, // Ex: 15 -> 19px pour que l'emoji ressorte bien
          ),
        ),
      );

      lastEnd = match.end;
    }

    if (lastEnd < content.length) {
      spans.add(
        TextSpan(
          text: content.substring(lastEnd),
          style: defaultStyle,
        ),
      );
    }

    if (spans.isEmpty) {
      return Text(content, style: defaultStyle);
    }

    return Text.rich(
      TextSpan(children: spans),
      style: defaultStyle,
    );
  }
}
