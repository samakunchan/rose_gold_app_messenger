import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/message_entity.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/repositories/chat_repository.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/params.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';

class GetChatMessagesStreamUseCase {
  new(this.repository);

  final ChatRepository repository;

  Stream<Either<Failure, List<MessageEntity>>> call(GetChatMessagesStreamParams params) {
    return repository.getChatMessagesStream(params: params);
  }
}
