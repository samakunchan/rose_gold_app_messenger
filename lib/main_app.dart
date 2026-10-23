import 'package:material_ui/material_ui.dart';
import 'package:rose_gold_app_messenger/extensions/context_extension.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/rooms/presentation/screens/rooms_screen.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/languages_signals.dart';
import 'package:rose_gold_app_messenger/features/settings/presentation/signals/theme_mode_signals.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/screens/authentication_screen.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/screens/change_password_screen.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/l10n/app/app_localizations.dart';
import 'package:rose_gold_app_messenger/themes/material/material_theme.dart';
import 'package:signals_flutter/signals_flutter.dart';

class MainApp extends SignalWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthSignals authSignals = kGetIt<AuthSignals>();
    final ThemeModeSignals changeThemeModeSignals = kGetIt<ThemeModeSignals>();
    final LanguagesSignals languagesSignals = kGetIt<LanguagesSignals>();

    return MaterialApp(
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
      themeMode: changeThemeModeSignals.themeMode.value,
      home: authSignals.showPasswordScreen.value
          ? const ChangePasswordScreen()
          : (authSignals.currentAuthSession.value == null ? const AuthenticationScreen() : const RoomsScreen()),
    );
  }
}
