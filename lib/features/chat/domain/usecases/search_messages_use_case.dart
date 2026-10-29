import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/message_entity.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/repositories/chat_repository.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/params.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';

class SearchMessagesUseCase {
  new(this.repository);

  final ChatRepository repository;

  Future<Either<Failure, List<MessageEntity>>> call(SearchMessagesParams params) async {
    return await repository.searchMessages(params: params);
  }
}
