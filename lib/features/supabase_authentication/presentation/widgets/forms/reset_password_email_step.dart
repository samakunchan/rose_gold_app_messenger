import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ResetPasswordEmailStep extends StatelessWidget {
  const new({required this.emailController, required this.onSendCode, super.key});

  final TextEditingController emailController;
  final VoidCallback onSendCode;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;
    final AuthSignals authSignals = kGetIt<AuthSignals>();

    return Column(
      crossAxisAlignment: .stretch,
      spacing: AppSpacing.spaceBase.value,
      children: <Widget>[
        Text(
          'Entrez l’adresse email associée à votre compte. Nous vous enverrons un code de sécurité à 6 chiffres.',
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4),
        ),
        Column(
          crossAxisAlignment: .start,
          spacing: AppSpacing.spaceXs.value,
          children: <Widget>[
            Text(
              'ADRESSE EMAIL',
              style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, letterSpacing: 1.2, fontWeight: .w600),
            ),
            TextField(
              controller: emailController,
              keyboardType: .emailAddress,
              decoration: const InputDecoration(hintText: 'exemple@gmail.com', prefixIcon: Icon(Icons.alternate_email, size: 20)),
            ),
          ],
        ),
        SignalBuilder(
          builder: (_) {
            final bool isLoading = authSignals.isLoading.value;

            return ElevatedButton.icon(
              style: frontTheme.elevatedButtonStyle,
              iconAlignment: .end,
              onPressed: isLoading ? null : onSendCode,
              icon: isLoading
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Icon(Icons.arrow_forward, size: 18),
              label: Text(isLoading ? 'Envoi en cours...' : 'Envoyer le code'),
            );
          },
        ),
      ],
    );
  }
}
