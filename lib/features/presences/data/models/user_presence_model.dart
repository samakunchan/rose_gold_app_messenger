import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rose_gold_app_messenger/features/presences/domain/entities/user_presence_entity.dart';

part 'user_presence_model.freezed.dart';
part 'user_presence_model.g.dart';

@freezed
abstract class UserPresenceModel with _$UserPresenceModel {
  factory({
    @JsonKey(name: 'user_id') required String userId,
    required String username,
    required String device,
    @JsonKey(name: 'online_at') required String onlineAt,
  }) = _UserPresenceModel;

  factory fromJson(Map<String, dynamic> json) => _$UserPresenceModelFromJson(json);
}

extension UserPresenceModelX on UserPresenceModel {
  UserPresenceEntity toEntity() => UserPresenceEntity(
    userId: userId,
    username: username,
    device: device,
    onlineAt: onlineAt,
  );
}
