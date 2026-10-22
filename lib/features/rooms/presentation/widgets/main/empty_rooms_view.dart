import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/themes/extensions/rooms_theme_extension.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class EmptyRoomsView extends StatelessWidget {
  const new({required this.onCreateRoom, super.key});

  final VoidCallback onCreateRoom;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final RoomsThemeExtension roomsTheme = theme.extension<RoomsThemeExtension>() ?? .light;

    return Center(
      child: Padding(
        padding: .all(AppSpacing.spaceLg.value),
        child: Column(
          mainAxisSize: .min,
          spacing: AppSpacing.spaceMd.value,
          children: <Widget>[
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: .circle,
                gradient: roomsTheme.medaillonBackgroundGradient,
                border: .all(color: roomsTheme.onlineRingColor, width: 1.5),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: roomsTheme.onlineRingColor.withValues(alpha: 0.20),
                    blurRadius: 20,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Icon(Icons.forum_outlined, size: 34, color: roomsTheme.primaryTextColor),
            ),
            Text('Aucun salon pour le moment', style: theme.textTheme.titleLarge, textAlign: .center),
            Text(
              'Créez votre propre salon pour commencer à échanger ou attendez qu‘un membre vous invite.',
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
              textAlign: .center,
            ),
            const SizedBox(height: 4),
            ElevatedButton.icon(
              style: roomsTheme.primaryDecorationButton,
              onPressed: onCreateRoom,
              icon: const Icon(Icons.add_rounded, size: 18),
              label: const Text('Créer mon premier salon'),
            ),
          ],
        ),
      ),
    );
  }
}
