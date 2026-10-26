import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/repositories/moderation_repository.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/usecases/params.dart';

class ReportInvitationUseCase {
  new(this.repository);

  final ModerationRepository repository;

  Future<Either<Failure, bool>> call(ReportInvitationParams params) async {
    return await repository.reportInvitation(params: params);
  }
}
