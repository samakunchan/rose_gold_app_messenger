import 'dart:async';

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/settings_signals.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class DataExportBottomSheet extends StatefulWidget {
  const new({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(borderRadius: .vertical(top: .circular(AppRadius.card.value))),
      builder: (_) => const DataExportBottomSheet(),
    );
  }

  @override
  State<DataExportBottomSheet> createState() => _DataExportBottomSheetState();
}

class _DataExportBottomSheetState extends State<DataExportBottomSheet> {
  final SettingsSignals _signals = kGetIt<SettingsSignals>();

  @override
  void initState() {
    super.initState();
    unawaited(_signals.generateDataExport());
  }

  Future<void> _copyJson(BuildContext context) async {
    final String? json = _signals.exportedJson.value;
    if (json == null || json.isEmpty) {
      return;
    }

    await Clipboard.setData(ClipboardData(text: json));
    if (context.mounted) {
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Export JSON copié dans le presse-papiers.')),
      );
    }
  }

  Future<void> _saveToFile(BuildContext context) async {
    final String? savedPath = await _signals.saveCurrentExportToFile();
    if (!context.mounted) {
      return;
    }

    Navigator.of(context).pop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          savedPath != null ? 'Fichier enregistré : $savedPath' : "Impossible d'enregistrer le fichier.",
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final TextTheme textTheme = theme.textTheme;
    final ColorScheme colorScheme = theme.colorScheme;

    return SignalBuilder(
      builder: (BuildContext context) {
        final bool isLoading = _signals.isExporting.value;
        final String? error = _signals.exportError.value;
        final String? jsonContent = _signals.exportedJson.value;

        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.72,
          minChildSize: 0.45,
          maxChildSize: 0.95,
          builder: (BuildContext context, ScrollController scrollController) {
            return Padding(
              padding: const .fromLTRB(20, 12, 20, 20),
              child: Column(
                crossAxisAlignment: .start,
                children: <Widget>[
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      margin: const .only(bottom: 16),
                      decoration: BoxDecoration(color: colorScheme.outlineVariant, borderRadius: .circular(2)),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Icon(Icons.download_outlined, color: colorScheme.primary),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text('Export de vos données (RGPD)', style: textTheme.titleMedium?.copyWith(fontWeight: .w700)),
                      ),
                      IconButton(icon: const Icon(Icons.close), onPressed: Navigator.of(context).pop),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Inclut votre profil, clé publique E2EE, salons, invitations, vos messages envoyés (déchiffrés localement) et vos préférences.',
                    style: textTheme.bodySmall?.copyWith(color: colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : error != null
                        ? Center(
                            child: Text(
                              error,
                              style: textTheme.bodyMedium?.copyWith(color: colorScheme.error),
                              textAlign: .center,
                            ),
                          )
                        : Container(
                            width: .infinity,
                            decoration: BoxDecoration(
                              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.45),
                              borderRadius: .circular(12),
                              border: BorderSide(color: colorScheme.outlineVariant.withValues(alpha: 0.6)) == .none
                                  ? null
                                  : Border.all(color: colorScheme.outlineVariant.withValues(alpha: 0.6)),
                            ),
                            child: SingleChildScrollView(
                              controller: scrollController,
                              padding: const .all(12),
                              child: SelectableText(
                                jsonContent ?? '',
                                style: textTheme.bodySmall?.copyWith(fontFamily: 'monospace', height: 1.4),
                              ),
                            ),
                          ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    spacing: AppSpacing.spaceMd.value,
                    children: <Widget>[
                      Expanded(
                        child: OutlinedButton.icon(
                          onPressed: isLoading || jsonContent == null ? null : () => _saveToFile(context),
                          icon: const Icon(Icons.save_alt_outlined, size: 18),
                          label: const Text('Enregistrer'),
                        ),
                      ),
                      Expanded(
                        child: FilledButton.icon(
                          style: FilledButton.styleFrom(backgroundColor: kLightPrimaryColor, foregroundColor: kLightOnPrimaryColor),
                          onPressed: isLoading || jsonContent == null ? null : () => _copyJson(context),
                          icon: const Icon(Icons.copy_outlined, size: 18),
                          label: const Text('Copier le JSON'),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
