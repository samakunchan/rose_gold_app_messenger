import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rose_gold_app_messenger/features/profile/domain/entities/profile_entity.dart';

part 'profile_model.freezed.dart';
part 'profile_model.g.dart';

@freezed
abstract class ProfileModel with _$ProfileModel {
  factory({
    required String id,
    required String username,
    @JsonKey(name: 'user_tag') required String userTag,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    String? phone,
    @JsonKey(name: 'public_key') String? publicKey,
    @JsonKey(name: 'created_at') String? createdAt,
    @JsonKey(name: 'updated_at') String? updatedAt,
  }) = _ProfileModel;

  factory fromJson(Map<String, dynamic> json) => _$ProfileModelFromJson(json);
}

extension ProfileModelX on ProfileModel {
  ProfileEntity toEntity() => ProfileEntity(
    id: id,
    username: username,
    userTag: userTag,
    avatarUrl: avatarUrl,
    phone: phone,
    publicKey: publicKey,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
