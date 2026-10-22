import 'package:equatable/equatable.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/inviter_entity.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_entity.dart';

class RoomInvitationEntity extends Equatable {
  const new({
    required this.id,
    required this.roomId,
    required this.inviterId,
    required this.invitedUserId,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    this.inviter,
    this.room,
  });

  final String id;
  final String roomId;
  final String inviterId;
  final String invitedUserId;
  final String createdAt;
  final String updatedAt;
  final String status; // pending, accepted, declined
  final InviterEntity? inviter;
  final RoomEntity? room;

  @override
  List<Object?> get props => <Object?>[
    id,
    roomId,
    inviterId,
    invitedUserId,
    createdAt,
    updatedAt,
    status,
    inviter,
    room,
  ];
}
