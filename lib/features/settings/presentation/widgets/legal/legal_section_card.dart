import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

class LegalSectionCard extends StatelessWidget {
  const new({
    required this.title,
    required this.paragraphs,
    this.bulletPoints = const <String>[],
    super.key,
  });

  final String title;
  final List<String> paragraphs;
  final List<String> bulletPoints;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return Card(
      margin: const .only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: .circular(AppRadius.card.value),
        side: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.5)),
      ),
      child: Padding(
        padding: const .all(16),
        child: Column(
          crossAxisAlignment: .start,
          children: <Widget>[
            Text(
              title,
              style: textTheme.titleMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: .w700,
              ),
            ),
            const SizedBox(height: 10),
            for (int i = 0; i < paragraphs.length; i++) ...<Widget>[
              Text(
                paragraphs[i],
                style: textTheme.bodyMedium?.copyWith(height: 1.5),
              ),
              if (i < paragraphs.length - 1 || bulletPoints.isNotEmpty) const SizedBox(height: 8),
            ],
            for (final String bullet in bulletPoints)
              Padding(
                padding: const .only(bottom: 6),
                child: Row(
                  crossAxisAlignment: .start,
                  children: <Widget>[
                    Padding(
                      padding: const .only(top: 7, right: 8),
                      child: Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: .circle,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        bullet,
                        style: textTheme.bodyMedium?.copyWith(height: 1.45),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
