import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:rose_gold_app_messenger/features/core/di/injection_container.dart';
import 'package:rose_gold_app_messenger/features/core/security/secure_local_storage.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/signals/auth_signals.dart';
import 'package:rose_gold_app_messenger/main_app.dart';
import 'package:signals_flutter/signals_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart' as timeago;

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();

  timeago.setLocaleMessages('fr', timeago.FrMessages());
  timeago.setLocaleMessages('fr_short', timeago.FrShortMessages());

  /// Supabase initialization
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_APP_URL'] ?? '',
    publishableKey: dotenv.env['SUPABASE_PUBLISHABLE_KEY'] ?? '',
    authOptions: FlutterAuthClientOptions(localStorage: SecureLocalStorage(const FlutterSecureStorage(), supabasePersistSessionKey)),
  );

  /// D.I
  await initDI();
  final AuthSignals authSignals = kGetIt<AuthSignals>();
  await authSignals.checkSavedCredentials();

  kGetIt<SupabaseClient>().auth.onAuthStateChange.listen((AuthState data) async {
    final AuthChangeEvent event = data.event;
    final Session? session = data.session;

    if (kDebugMode) {
      print('Event en cours : $event');
      print('Session en cours : $session');
    }
    if (event == .initialSession && session != null) {
      await authSignals.checkSession();
    }

    if (event == .passwordRecovery) {
      authSignals.showPasswordScreen.value = true;
      if (kDebugMode) {
        print('Redirection vers le changement de mot de passe');
      }
      rootNavigatorKey.currentState?.popUntil((Route<dynamic> route) => route.isFirst);
    }
  });

  /// Supprime les logs dans la console.
  SignalsObserver.instance = null;

  runApp(const MainApp());
}
