import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/controllers/auth_animated_controller.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/widgets/widgets_export.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:rose_gold_app_messenger/themes/widgets/widgets_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AuthenticationScreen extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    final ThemeData theme = Theme.of(context);
    final FrontThemeExtension frontTheme = theme.extension<FrontThemeExtension>() ?? .light;

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

            /// Transparency
            const TransparencyLayer(),

            /// Main content
            SafeArea(
              child: SingleChildScrollView(
                padding: .symmetric(
                  horizontal: AppSpacing.spaceLg.value,
                  vertical: AppSpacing.spaceBase.value,
                ),
                child: Column(
                  spacing: AppSpacing.spaceLg.value,
                  children: <Widget>[
                    // Top Bar with Optional Navigation Back
                    const AuthTopHeader(),

                    // Header: Welcome and Tabs
                    Column(
                      spacing: AppSpacing.spaceLg.value,
                      children: <Widget>[
                        SignalBuilder(
                          builder: (_) => AuthMainTitle(
                            title: authSignals.isLoginTab.value ? 'Bienvenue sur RoseGold' : 'Rejoindre RoseGold',
                            tagline: authSignals.isLoginTab.value
                                ? 'Connectez-vous à vos cercles privilégiés'
                                : 'Créez votre accès exclusif et confidentiel',
                          ),
                        ),

                        /// Login / Sign Up Tabs
                        SignalBuilder(
                          builder: (_) => Row(
                            // TODO(samakunchan): Test avec le widget Tab
                            mainAxisAlignment: .center,
                            spacing: AppSpacing.space2xl.value,
                            children: <Widget>[
                              AuthTabButton(
                                key: const ValueKey<String>('login_tab'),
                                title: 'Connexion',
                                setState: () => authSignals.isLoginTab.value = true,
                                isLoginTab: authSignals.isLoginTab.value,
                              ),
                              AuthTabButton(
                                key: const ValueKey<String>('register_tab'),
                                title: 'Créer un compte',
                                setState: () => authSignals.isLoginTab.value = false,
                                isLoginTab: !authSignals.isLoginTab.value,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),

                    /// Main Frosted Card
                    SignalBuilder(
                      builder: (_) => FrontCardContainer(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          layoutBuilder: AuthAnimatedController.layoutBuilder,
                          transitionBuilder: AuthAnimatedController.transitionBuilder,
                          child: authSignals.isLoginTab.value
                              ? AuthLoginForm(key: const ValueKey<String>('sign_in_form'), onAuthenticate: authSignals.signIn)
                              : AuthRegisterForm(key: const ValueKey<String>('sign_up_form'), onCreateAccount: authSignals.registerWithSupabase),
                        ),
                      ),
                    ),

                    /// Security Footer
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
