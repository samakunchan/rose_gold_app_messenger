import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ResetPasswordCodeStep extends SignalStatefulWidget {
  const new({
    required this.codeController,
    required this.email,
    required this.onCodeValidated,
    required this.onResendCode,
    required this.onChangeEmail,
    super.key,
  });

  final TextEditingController codeController;
  final String email;
  final VoidCallback onCodeValidated;
  final VoidCallback onResendCode;
  final VoidCallback onChangeEmail;

  @override
  State<ResetPasswordCodeStep> createState() => _ResetPasswordCodeStepState();
}

class _ResetPasswordCodeStepState extends State<ResetPasswordCodeStep> {
  late final FlutterSignal<int> _codeLength = signal(widget.codeController.text.trim().length);

  @override
  void initState() {
    super.initState();
    widget.codeController.addListener(_handleCodeChanged);
  }

  @override
  void dispose() {
    widget.codeController.removeListener(_handleCodeChanged);
    super.dispose();
  }

  void _handleCodeChanged() {
    _codeLength.value = widget.codeController.text.trim().length;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;

    final int length = _codeLength.value;
    final bool isCodeValid = length == 6 && RegExp(r'^\d{6}$').hasMatch(widget.codeController.text.trim());

    return Column(
      crossAxisAlignment: .stretch,
      spacing: AppSpacing.spaceBase.value,
      children: <Widget>[
        Column(
          crossAxisAlignment: .start,
          spacing: AppSpacing.space2xs.value,
          children: <Widget>[
            Text(
              'Un code de sécurité a été envoyé à :',
              style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
            ),
            Text(
              widget.email,
              style: theme.textTheme.titleSmall?.copyWith(color: theme.colorScheme.primary, fontWeight: .w600),
            ),
          ],
        ),
        Column(
          crossAxisAlignment: .start,
          spacing: AppSpacing.spaceSm.value,
          children: <Widget>[
            Text(
              'CODE DE CONFIRMATION (6 CHIFFRES)',
              style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, letterSpacing: 1.2, fontWeight: .w600),
            ),
            TextField(
              controller: widget.codeController,
              keyboardType: .number,
              textAlign: .center,
              style: const TextStyle(letterSpacing: 8, fontSize: 22, fontWeight: .w600),
              decoration: const InputDecoration(
                hintText: '••••••',
                counterText: '',
                prefixIcon: Icon(Icons.pin_outlined, size: 20),
                suffixIcon: Icon(Icons.key, size: 20),
              ),
            ),
            Row(
              spacing: AppSpacing.space2xs.value,
              children: <Widget>[
                Icon(
                  isCodeValid ? Icons.check_circle_outline : Icons.info_outline,
                  size: 16,
                  color: isCodeValid ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                ),
                Text(
                  isCodeValid ? 'Code à 6 chiffres complet' : '$length / 6 chiffres saisis',
                  style: theme.textTheme.labelSmall?.copyWith(
                    color: isCodeValid ? theme.colorScheme.primary : theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
        ElevatedButton.icon(
          style: frontTheme.elevatedButtonStyle,
          iconAlignment: .end,
          onPressed: isCodeValid ? widget.onCodeValidated : null,
          icon: const Icon(Icons.arrow_forward, size: 18),
          label: const Text('Valider le code'),
        ),
        Row(
          mainAxisAlignment: .spaceBetween,
          children: <Widget>[
            TextButton(onPressed: widget.onChangeEmail, child: const Text('Changer d’email')),
            TextButton(onPressed: widget.onResendCode, child: const Text('Renvoyer le code')),
          ],
        ),
      ],
    );
  }
}
