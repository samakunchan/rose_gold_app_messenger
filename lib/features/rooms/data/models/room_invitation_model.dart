import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/models/inviter_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/data/models/room_model.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_invitation_entity.dart';

part 'room_invitation_model.freezed.dart';
part 'room_invitation_model.g.dart';

@freezed
abstract class RoomInvitationModel with _$RoomInvitationModel {
  factory({
    required String id,
    @JsonKey(name: 'room_id') required String roomId,
    @JsonKey(name: 'inviter_id') required String inviterId,
    @JsonKey(name: 'invited_user_id') required String invitedUserId,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    required String status, // pending, accepted, declined
    InviterModel? inviter,
    @JsonKey(name: 'rooms') RoomModel? room,
  }) = _RoomInvitationModel;

  factory fromJson(Map<String, dynamic> json) => _$RoomInvitationModelFromJson(json);
}

extension RoomInvitationModelX on RoomInvitationModel {
  RoomInvitationEntity toEntity() => RoomInvitationEntity(
    id: id,
    roomId: roomId,
    inviterId: inviterId,
    invitedUserId: invitedUserId,
    createdAt: createdAt,
    updatedAt: updatedAt,
    status: status,
    inviter: inviter?.toEntity(),
    room: room?.toEntity(),
  );
}
