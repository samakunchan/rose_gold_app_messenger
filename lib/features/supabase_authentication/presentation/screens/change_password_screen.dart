import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/forms/password_text_field.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/show_auth_errors_sheet.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/widgets_export.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:rose_gold_app_messenger/themes/widgets/widgets_export.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangePasswordScreen extends SignalStatefulWidget {
  const new({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
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

  void _validatePasswords() {
    final String password = _newPasswordController.text;
    final String confirm = _confirmPasswordController.text;
    _canSubmit.value = password.length >= 6 && password == confirm;
  }

  Future<void> _handleCancel() async {
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    authSignals.showPasswordScreen.value = false;
    await authSignals.signOut();

    if (!mounted) {
      return;
    }

    rootNavigatorKey.currentState?.popUntil((Route<dynamic> route) => route.isFirst);
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
      showAuthErrorSheet(context: context, title: 'Erreur', message: authSignals.authError.value!);
    } else {
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;
    final AuthSignals authSignals = kGetIt<AuthSignals>();

    final String password = _newPasswordController.text;
    final String confirm = _confirmPasswordController.text;
    final bool passwordsMatch = password.isNotEmpty && confirm.isNotEmpty && password == confirm;
    final bool lengthValid = password.length >= 6;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, _) async {
        if (!didPop) {
          await _handleCancel();
        }
      },
      child: Scaffold(
        body: Container(
          width: .infinity,
          height: .infinity,
          decoration: BoxDecoration(gradient: frontTheme.screenBackgroundGradient),
          child: Stack(
            children: <Widget>[
              /// Ambient Decorative Glow Orbs
              SplashScreenCircleBackground(
                top: -60,
                right: -50,
                size: 280,
                color: theme.colorScheme.primaryContainer.withValues(alpha: 0.16),
              ),
              SplashScreenCircleBackground(
                bottom: 40,
                left: -60,
                size: 320,
                color: theme.colorScheme.secondaryContainer.withValues(alpha: 0.14),
              ),

              /// Transparency Layer
              const TransparencyLayer(),

              /// Main Content
              SafeArea(
                child: SingleChildScrollView(
                  padding: .symmetric(
                    horizontal: AppSpacing.spaceLg.value,
                    vertical: AppSpacing.spaceBase.value,
                  ),
                  child: Column(
                    spacing: AppSpacing.spaceLg.value,
                    children: <Widget>[
                      // Top Bar
                      const AuthTopHeader(),

                      // Title
                      const AuthMainTitle(
                        title: 'Nouveau mot de passe',
                        tagline: 'Définissez votre nouveau mot de passe confidentiel',
                      ),

                      // Card
                      FrontCardContainer(
                        child: Column(
                          crossAxisAlignment: .stretch,
                          spacing: AppSpacing.spaceBase.value,
                          children: <Widget>[
                            Text(
                              'Votre lien de récupération a été validé avec succès. Saisissez votre nouveau mot de passe (au moins 6 caractères) pour finaliser.',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                height: 1.4,
                              ),
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
                                  style: frontTheme.elevatedButtonStyle,
                                  iconAlignment: .end,
                                  onPressed: canSubmit ? _handleSubmitPassword : null,
                                  icon: isLoading
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(strokeWidth: 2),
                                        )
                                      : const Icon(Icons.arrow_forward, size: 18),
                                  label: Text(isLoading ? 'Enregistrement en cours...' : 'Enregistrer mon mot de passe'),
                                );
                              },
                            ),
                            TextButton(
                              onPressed: _handleCancel,
                              child: const Text('Annuler et revenir à la connexion'),
                            ),
                          ],
                        ),
                      ),

                      // Security Footer
                      const AuthSecurityInfosFooter(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
