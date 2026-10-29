import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rose_gold_app_messenger/features/chat/domain/entities/user_public_key_entity.dart';

part 'user_public_key_model.freezed.dart';
part 'user_public_key_model.g.dart';

@freezed
abstract class UserPublicKeyModel with _$UserPublicKeyModel {
  factory({
    @JsonKey(name: 'user_id') required String userId,
    @JsonKey(name: 'public_key') required String publicKey,
    @JsonKey(name: 'key_fingerprint') required String keyFingerprint,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
  }) = _UserPublicKeyModel;

  factory fromJson(Map<String, dynamic> json) => _$UserPublicKeyModelFromJson(json);
}

extension UserPublicKeyModelX on UserPublicKeyModel {
  UserPublicKeyEntity toEntity() => UserPublicKeyEntity(
    userId: userId,
    publicKey: publicKey,
    keyFingerprint: keyFingerprint,
    createdAt: createdAt,
    updatedAt: updatedAt,
  );
}
