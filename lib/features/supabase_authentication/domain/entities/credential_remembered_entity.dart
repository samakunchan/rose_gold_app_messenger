import 'package:equatable/equatable.dart';

/// ```json
/// {
///   "email": "string",
///   "password": "string",
/// }
/// ```
class CredentialRememberedEntity extends Equatable {
  const new({required this.email, required this.password});
  final String email;
  final String password;

  @override
  List<Object?> get props => <String>[email, password];
}
