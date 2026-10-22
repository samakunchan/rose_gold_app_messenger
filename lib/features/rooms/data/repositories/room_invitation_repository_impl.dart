import 'package:dart_either/dart_either.dart';
import 'package:rose_gold_app_messenger/features/core/errors/failures.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/datasources/room_invitation_data_source.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/models/room_invitation_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/models/user_profile_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_invitation_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/user_profile_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/repositories/room_invitation_repository.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/usecases/params.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RoomInvitationRepositoryImpl extends RoomInvitationRepository {
  new({required this.dataSource});

  final RoomInvitationDataSource dataSource;

  @override
  Future<Either<Failure, bool>> acceptInvitation({required InvitationParams params}) async {
    try {
      await dataSource.acceptInvitation(invitationId: params.invitationId);
      return const Right<Failure, bool>(true);
    } on Exception {
      return const Left<Failure, bool>(RoomsInvitationFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> declineInvitation({required InvitationParams params}) async {
    try {
      await dataSource.declineInvitation(invitationId: params.invitationId);
      return const Right<Failure, bool>(true);
    } on Exception {
      return const Left<Failure, bool>(RoomsInvitationFailure());
    }
  }

  @override
  Future<Either<Failure, UserProfileEntity?>> searchUserByTag({required SearchUserByTagParams params}) async {
    try {
      final UserProfileModel? model = await dataSource.searchUserByTag(userTag: params.userTag);
      return Right<Failure, UserProfileEntity?>(model?.toEntity());
    } on PostgrestException catch (e) {
      return Left<Failure, UserProfileEntity?>(RoomsInvitationFailure(message: e.message));
    } on Exception catch (e) {
      return Left<Failure, UserProfileEntity?>(RoomsInvitationFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> sendInvitation({required SendInvitationParams params}) async {
    try {
      await dataSource.sendInvitation(roomId: params.roomId, invitedUserId: params.invitedUserId);
      return const Right<Failure, bool>(true);
    } on PostgrestException catch (e) {
      if (e.message.contains('patienter') || e.message.contains('déjà en cours')) {
        return const Left<Failure, bool>(DoNotSpamFailure());
      }
      return Left<Failure, bool>(RoomsInvitationFailure(message: e.message));
    } on Exception {
      return const Left<Failure, bool>(RoomsInvitationFailure());
    }
  }

  @override
  Stream<List<RoomInvitationEntity>> receivedInvitationsStream() {
    final Stream<List<RoomInvitationModel>> stream = dataSource.receivedInvitationsStream();

    return stream.map(
      (List<RoomInvitationModel> invitations) => invitations.map((RoomInvitationModel invitation) => invitation.toEntity()).toList(),
    );
  }
}
