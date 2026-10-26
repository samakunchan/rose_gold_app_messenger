import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rose_gold_app_messenger/features/moderation/domain/entities/blocked_user_entity.dart';

part 'blocked_user_model.freezed.dart';
part 'blocked_user_model.g.dart';

@freezed
abstract class BlockedUserModel with _$BlockedUserModel {
  factory({
    required String id,
    @JsonKey(name: 'blocker_id') required String blockerId,
    @JsonKey(name: 'blocked_id') required String blockedId,
    @JsonKey(name: 'created_at') required String createdAt,
    String? username,
    @JsonKey(name: 'user_tag') String? userTag,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _BlockedUserModel;

  factory fromJson(Map<String, dynamic> json) => _$BlockedUserModelFromJson(json);
}

extension BlockedUserModelX on BlockedUserModel {
  BlockedUserEntity toEntity() => BlockedUserEntity(
    id: id,
    blockerId: blockerId,
    blockedId: blockedId,
    createdAt: createdAt,
    username: username,
    userTag: userTag,
    avatarUrl: avatarUrl,
  );
}
