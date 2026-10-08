import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/themes/static_spacing.dart';
import 'package:signals_flutter/signals_flutter.dart';

class PasswordTextField extends SignalStatefulWidget {
  const new({required this.controller, required this.text, required this.hintText, this.errorText, this.onChanged, super.key});

  final TextEditingController controller;
  final String text;
  final String? hintText;
  final String? errorText;
  final ValueChanged<String>? onChanged;

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  late final FlutterSignal<bool> _obscurePassword = signal(true);

  @override
  Widget build(BuildContext context) {
    final bool isObscured = _obscurePassword.value;

    return Column(
      crossAxisAlignment: .start,
      spacing: AppSpacing.spaceXs.value,
      children: <Widget>[
        Text(widget.text),
        TextField(
          controller: widget.controller,
          obscureText: isObscured,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            hintText: widget.hintText,
            prefixIcon: const Icon(Icons.lock_reset, size: 20),
            error: widget.errorText != null ? Text(widget.errorText!) : null,
            suffixIcon: IconButton(
              icon: Icon(
                isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                size: 20,
              ),
              onPressed: () {
                _obscurePassword.value = !_obscurePassword.value;
              },
            ),
          ),
        ),
      ],
    );
  }
}
