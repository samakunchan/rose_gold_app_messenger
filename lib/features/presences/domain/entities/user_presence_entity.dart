import 'package:equatable/equatable.dart';

class UserPresenceEntity extends Equatable {
  const new({required this.userId, required this.username, required this.device, required this.onlineAt});
  final String userId;
  final String username;
  final String device;
  final String onlineAt;

  @override
  List<Object?> get props => <Object?>[userId, username, device, onlineAt];
}
