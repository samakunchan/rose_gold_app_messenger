import 'dart:async';

import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/chat/presentation/signals/chat_signals.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class E2eePassphraseBottomSheet extends StatefulWidget {
  const new({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const E2eePassphraseBottomSheet(),
    );
  }

  @override
  State<E2eePassphraseBottomSheet> createState() => _E2eePassphraseBottomSheetState();
}

class _E2eePassphraseBottomSheetState extends State<E2eePassphraseBottomSheet> {
  final TextEditingController _customPhraseController = TextEditingController();
  bool _isObscured = true;
  bool _isCustomMode = false;

  @override
  void initState() {
    super.initState();
    unawaited(kGetIt<ChatSignals>().loadPassphrase());
  }

  @override
  void dispose() {
    _customPhraseController.dispose();
    super.dispose();
  }

  Future<void> _handleSaveCustomPhrase() async {
    final String text = _customPhraseController.text.trim();
    if (text.isEmpty) {
      return;
    }

    final ChatSignals signals = kGetIt<ChatSignals>();
    final bool success = await signals.changePassphrase(text);

    if (mounted) {
      if (success) {
        setState(() {
          _isCustomMode = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Phrase secrète mise à jour avec succès !'),
            behavior: .floating,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de la mise à jour de la phrase.'),
            behavior: .floating,
          ),
        );
      }
    }
  }

  Future<void> _handleRegenerate() async {
    final ChatSignals signals = kGetIt<ChatSignals>();
    final String? newPhrase = await signals.generateNewRandomPassphrase();

    if (mounted && newPhrase != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Nouvelle phrase aléatoire générée et synchronisée !'),
          behavior: .floating,
        ),
      );
    }
  }

  void _handleCopy(String phrase) {
    unawaited(Clipboard.setData(ClipboardData(text: phrase)));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Phrase secrète copiée dans le presse-papiers !'),
        behavior: .floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final ChatSignals signals = kGetIt<ChatSignals>();

    return Container(
      padding: .only(
        left: AppSpacing.spaceLg.value,
        right: AppSpacing.spaceLg.value,
        top: AppSpacing.spaceLg.value,
        bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.spaceLg.value,
      ),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: .only(
          topLeft: .circular(AppRadius.dialog.value),
          topRight: .circular(AppRadius.dialog.value),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: .min,
            crossAxisAlignment: .start,
            spacing: AppSpacing.spaceMd.value,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.vpn_key_rounded,
                    color: theme.colorScheme.primary,
                    size: 28,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Phrase Secrète E2EE',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: .bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Text(
                'Cette phrase secrète permet de dériver vos clés de chiffrement Zero-Knowledge. '
                'Vous pouvez la conserver pour restaurer vos clés ou la personnaliser à tout moment.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              SignalBuilder(
                builder: (_) {
                  final bool isLoading = signals.isPassphraseLoading.value;
                  final String currentPhrase = signals.currentPassphrase.value ?? 'Chargement...';

                  if (isLoading) {
                    return const Center(
                      child: Padding(
                        padding: .all(24),
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  if (_isCustomMode) {
                    return Column(
                      crossAxisAlignment: .start,
                      spacing: AppSpacing.spaceSm.value,
                      children: <Widget>[
                        TextField(
                          controller: _customPhraseController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Entrez votre phrase secrète personnalisée...',
                            border: OutlineInputBorder(
                              borderRadius: .circular(AppRadius.card.value),
                            ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    _isCustomMode = false;
                                  });
                                },
                                child: const Text('Annuler'),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: _handleSaveCustomPhrase,
                                child: const Text('Enregistrer'),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  }

                  return Container(
                    width: .infinity,
                    padding: .all(AppSpacing.spaceMd.value),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                      borderRadius: .circular(AppRadius.card.value),
                      border: Border.all(
                        color: theme.colorScheme.outlineVariant.withValues(alpha: 0.6),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: .start,
                      spacing: AppSpacing.spaceSm.value,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: .spaceBetween,
                          children: <Widget>[
                            Text(
                              'Phrase de récupération active :',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: theme.colorScheme.outline,
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                _isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                                size: 20,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isObscured = !_isObscured;
                                });
                              },
                            ),
                          ],
                        ),
                        Text(
                          _isObscured ? '•••• •••• •••• •••• •••• •••• •••• •••• •••• •••• •••• ••••' : currentPhrase,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontFamily: 'monospace',
                            fontWeight: .bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: <Widget>[
                            OutlinedButton.icon(
                              icon: const Icon(Icons.copy_rounded, size: 16),
                              label: const Text('Copier'),
                              onPressed: () => _handleCopy(currentPhrase),
                            ),
                            OutlinedButton.icon(
                              icon: const Icon(Icons.refresh_rounded, size: 16),
                              label: const Text('Nouvelle aléatoire'),
                              onPressed: _handleRegenerate,
                            ),
                            FilledButton.tonalIcon(
                              icon: const Icon(Icons.edit_outlined, size: 16),
                              label: const Text('Personnaliser'),
                              onPressed: () {
                                _customPhraseController.text = currentPhrase;
                                setState(() {
                                  _isCustomMode = true;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
