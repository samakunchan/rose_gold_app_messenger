import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/forms/password_text_field.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ResetPasswordNewPasswordStep extends SignalStatefulWidget {
  const new({
    required this.newPasswordController,
    required this.confirmPasswordController,
    required this.onSubmit,
    required this.onBackToCode,
    super.key,
  });

  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;
  final VoidCallback onSubmit;
  final VoidCallback onBackToCode;

  @override
  State<ResetPasswordNewPasswordStep> createState() => _ResetPasswordNewPasswordStepState();
}

class _ResetPasswordNewPasswordStepState extends State<ResetPasswordNewPasswordStep> {
  late final FlutterSignal<bool> _canSubmit = signal(false);

  @override
  void initState() {
    super.initState();
    widget.newPasswordController.addListener(_validatePasswords);
    widget.confirmPasswordController.addListener(_validatePasswords);
    _validatePasswords();
  }

  @override
  void dispose() {
    widget.newPasswordController.removeListener(_validatePasswords);
    widget.confirmPasswordController.removeListener(_validatePasswords);
    super.dispose();
  }

  void _validatePasswords() {
    final String password = widget.newPasswordController.text;
    final String confirm = widget.confirmPasswordController.text;
    final bool isValid = password.length >= 6 && password == confirm;
    _canSubmit.value = isValid;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;
    final AuthSignals authSignals = kGetIt<AuthSignals>();

    final String password = widget.newPasswordController.text;
    final String confirm = widget.confirmPasswordController.text;
    final bool passwordsMatch = password.isNotEmpty && confirm.isNotEmpty && password == confirm;
    final bool lengthValid = password.length >= 6;

    return Column(
      crossAxisAlignment: .stretch,
      spacing: AppSpacing.spaceBase.value,
      children: <Widget>[
        Text(
          'Définissez votre nouveau mot de passe (au moins 6 caractères).',
          style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
        ),
        PasswordTextField(
          controller: widget.newPasswordController,
          text: 'NOUVEAU MOT DE PASSE',
          hintText: '••••••••',
        ),
        PasswordTextField(
          controller: widget.confirmPasswordController,
          text: 'CONFIRMER LE MOT DE PASSE',
          hintText: '••••••••',
        ),
        if (confirm.isNotEmpty && !passwordsMatch)
          Text(
            'Les mots de passe ne correspondent pas.',
            style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.error),
          )
        else if (password.isNotEmpty && !lengthValid)
          Text(
            'Le mot de passe doit comporter au moins 6 caractères.',
            style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.error),
          ),
        SignalBuilder(
          builder: (_) {
            final bool isLoading = authSignals.isLoading.value;
            final bool canSubmit = _canSubmit.value && !isLoading;

            return ElevatedButton.icon(
              style: frontTheme.elevatedButtonStyle,
              iconAlignment: .end,
              onPressed: canSubmit ? widget.onSubmit : null,
              icon: isLoading
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.arrow_forward, size: 18),
              label: Text(isLoading ? 'Modification en cours...' : 'Changer mon mot de passe'),
            );
          },
        ),
        TextButton(
          onPressed: widget.onBackToCode,
          child: const Text('Corriger le code'),
        ),
      ],
    );
  }
}
