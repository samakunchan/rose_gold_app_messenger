import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/extensions/front_theme_extension.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AuthRegisterButtonUnderCondition extends SignalStatefulWidget {
  const new({
    required this.nameController,
    required this.identifierController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.inviteCodeController,
    required this.onPressed,
    super.key,
  });
  final TextEditingController nameController;
  final TextEditingController identifierController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController inviteCodeController;
  final void Function() onPressed;

  @override
  State<AuthRegisterButtonUnderCondition> createState() => _AuthRegisterButtonUnderConditionState();
}

class _AuthRegisterButtonUnderConditionState extends State<AuthRegisterButtonUnderCondition> {
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;

    return ElevatedButton.icon(
      style: frontTheme.elevatedButtonStyle,
      iconAlignment: .end,
      onPressed: widget.onPressed,
      icon: const Icon(Icons.arrow_forward, size: 18),
      label: const Text('Créer mon compte'),
    );
  }
}
