import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/settings/data/datasources/gdpr_data_source.dart';
import 'package:rose_gold_app_messenger/features/settings/domain/repositories/gdpr_repository.dart';

class GdprRepositoryImpl implements GdprRepository {
  new({required this.dataSource});
  final GdprDataSource dataSource;

  @override
  Future<Either<Failure, String>> exportUserDataJson() async {
    try {
      final String json = await dataSource.exportUserDataJson();

      return Right<Failure, String>(json);
    } on Exception {
      return const Left<Failure, String>(SettingsFailure());
    }
  }

  @override
  Future<Either<Failure, String>> saveExportToFile(String jsonContent) async {
    try {
      final String filePath = await dataSource.saveExportToFile(jsonContent);

      return Right<Failure, String>(filePath);
    } on Exception {
      return const Left<Failure, String>(SettingsFailure());
    }
  }

  @override
  Future<Either<Failure, int>> clearLocalCache() async {
    try {
      final int deletedRows = await dataSource.clearLocalCache();

      return Right<Failure, int>(deletedRows);
    } on Exception {
      return const Left<Failure, int>(SettingsFailure());
    }
  }
}
