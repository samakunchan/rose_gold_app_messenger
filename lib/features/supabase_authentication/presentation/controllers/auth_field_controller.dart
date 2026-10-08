import 'package:flutter/material.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AuthFieldController {
  // 👈 Des champs d'instance normaux (plus de static)
  final TextEditingController nameController = TextEditingController();
  final TextEditingController identifierController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController inviteCodeController = TextEditingController();

  final FlutterSignal<bool> errorAcceptCharter = signal(true);
  final FlutterSignal<String> name = signal('');
  final FlutterSignal<String> identifier = signal('');
  final FlutterSignal<String> password = signal('');
  final FlutterSignal<String> confirmPassword = signal('');

  late final ReadonlySignal<bool> isNameValid = computed(() {
    return name.value.trim().length >= 2;
  });

  late final ReadonlySignal<bool> isEmailValid = computed(() {
    final String val = identifier.value.trim();
    if (val.isEmpty) return false;
    return RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,}$').hasMatch(val);
  });

  late final ReadonlySignal<bool> passwordsMatch = computed(() {
    if (confirmPassword.value.isEmpty) return true;
    return password.value == confirmPassword.value;
  });

  late final ReadonlySignal<bool> passwordsLength = computed(() {
    if (confirmPassword.value.isEmpty) return true;
    return password.value.length >= 6;
  });

  late final ReadonlySignal<bool> canSubmit = computed(() {
    return isNameValid.value &&
        isEmailValid.value &&
        password.value.length >= 6 &&
        confirmPassword.value.isNotEmpty &&
        password.value == confirmPassword.value;
  });

  // 👈 Une seule méthode pour tout nettoyer proprement !
  void dispose() {
    nameController.dispose();
    identifierController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    inviteCodeController.dispose();
  }
}
