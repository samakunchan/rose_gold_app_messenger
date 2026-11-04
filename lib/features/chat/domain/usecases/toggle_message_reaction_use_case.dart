import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/repositories/chat_repository.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/usecases/params.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';

class ToggleMessageReactionUseCase {
  const new(this.repository);

  final ChatRepository repository;

  Future<Either<Failure, void>> call(ToggleMessageReactionParams params) {
    return repository.toggleReaction(params: params);
  }
}
