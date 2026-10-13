import 'package:equatable/equatable.dart';

class PresenceParams extends Equatable {
  const new({required this.userId, required this.username, required this.device});

  final String userId;
  final String username;
  final String device;

  @override
  List<Object?> get props => <Object?>[userId, username, device];
}
