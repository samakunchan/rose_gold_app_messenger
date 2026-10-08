import 'package:equatable/equatable.dart';

/// Example:
/// ```json
/// {
///   "id": "string",
///   "email": "string",
///   "phoneNumber": "string",
///   "lastSignInAt": "string",
///   "username": "string",
///   "role": "string",
///   "invitedAt": "string",
///   "emailConfirmedAt": "string",
///   "createdAt": "string",
///   "userMetadataEntity":{ // Ici les données sont variables, cela depends de ce que l'on POST avec "data".
///     "email": "string",
///     "emailVerified": "bool",
///     "phoneVerified": "bool",
///     "sub": "string",
///     "targetApp": "string",
///     "username": "string",
///   },
/// }
/// ```
class AuthSessionEntity extends Equatable {
  const new({
    required this.id,
    required this.createdAt,
    required this.userMetadataEntity,
    this.email,
    this.phoneNumber,
    this.lastSignInAt,
    this.username,
    this.role,
    this.invitedAt,
    this.emailConfirmedAt,
  });

  final String id;
  final UserMetadataEntity userMetadataEntity;
  final String createdAt;
  final String? email;
  final String? phoneNumber;
  final String? username;
  final String? lastSignInAt;
  final String? role;
  final String? invitedAt;
  final String? emailConfirmedAt;

  @override
  List<Object?> get props => <Object?>[id, email, phoneNumber, username, createdAt, lastSignInAt];
}

class UserMetadataEntity extends Equatable {
  const new({
    required this.email,
    required this.emailVerified,
    required this.phoneVerified,
    required this.sub,
    required this.targetApp,
    this.username,
  });

  final String email;
  final bool emailVerified;
  final bool phoneVerified;
  final String sub;
  final String targetApp;
  final String? username;

  @override
  List<Object?> get props => <Object?>[sub, email, emailVerified, username, phoneVerified];
}
