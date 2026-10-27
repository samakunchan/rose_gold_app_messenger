import 'package:feedback/feedback.dart';
import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/extensions/context_extension.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/feedback/widgets/custom_feedback_form.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/screens/rooms_screen.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/languages_signals.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/theme_mode_signals.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/screens/authentication_screen.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/screens/change_password_screen.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/l10n/app/app_localizations.dart';
import 'package:rose_gold_app_messenger/themes/themes_all_export.dart';
import 'package:signals_flutter/signals_flutter.dart';

class MainApp extends SignalWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    final ThemeModeSignals changeThemeModeSignals = kGetIt<ThemeModeSignals>();
    final LanguagesSignals languagesSignals = kGetIt<LanguagesSignals>();
    final ThemeMode themeMode = changeThemeModeSignals.themeMode.value;

    return BetterFeedback(
      localeOverride: Locale(languagesSignals.code.value),
      localizationsDelegates: <LocalizationsDelegate<dynamic>>[
        GlobalFeedbackLocalizationsDelegate(),
        DefaultMaterialLocalizations.delegate,
        ...GlobalMaterialLocalizations.delegates,
      ],
      theme: FeedbackThemeData(
        activeFeedbackModeColor: kLightPrimaryColor,
      ),
      feedbackBuilder: (BuildContext context, OnSubmit onSubmit, ScrollController? scrollController) => CustomFeedbackForm(
        onSubmit: onSubmit,
        scrollController: scrollController,
      ),
      child: MaterialApp(
        navigatorKey: rootNavigatorKey,
        onGenerateTitle: (BuildContext context) => context.localizations.appTitle,
        localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
          AppLocalizations.delegate,
          ...GlobalMaterialLocalizations.delegates,
        ],
        locale: Locale(languagesSignals.code.value),
        supportedLocales: AppLocalizations.supportedLocales,
        debugShowCheckedModeBanner: false,
        theme: MaterialTheme.light,
        darkTheme: MaterialTheme.dark,
        themeMode: themeMode,
        home: authSignals.showPasswordScreen.value
            ? const ChangePasswordScreen()
            : (authSignals.currentAuthSession.value == null ? const AuthenticationScreen() : const RoomsScreen()),
      ),
    );
  }
}
