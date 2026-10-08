import 'package:equatable/equatable.dart';

/// Model
/// ```json
/// {
///   "email": "user@example.com",
///   "password": "your_password",
/// }
/// ```
class SignInParams extends Equatable {
  const new({required this.email, required this.password, this.rememberMe = false});

  final String email;
  final String password;
  final bool rememberMe;

  @override
  List<Object?> get props => <String>[email, password];

  @override
  String toString() {
    return <String, dynamic>{email: email, password: password}.toString();
  }
}

/// Model
/// ```json
/// {
///   "email": "user@example.com",
///   "password": "your_password",
///   "username": "John",
///   "locale": "en",
///   "data": {},
/// }
/// ```
class SignUpWithEmailParams extends Equatable {
  const new({required this.email, required this.password, required this.data, this.locale = 'fr'});

  final String email;
  final String password;
  final String locale;
  final Map<String, dynamic> data;

  @override
  List<Object?> get props => <String>[email, password, locale];
}

/// Model
/// ```json
/// {
///   "phoneNumber": "+010203040506",
///   "password": "your_password",
///   "username": "John",
///   "locale": "en",
///   "data": {},
/// }
/// ```
class SignUpWithPhoneParams extends Equatable {
  const new({required this.phoneNumber, required this.password, required this.username, required this.data, this.locale = 'fr'});

  final String phoneNumber;
  final String password;
  final String username;
  final String locale;
  final Map<String, dynamic> data;

  @override
  List<Object?> get props => <String>[phoneNumber, password, username, locale];
}

/// Model
/// ```json
/// {
///   "email": "user@example.com",
///   "redirectTo": "rosegoldappmessenger://reset-password-callback", // (default)
/// }
/// ```
class ForgotPasswordParams extends Equatable {
  const new({required this.email, this.redirectTo = 'rosegoldappmessenger://reset-password-callback'});

  final String email;
  final String redirectTo;

  @override
  List<Object?> get props => <String>[email, redirectTo];
}

/// Model
/// ```json
/// {
///   "email": "user@example.com",
///   "password": "your_password"
///   "token": "code_inside_your_email",
/// }
/// ```
class ChangePasswordParams extends Equatable {
  const new({required this.email, required this.password, this.token});

  final String email;
  final String password;
  final String? token;

  @override
  List<Object?> get props => <Object?>[email, password, token];
}
