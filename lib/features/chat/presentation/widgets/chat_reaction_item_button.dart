import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class ChatReactionItemButton extends StatelessWidget {
  const new({
    required this.onTap,
    this.emoji,
    this.icon,
    super.key,
  });

  final String? emoji;
  final IconData? icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ChatThemeExtension chatTheme = theme.extension<ChatThemeExtension>() ?? .light;

    return Material(
      type: .transparency,
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onTap,
        child: Container(
          width: 48,
          height: 48,
          alignment: .center,
          decoration: BoxDecoration(
            color: chatTheme.waveformBackgroundColor,
            shape: .circle,
          ),
          child: emoji != null
              ? Text(
                  emoji!,
                  style: theme.textTheme.headlineSmall?.copyWith(fontSize: 26),
                )
              : Icon(
                  icon ?? Icons.add_rounded,
                  size: 24,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
        ),
      ),
    );
  }
}
