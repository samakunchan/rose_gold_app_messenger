import 'package:dart_either/dart_either.dart';
import 'package:flutter/foundation.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/auth_session_entity.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/credential_remembered_entity.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/usecases/get_remembered_credentials.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/usecases/use_cases_export.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/view_models/auth_session_view_model.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/presentation/view_models/credentials_saved_view_model.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AuthSignals {
  new({
    required this.signInUseCase,
    required this.signOutUseCase,
    required this.getSessionUseCase,
    required this.registerUseCase,
    required this.deleteAccountUseCase,
    required this.forgotPasswordRequestUseCase,
    required this.changePasswordUseCase,
    required this.getRememberedCredentials,
  });

  final SignInUseCase signInUseCase;
  final SignOutUseCase signOutUseCase;
  final GetSessionUseCase getSessionUseCase;
  final SignUpWithEmailUseCase registerUseCase;
  final DeleteAccountUseCase deleteAccountUseCase;
  final ForgotPasswordRequestUseCase forgotPasswordRequestUseCase;
  final ChangePasswordUseCase changePasswordUseCase;
  final GetRememberedCredentials getRememberedCredentials;

  /// Reactive State Signals
  final Signal<AuthSessionViewModel?> currentAuthSession = signal<AuthSessionViewModel?>(null);
  final Signal<CredentialsSavedViewModel?> credentialsSaved = signal<CredentialsSavedViewModel?>(null);
  final Signal<bool> isLoading = signal<bool>(false);
  final Signal<String?> authError = signal<String?>(null);
  final Signal<bool> isRecoverPassword = signal<bool>(false);

  FlutterSignal<bool> showPasswordScreen = signal(false);
  FlutterSignal<bool> isLoginTab = signal(true);
  FlutterSignal<String?> userConnectedName = signal(null);
  FlutterSignal<String?> accountCreatedAt = signal(null);

  /// Concerne la gestion du remember me.
  Future<void> checkSavedCredentials() async {
    final Either<Failure, CredentialRememberedEntity?> result = await getRememberedCredentials();

    result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print('ifLeft: $failure');
        }
        credentialsSaved.value = null;
      },
      ifRight: (CredentialRememberedEntity? session) {
        if (session != null) {
          credentialsSaved.value = CredentialsSavedViewModel(session);
        } else {
          credentialsSaved.value = null;
        }
      },
    );
  }

  Future<void> signIn({required String email, required String password, bool rememberMe = false}) async {
    isLoading.value = true;
    authError.value = null;

    final Either<Failure, AuthSessionEntity> result = await signInUseCase(
      SignInParams(email: email, password: password, rememberMe: rememberMe),
    );

    result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print('ifLeft: $failure');
        }
        authError.value = failure.message;
        currentAuthSession.value = null;
        accountCreatedAt.value = null;
        userConnectedName.value = null;
        if (failure is AuthenticationFailure) {
          authError.value = failure.message;
        }
      },
      ifRight: (AuthSessionEntity session) {
        if (kDebugMode) {
          print('ifRight: $session');
        }
        currentAuthSession.value = AuthSessionViewModel(session);
        authError.value = null;
        accountCreatedAt.value = AuthSessionViewModel(session).accountCreatedAt;
        userConnectedName.value = AuthSessionViewModel(session).username;
      },
    );

    isLoading.value = false;
  }

  Future<void> signOut() async {
    isLoading.value = true;
    authError.value = null;

    final Either<Failure, void> result = await signOutUseCase();

    await result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print('ifLeft: $failure');
        }
        currentAuthSession.value = null;
        authError.value = failure.message;
        accountCreatedAt.value = null;
        userConnectedName.value = null;
      },
      ifRight: (void value) async {
        if (kDebugMode) {
          print('ifRight: Logout complete');
        }
        currentAuthSession.value = null;
        authError.value = null;
        accountCreatedAt.value = null;
        userConnectedName.value = null;
        await checkSavedCredentials();
      },
    );
    isLoading.value = false;
  }

  Future<void> checkSession() async {
    isLoading.value = true;
    authError.value = null;

    final Either<Failure, AuthSessionEntity> result = await getSessionUseCase();

    result.fold(
      ifLeft: (Failure failure) {
        currentAuthSession.value = null;
        accountCreatedAt.value = null;
        userConnectedName.value = null;
        if (failure is ServerFailure) {
          authError.value = failure.message;
        }
      },
      ifRight: (AuthSessionEntity session) {
        currentAuthSession.value = AuthSessionViewModel(session);
        authError.value = null;
        accountCreatedAt.value = AuthSessionViewModel(session).accountCreatedAt;
        userConnectedName.value = AuthSessionViewModel(session).username;
      },
    );

    isLoading.value = false;
  }

  Future<void> registerWithSupabase({
    required String email,
    required String password,
    required String username,
    String? invitationCode,
    bool acceptCharter = false,
  }) async {
    final String deviceLocale = PlatformDispatcher.instance.locale.languageCode;

    final Map<String, dynamic> data = <String, dynamic>{
      'target_app': 'app_messenger',
      'locale': deviceLocale,
      'username': username,
      'acceptCharter': acceptCharter,
    };
    if (invitationCode != null && invitationCode.isNotEmpty) {
      data.addAll(<String, dynamic>{'invitationCode': invitationCode});
    }

    final Either<Failure, AuthSessionEntity> result = await registerUseCase(
      SignUpWithEmailParams(email: email, password: password, data: data),
    );

    result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print('ifLeft: $failure');
        }
        if (failure is RegistrationFailure) {
          authError.value = failure.message;
        }
      },
      ifRight: (AuthSessionEntity value) {
        if (kDebugMode) {
          print('ifRight: $value');
        }
        authError.value = null;
      },
    );
  }

  Future<void> forgotPassword({required String email}) async {
    isLoading.value = true;
    authError.value = null;

    final Either<Failure, void> result = await forgotPasswordRequestUseCase(ForgotPasswordParams(email: email));

    result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print('ifLeft: $failure');
        }
        currentAuthSession.value = null;
        authError.value = failure.message;
        isRecoverPassword.value = false;
      },
      ifRight: (void value) {
        if (kDebugMode) {
          print('ifRight: Reseting password...');
        }
        authError.value = null;
        isRecoverPassword.value = true;
      },
    );
    isLoading.value = false;
  }

  // Si code est null, ça veut dire qu'on vient du Deep Link !
  Future<void> changePassword({required String email, required String password, String? code}) async {
    isLoading.value = true;
    authError.value = null;

    final Either<Failure, AuthSessionEntity> result = await changePasswordUseCase(
      ChangePasswordParams(email: email, password: password, token: code),
    );

    result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print('ifLeft: $failure');
        }
        currentAuthSession.value = null;
        authError.value = failure.message;
      },
      ifRight: (AuthSessionEntity value) {
        if (kDebugMode) {
          print('ifRight: Mot de passe mis à jour avec succès !');
        }
        authError.value = null;
        showPasswordScreen.value = false; // 👈 On masque le bouton une fois terminé
        isRecoverPassword.value = false;
      },
    );
    isLoading.value = false;
  }

  Future<void> deleteAppMessengerAccount() async {
    final Either<Failure, bool> result = await deleteAccountUseCase();

    result.fold(
      ifLeft: (Failure failure) {
        if (kDebugMode) {
          print('ifLeft: $failure');
        }
        currentAuthSession.value = null;
        if (failure is ServerFailure) {
          authError.value = failure.message;
        }
      },
      ifRight: (bool value) {
        if (kDebugMode) {
          print('ifRight: $value');
        }
        currentAuthSession.value = null;
        authError.value = null;
        accountCreatedAt.value = null;
        userConnectedName.value = null;
      },
    );
  }
}
