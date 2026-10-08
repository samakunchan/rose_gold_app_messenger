import 'package:flutter/material.dart';
import 'package:rose_gold_app_messenger/extensions/context_extension.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/screens/authentication_screen.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/screens/change_password_screen.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/home_test.dart';
import 'package:rose_gold_app_messenger/l10n/app/app_localizations.dart';
import 'package:rose_gold_app_messenger/themes/material/material_theme.dart';
import 'package:signals_flutter/signals_flutter.dart';

class MainApp extends SignalWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthSignals authSignals = kGetIt<AuthSignals>();

    return MaterialApp(
      navigatorKey: rootNavigatorKey,
      onGenerateTitle: (BuildContext context) => context.localizations.appTitle,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      debugShowCheckedModeBanner: false,
      theme: MaterialTheme.light,
      darkTheme: MaterialTheme.dark,
      home: authSignals.showPasswordScreen.value
          ? const ChangePasswordScreen()
          : (authSignals.currentAuthSession.value == null ? const AuthenticationScreen() : const HomeTest()),
    );
  }
}
