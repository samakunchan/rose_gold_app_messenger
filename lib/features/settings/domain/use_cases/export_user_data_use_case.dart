import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/gdpr_repository.dart';

class ExportUserDataUseCase {
  new(this.repository);
  final GdprRepository repository;

  Future<Either<Failure, String>> call() {
    return repository.exportUserDataJson();
  }
}
