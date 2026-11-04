import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/repositories/chat_repository.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';

class RotateRoomKeyForNewMemberUseCase {
  const new({required this.chatRepository});

  final ChatRepository chatRepository;

  Future<Either<Failure, void>> call({required String roomId, required String newMemberId}) {
    return chatRepository.rotateRoomKeyForNewMember(roomId: roomId, newMemberId: newMemberId);
  }
}
