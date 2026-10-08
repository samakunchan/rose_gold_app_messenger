import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rose_gold_app_messenger/features/supabase_authentication/domain/entities/auth_session_entity.dart';

part 'user_metadata_model.freezed.dart';
part 'user_metadata_model.g.dart';

@freezed
abstract class UserMetadataModel with _$UserMetadataModel {
  factory({
    required String email,
    required String sub,
    @JsonKey(name: 'target_app') required String targetApp,
    @JsonKey(name: 'email_verified') required bool emailVerified,
    @JsonKey(name: 'phone_verified') required bool phoneVerified,
    String? username,
  }) = _UserMetadataModel;

  factory fromJson(Map<String, dynamic> json) => _$UserMetadataModelFromJson(json);
}

extension UserMetadataModelX on UserMetadataModel {
  UserMetadataEntity toEntity() => UserMetadataEntity(
    email: email,
    sub: sub,
    targetApp: targetApp,
    username: username,
    emailVerified: emailVerified,
    phoneVerified: phoneVerified,
  );
}
