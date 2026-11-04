import 'package:equatable/equatable.dart';

class MessageReactionGroupEntity extends Equatable {
  const new({
    required this.emoji,
    required this.count,
    required this.userIds,
    required this.hasReacted,
  });

  final String emoji;
  final int count;
  final List<String> userIds;
  final bool hasReacted;

  @override
  List<Object?> get props => <Object?>[emoji, count, userIds, hasReacted];
}
