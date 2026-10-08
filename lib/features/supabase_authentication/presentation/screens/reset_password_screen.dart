import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/show_auth_errors_sheet.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/widgets_export.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:rose_gold_app_messenger/themes/widgets/widgets_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class ResetPasswordScreen extends SignalStatefulWidget {
  const new({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  late final FlutterSignal<int> _currentStep = signal(kGetIt<AuthSignals>().isRecoverPassword.value ? 1 : 0);

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSendCode() async {
    final String email = _emailController.text.trim();
    if (email.isEmpty || !email.contains('@')) {
      showAuthErrorSheet(
        context: context,
        title: 'Email invalide',
        message: 'Veuillez renseigner une adresse email valide pour continuer.',
      );
      return;
    }

    final AuthSignals authSignals = kGetIt<AuthSignals>();
    await authSignals.forgotPassword(email: email);
    if (!mounted) {
      return;
    }

    if (authSignals.authError.value != null) {
      showAuthErrorSheet(
        context: context,
        title: 'Échec de l’envoi',
        message: authSignals.authError.value!,
        actionLabel: 'Patientez environ 1 minute avant de réessayer.',
      );
    } else {
      _currentStep.value = 1;
    }
  }

  void _handleCodeValidated() {
    _currentStep.value = 2;
  }

  void _handleChangeEmail() {
    _currentStep.value = 0;
  }

  Future<void> _handleResendCode() async {
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    await authSignals.forgotPassword(email: _emailController.text.trim());
    if (!mounted) {
      return;
    }

    if (authSignals.authError.value != null) {
      showAuthErrorSheet(context: context, title: 'Échec du renvoi', message: authSignals.authError.value!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Un nouveau code de sécurité vous a été envoyé.')),
      );
    }
  }

  Future<void> _handleChangePassword() async {
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    await authSignals.changePassword(
      email: _emailController.text.trim(),
      password: _newPasswordController.text.trim(),
      code: _codeController.text.trim(),
    );
    if (!mounted) {
      return;
    }

    if (authSignals.authError.value != null) {
      showAuthErrorSheet(context: context, title: 'Erreur de réinitialisation', message: authSignals.authError.value!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Votre mot de passe a été réinitialisé avec succès !')),
      );
      Navigator.of(context).pop();
    }
  }

  void _handleBackToCode() {
    _currentStep.value = 1;
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;
    final int step = _currentStep.value;

    return Scaffold(
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
                    // Top Navigation Header
                    const AuthTopHeader(),

                    // Screen Title
                    const AuthMainTitle(
                      title: 'Récupération',
                      tagline: 'Réinitialisez votre mot de passe en toute sécurité',
                    ),

                    // Frosted Card Stepper
                    FrontCardContainer(
                      child: Column(
                        spacing: AppSpacing.spaceLg.value,
                        mainAxisAlignment: .center,
                        children: <Widget>[
                          // Step Indicator
                          ResetPasswordStepIndicator(currentStep: step),

                          // Animated Step Content
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            child: switch (step) {
                              0 => ResetPasswordEmailStep(
                                key: const ValueKey<int>(0),
                                emailController: _emailController,
                                onSendCode: _handleSendCode,
                              ),
                              1 => ResetPasswordCodeStep(
                                key: const ValueKey<int>(1),
                                codeController: _codeController,
                                email: _emailController.text.trim(),
                                onCodeValidated: _handleCodeValidated,
                                onResendCode: _handleResendCode,
                                onChangeEmail: _handleChangeEmail,
                              ),
                              _ => ResetPasswordNewPasswordStep(
                                key: const ValueKey<int>(2),
                                newPasswordController: _newPasswordController,
                                confirmPasswordController: _confirmPasswordController,
                                onSubmit: _handleChangePassword,
                                onBackToCode: _handleBackToCode,
                              ),
                            },
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
    );
  }
}
