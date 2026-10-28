import 'package:equatable/equatable.dart';
import 'package:rose_gold_app_messenger/features/core/errors/error_messages.dart';

/// All Failures:
/// ```groovy
/// - ServerFailure         = "Le serveur ne réponds plus."
/// - NotFoundFailure       = "La route est introuvable."
/// - UnAuthorizedFailure   = "Cette ressource requiert une authentification."
/// - ForbiddenFailure      = "Cette ressource requiert des droits que vous n‘avez pas."
/// - BadRequestFailure     = "Une érreur est survenue."
/// - CacheFailure          = "Le cache a un problème."
/// - AuthenticationFailure = "L‘authentication a échoué."
/// ```
abstract class Failure extends Equatable implements Exception {
  const new({this.message = ErrorMessage.noErrorMessageHandled});

  final String message;

  @override
  List<Object?> get props => <Object?>[message];
}

/// Value: "Le serveur ne réponds plus."
class ServerFailure extends Failure {
  const new({super.message = ErrorMessage.serverFailureMessage});
}

/// Value: "La route est introuvable."
class NotFoundFailure extends Failure {
  const new({super.message = ErrorMessage.notFoundMessage});
}

/// Value: "Cette ressource requiert une authentification."
class UnAuthorizedFailure extends Failure {
  const new({super.message = ErrorMessage.unAuthorizationMessage});
}

/// Value: "Cette ressource requiert des droits que vous n‘avez pas."
class ForbiddenFailure extends Failure {
  const new({super.message = ErrorMessage.forbiddenMessage});
}

/// Value: "Une érreur est survenue."
class BadRequestFailure extends Failure {
  const new({super.message = ErrorMessage.defaultMessage});
}

/// Value: "Le cache a un problème."
class CacheFailure extends Failure {
  const new({super.message = ErrorMessage.cacheFailureMessage});
}

/// Value: "L‘authentication a échoué."
class AuthenticationFailure extends Failure {
  const new({super.message = ErrorMessage.authFailureMessage});
}

/// Value: "La création de compte a échoué."
class RegistrationFailure extends Failure {
  const new({super.message = ErrorMessage.registrationFailureMessage});
}

/// Value: "Ne pas spammer cette action."
class DoNotSpamFailure extends Failure {
  const new({super.message = ErrorMessage.noSpamFailureMessage});
}

/// Value: "Un problème est survenue lors de la détection de la présence de cette utilisateur."
class UserPresenceFailure extends Failure {
  const new({super.message = ErrorMessage.userPresenceFailureMessage});
}

/// Value: "Un problème est survenue lors de la détection de la création du salon."
class RoomsFailure extends Failure {
  const new({super.message = ErrorMessage.roomCreateFailureMessage});
}

/// Value: "Un problème est survenue lors du processus d‘invitation au salon."
class RoomsInvitationFailure extends Failure {
  const new({super.message = ErrorMessage.roomInvitationFailureMessage});
}

/// Value: "Un problème est survenue lors de la gestion des paramètres."
class SettingsFailure extends Failure {
  const new({super.message = ErrorMessage.defaultSettingFailureMessage});
}

/// Value: "Un problème est survenue lors de l‘envoi ou la réception du message."
class ChatFailure extends Failure {
  const new({super.message = ErrorMessage.chatFailureMessage});
}

/// Value: "Un problème est survenue lors du chiffrement ou déchiffrement."
class CryptoFailure extends Failure {
  const new({super.message = ErrorMessage.cryptoFailureMessage});
}
