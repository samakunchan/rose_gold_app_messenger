import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/presences/data/datasources/user_presence_data_source.dart';
import 'package:rose_gold_app_messenger/features/presences/data/models/user_presence_model.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/entities/user_presence_entity.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/repositories/user_presence_repository.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/usecases/params.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserPresenceRepositoryImpl implements UserPresenceRepository {
  new({required this.dataSource});
  final UserPresenceDataSource dataSource;

  @override
  Future<Either<Failure, bool>> joinGlobalChannel() async {
    try {
      await dataSource.joinGlobalChannel();
      return const Right<Failure, bool>(true);
    } on Exception {
      return const Left<Failure, bool>(UserPresenceFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> leaveGlobalChannel() async {
    try {
      await dataSource.leaveGlobalChannel();
      return const Right<Failure, bool>(true);
    } on Exception {
      return const Left<Failure, bool>(UserPresenceFailure());
    }
  }

  @override
  Stream<List<UserPresenceEntity>> presenceStream() {
    final Stream<List<UserPresenceModel>> stream = dataSource.presenceStream();

    return stream.map(
      (List<UserPresenceModel> usersPresences) => usersPresences.map((UserPresenceModel userPresence) => userPresence.toEntity()).toList(),
    );
  }

  @override
  Future<Either<Failure, bool>> trackPresence({required PresenceParams params}) async {
    try {
      final ChannelResponse reponse = await dataSource.trackPresence(userId: params.userId, username: params.username, device: params.device);
      if (reponse == .error) {
        return const Left<Failure, bool>(UserPresenceFailure());
      }
      if (reponse == .timedOut) {
        return const Left<Failure, bool>(UserPresenceFailure(message: 'Track presences. Connection time out'));
      }
      return const Right<Failure, bool>(true);
    } on Exception {
      return const Left<Failure, bool>(UserPresenceFailure());
    }
  }

  @override
  Future<void> untrackPresence() async {
    await dataSource.untrackPresence();
  }
}
