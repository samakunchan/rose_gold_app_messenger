import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';

void showAuthErrorSheet({
  required BuildContext context,
  required String title,
  required String message,
  String? actionLabel,
  VoidCallback? onAction,
}) {
  // 1. Ferme le clavier pour une animation fluide
  FocusScope.of(context).unfocus();

  // 2. Retour haptique discret pour marquer l'erreur
  unawaited(HapticFeedback.lightImpact());

  final ThemeData theme = Theme.of(context);
  final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;

  unawaited(
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent, // Permet les coins arrondis et le style carte
      builder: (BuildContext sheetContext) {
        return Container(
          padding: .symmetric(horizontal: AppSpacing.spaceLg.value, vertical: AppSpacing.spaceBase.value),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: const .vertical(top: .circular(28)),
            boxShadow: <BoxShadow>[
              BoxShadow(color: Colors.black.withValues(alpha: 0.15), blurRadius: 20, offset: const Offset(0, -5)),
            ],
          ),
          child: SafeArea(
            child: Column(
              mainAxisSize: .min,
              spacing: AppSpacing.spaceBase.value,
              children: <Widget>[
                // Barre de drag supérieure
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3), borderRadius: .circular(2)),
                ),

                const SizedBox(height: 4),

                // Icône d'alerte stylisée Rose Gold / Erreur
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(color: theme.colorScheme.errorContainer.withValues(alpha: 0.4), shape: .circle),
                  child: Icon(Icons.error_outline_rounded, color: theme.colorScheme.error, size: 28),
                ),

                // Titre de l'erreur
                Text(
                  title,
                  textAlign: .center,
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: .bold, letterSpacing: 0.5),
                ),

                // Message explicatif
                Text(
                  message,
                  textAlign: .center,
                  style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4),
                ),

                const SizedBox(height: 8),

                // Action secondaire (ex: "Mot de passe oublié ?")
                if (actionLabel != null && onAction != null) ...<Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(sheetContext).pop();
                      onAction();
                    },
                    child: Text(actionLabel),
                  ),
                ],

                // Bouton principal pour fermer / réessayer
                SizedBox(
                  width: .infinity,
                  child: ElevatedButton(
                    style: frontTheme.elevatedButtonStyle,
                    onPressed: Navigator.of(sheetContext).pop,
                    child: const Text('Compris'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
