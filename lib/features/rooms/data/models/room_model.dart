import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/room_entity.dart';

part 'room_model.freezed.dart';
part 'room_model.g.dart';

@freezed
abstract class RoomModel with _$RoomModel {
  factory({
    required String id,
    required String name,
    @JsonKey(name: 'created_by') required String createdBy,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? description,
  }) = _RoomModel;

  factory fromJson(Map<String, dynamic> json) => _$RoomModelFromJson(json);
}

extension RoomModelModelX on RoomModel {
  RoomEntity toEntity() => RoomEntity(
    id: id,
    name: name,
    createdBy: createdBy,
    createdAt: createdAt,
    updatedAt: updatedAt,
    avatarUrl: avatarUrl,
    description: description,
  );
}
