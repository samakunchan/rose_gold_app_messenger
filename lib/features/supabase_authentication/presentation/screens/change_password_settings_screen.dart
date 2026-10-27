import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/core/errors/show_errors_sheet.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/auth_top_header.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/forms/password_text_field.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePasswordSettingScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<ChangePasswordSettingScreen> createState() => _ChangePasswordSettingScreenState();
}

class _ChangePasswordSettingScreenState extends State<ChangePasswordSettingScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  late final FlutterSignal<bool> _canSubmit = signal(false);

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_validatePasswords);
    _confirmPasswordController.addListener(_validatePasswords);
  }

  @override
  void dispose() {
    _newPasswordController.removeListener(_validatePasswords);
    _confirmPasswordController.removeListener(_validatePasswords);
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final AuthSignals authSignals = kGetIt<AuthSignals>();

    final String password = _newPasswordController.text;
    final String confirm = _confirmPasswordController.text;
    final bool passwordsMatch = password.isNotEmpty && confirm.isNotEmpty && password == confirm;
    final bool lengthValid = password.length >= 6;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: .all(AppSpacing.spaceBase.value),
          child: Column(
            crossAxisAlignment: .stretch,
            spacing: AppSpacing.spaceBase.value,
            children: <Widget>[
              const AuthTopHeader(),
              Text(
                'Mise à jour de mot de passe.',
                style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4),
              ),
              Text(
                'Une fois la mise à jour éffectuer, il faudra se reconnecter pour valider cette action.',
                style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant, height: 1.4),
              ),
              PasswordTextField(
                controller: _newPasswordController,
                text: 'NOUVEAU MOT DE PASSE',
                hintText: '••••••••',
              ),
              PasswordTextField(
                controller: _confirmPasswordController,
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
                    iconAlignment: .end,
                    onPressed: canSubmit ? _handleSubmitPassword : null,
                    icon: isLoading
                        ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.arrow_forward, size: 18),
                    label: Text(isLoading ? 'Enregistrement en cours...' : 'Mettre à jour mon mot de passe'),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _validatePasswords() {
    final String password = _newPasswordController.text;
    final String confirm = _confirmPasswordController.text;
    _canSubmit.value = password.length >= 6 && password == confirm;
  }

  Future<void> _handleSubmitPassword() async {
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    final Session? currentSession = kGetIt<SupabaseClient>().auth.currentSession;
    final String email = currentSession?.user.email ?? '';

    await authSignals.changePassword(
      email: email,
      password: _newPasswordController.text.trim(),
    );

    if (!mounted) {
      return;
    }

    if (authSignals.authError.value != null) {
      showErrorSheet(context: context, title: 'Erreur', message: authSignals.authError.value!);
    } else {
      authSignals.isLoginTab.value = true;
      authSignals.showPasswordScreen.value = false;
      await authSignals.signOut();

      if (!mounted) {
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Mot de passe mis à jour avec succès ! Veuillez vous connecter.')),
      );

      rootNavigatorKey.currentState?.popUntil((Route<dynamic> route) => route.isFirst);
    }
  }
}
