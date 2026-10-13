import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/entities/user_presence_entity.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/usecases/params.dart';

abstract class UserPresenceRepository {
  Future<Either<Failure, bool>> joinGlobalChannel();
  Stream<List<UserPresenceEntity>> presenceStream();
  Future<Either<Failure, bool>> trackPresence({required PresenceParams params});
  Future<void> untrackPresence();
  Future<Either<Failure, bool>> leaveGlobalChannel();
}
