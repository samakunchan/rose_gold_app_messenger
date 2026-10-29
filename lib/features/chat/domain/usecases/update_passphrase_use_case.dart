import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/repositories/chat_repository.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';

class UpdatePassphraseUseCase {
  new(this.repository);

  final ChatRepository repository;

  Future<Either<Failure, void>> call(String newPassphrase) async {
    return await repository.updatePassphrase(newPassphrase: newPassphrase);
  }
}
