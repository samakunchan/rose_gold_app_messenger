import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';

abstract class GdprRepository {
  Future<Either<Failure, String>> exportUserDataJson();
  Future<Either<Failure, String>> saveExportToFile(String jsonContent);
  Future<Either<Failure, int>> clearLocalCache();
}
