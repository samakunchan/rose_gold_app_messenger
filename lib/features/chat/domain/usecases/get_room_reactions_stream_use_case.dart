import 'package:rose_gold_app_messenger/features/chat/domain/repositories/chat_repository.dart';

class GetRoomReactionsStreamUseCase {
  const new(this.repository);

  final ChatRepository repository;

  Stream<List<Map<String, dynamic>>> call({required String roomId}) {
    return repository.getRoomReactionsStream(roomId: roomId);
  }
}
