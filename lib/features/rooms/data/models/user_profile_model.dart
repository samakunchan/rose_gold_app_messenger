import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rose_gold_app_messenger/features/rooms/domain/entities/user_profile_entity.dart';

part 'user_profile_model.freezed.dart';
part 'user_profile_model.g.dart';

@freezed
abstract class UserProfileModel with _$UserProfileModel {
  factory({
    required String id,
    required String username,
    @JsonKey(name: 'user_tag') required String userTag,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
  }) = _UserProfileModel;

  factory fromJson(Map<String, dynamic> json) => _$UserProfileModelFromJson(json);
}

extension UserProfileModelX on UserProfileModel {
  UserProfileEntity toEntity() => UserProfileEntity(
    id: id,
    username: username,
    userTag: userTag,
    avatarUrl: avatarUrl,
  );
}
