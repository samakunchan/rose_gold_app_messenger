import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/inviter_entity.dart';

part 'inviter_model.freezed.dart';
part 'inviter_model.g.dart';

@freezed
abstract class InviterModel with _$InviterModel {
  factory({
    required String username,
    @JsonKey(name: 'user_tag') required String userTag,
    String? id,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _InviterModel;

  factory fromJson(Map<String, dynamic> json) => _$InviterModelFromJson(json);
}

extension InviterModelX on InviterModel {
  InviterEntity toEntity() => InviterEntity(
    id: id,
    username: username,
    userTag: userTag,
    avatarUrl: avatarUrl,
  );
}
