import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/screens/reset_password_screen.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/view_models/credentials_saved_view_model.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/forms/password_text_field.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/show_auth_errors_sheet.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AuthLoginForm extends StatefulWidget {
  const new({required this.onAuthenticate, super.key});

  final Future<void> Function({required String email, required String password, bool rememberMe}) onAuthenticate;

  @override
  State<AuthLoginForm> createState() => _AuthLoginFormState();
}

class _AuthLoginFormState extends State<AuthLoginForm> {
  bool _rememberMe = true;

  final TextEditingController _identifierController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late final void Function() _disposeEffect;

  @override
  void initState() {
    super.initState();
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    _disposeEffect = effect(() {
      final CredentialsSavedViewModel? creds = authSignals.credentialsSaved.value;
      if (creds != null) {
        _identifierController.text = creds.emailSaved;
        _passwordController.text = creds.passwordSaved;
      }
    });
  }

  @override
  void dispose() {
    _disposeEffect();
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;

    return Column(
      crossAxisAlignment: .stretch,
      spacing: AppSpacing.spaceBase.value,
      children: <Widget>[
        // Identifier Field
        Column(
          crossAxisAlignment: .start,
          spacing: AppSpacing.spaceXs.value,
          children: <Widget>[
            Text(
              'NUMÉRO DE MOBILE OU EMAIL',
              style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant, letterSpacing: 1.2, fontWeight: .w600),
            ),
            TextField(
              controller: _identifierController,
              keyboardType: .emailAddress,
              decoration: const InputDecoration(hintText: 'exemple@gmail.com', prefixIcon: Icon(Icons.alternate_email, size: 20)),
            ),
          ],
        ),

        // Password Field
        PasswordTextField(controller: _passwordController, text: 'MOT DE PASSE', hintText: '••••••••'),

        // Remember Me & Forgot Password
        Row(
          mainAxisAlignment: .spaceBetween,
          children: <Widget>[
            Row(
              spacing: AppSpacing.spaceXs.value,
              children: <Widget>[
                Checkbox(
                  value: _rememberMe,
                  onChanged: (bool? val) => setState(() => _rememberMe = val ?? false),
                ),
                Text(
                  'Se souvenir de moi',
                  style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => const ResetPasswordScreen()));
              },
              child: Text(
                'Code oublié ?',
                style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.secondary),
              ),
            ),
          ],
        ),

        // Primary Action Button
        SignalBuilder(
          builder: (_) {
            return ElevatedButton.icon(
              style: frontTheme.elevatedButtonStyle,
              iconAlignment: .end,
              onPressed: () async {
                await widget.onAuthenticate(email: _identifierController.text, password: _passwordController.text, rememberMe: _rememberMe);
                final AuthSignals authSignals = kGetIt<AuthSignals>();
                if (authSignals.authError.value != null && context.mounted) {
                  showAuthErrorSheet(
                    context: context,
                    title: 'Échec de la connexion',
                    message: authSignals.authError.value!,
                    actionLabel: 'Code ou mot de passe oublié ?',
                    onAction: () {
                      Navigator.of(context).push(
                        MaterialPageRoute<void>(builder: (_) => const ResetPasswordScreen()),
                      );
                    },
                  );
                }
              },
              icon: const Icon(Icons.arrow_forward, size: 18),
              label: const Text('Se connecter'),
            );
          },
        ),
      ],
    );
  }
}
