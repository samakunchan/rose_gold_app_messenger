// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'blocked_user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BlockedUserModel {

 String get id;@JsonKey(name: 'blocker_id') String get blockerId;@JsonKey(name: 'blocked_id') String get blockedId;@JsonKey(name: 'created_at') String get createdAt; String? get username;@JsonKey(name: 'user_tag') String? get userTag;@JsonKey(name: 'avatar_url') String? get avatarUrl;
/// Create a copy of BlockedUserModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlockedUserModelCopyWith<BlockedUserModel> get copyWith => _$BlockedUserModelCopyWithImpl<BlockedUserModel>(this as BlockedUserModel, _$identity);

  /// Serializes this BlockedUserModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as BlockedUserModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlockedUserModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.blockerId, _this.blockerId) || other.blockerId == _this.blockerId)&&(identical(other.blockedId, _this.blockedId) || other.blockedId == _this.blockedId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.userTag, _this.userTag) || other.userTag == _this.userTag)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as BlockedUserModel;
  return Object.hash(runtimeType,_this.id,_this.blockerId,_this.blockedId,_this.createdAt,_this.username,_this.userTag,_this.avatarUrl);
}

@override
String toString() {
  final _this = this as BlockedUserModel;
  return 'BlockedUserModel(id: ${_this.id}, blockerId: ${_this.blockerId}, blockedId: ${_this.blockedId}, createdAt: ${_this.createdAt}, username: ${_this.username}, userTag: ${_this.userTag}, avatarUrl: ${_this.avatarUrl})';
}


}

/// @nodoc
abstract mixin class $BlockedUserModelCopyWith<$Res>  {
  factory $BlockedUserModelCopyWith(BlockedUserModel value, $Res Function(BlockedUserModel) _then) = _$BlockedUserModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'blocker_id') String blockerId,@JsonKey(name: 'blocked_id') String blockedId,@JsonKey(name: 'created_at') String createdAt, String? username,@JsonKey(name: 'user_tag') String? userTag,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class _$BlockedUserModelCopyWithImpl<$Res>
    implements $BlockedUserModelCopyWith<$Res> {
  _$BlockedUserModelCopyWithImpl(this._self, this._then);

  final BlockedUserModel _self;
  final $Res Function(BlockedUserModel) _then;

/// Create a copy of BlockedUserModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? blockerId = null,Object? blockedId = null,Object? createdAt = null,Object? username = freezed,Object? userTag = freezed,Object? avatarUrl = freezed,}) {
  return _then(BlockedUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,blockerId: null == blockerId ? _self.blockerId : blockerId // ignore: cast_nullable_to_non_nullable
as String,blockedId: null == blockedId ? _self.blockedId : blockedId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,userTag: freezed == userTag ? _self.userTag : userTag // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [BlockedUserModel].
extension BlockedUserModelPatterns on BlockedUserModel {
@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BlockedUserModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BlockedUserModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BlockedUserModel value)  $default,){
final _that = this;
switch (_that) {
case _BlockedUserModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BlockedUserModel value)?  $default,){
final _that = this;
switch (_that) {
case _BlockedUserModel() when $default != null:
return $default(_that);case _:
  return null;

}
}

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'blocker_id')  String blockerId, @JsonKey(name: 'blocked_id')  String blockedId, @JsonKey(name: 'created_at')  String createdAt,  String? username, @JsonKey(name: 'user_tag')  String? userTag, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BlockedUserModel() when $default != null:
return $default(_that.id,_that.blockerId,_that.blockedId,_that.createdAt,_that.username,_that.userTag,_that.avatarUrl);case _:
  return orElse();

}
}

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'blocker_id')  String blockerId, @JsonKey(name: 'blocked_id')  String blockedId, @JsonKey(name: 'created_at')  String createdAt,  String? username, @JsonKey(name: 'user_tag')  String? userTag, @JsonKey(name: 'avatar_url')  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _BlockedUserModel():
return $default(_that.id,_that.blockerId,_that.blockedId,_that.createdAt,_that.username,_that.userTag,_that.avatarUrl);case _:
  throw StateError('Unexpected subclass');

}
}

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'blocker_id')  String blockerId, @JsonKey(name: 'blocked_id')  String blockedId, @JsonKey(name: 'created_at')  String createdAt,  String? username, @JsonKey(name: 'user_tag')  String? userTag, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _BlockedUserModel() when $default != null:
return $default(_that.id,_that.blockerId,_that.blockedId,_that.createdAt,_that.username,_that.userTag,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BlockedUserModel implements BlockedUserModel {
   _BlockedUserModel({required this.id, @JsonKey(name: 'blocker_id') required this.blockerId, @JsonKey(name: 'blocked_id') required this.blockedId, @JsonKey(name: 'created_at') required this.createdAt, this.username, @JsonKey(name: 'user_tag') this.userTag, @JsonKey(name: 'avatar_url') this.avatarUrl});
  factory _BlockedUserModel.fromJson(Map<String, dynamic> json) => _$BlockedUserModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'blocker_id') final  String blockerId;
@override@JsonKey(name: 'blocked_id') final  String blockedId;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override final  String? username;
@override@JsonKey(name: 'user_tag') final  String? userTag;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;

/// Create a copy of BlockedUserModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlockedUserModelCopyWith<_BlockedUserModel> get copyWith => __$BlockedUserModelCopyWithImpl<_BlockedUserModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlockedUserModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlockedUserModel&&(identical(other.id, id) || other.id == id)&&(identical(other.blockerId, blockerId) || other.blockerId == blockerId)&&(identical(other.blockedId, blockedId) || other.blockedId == blockedId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.username, username) || other.username == username)&&(identical(other.userTag, userTag) || other.userTag == userTag)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,blockerId,blockedId,createdAt,username,userTag,avatarUrl);
}

@override
String toString() {
    return 'BlockedUserModel(id: $id, blockerId: $blockerId, blockedId: $blockedId, createdAt: $createdAt, username: $username, userTag: $userTag, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$BlockedUserModelCopyWith<$Res> implements $BlockedUserModelCopyWith<$Res> {
  factory _$BlockedUserModelCopyWith(_BlockedUserModel value, $Res Function(_BlockedUserModel) _then) = __$BlockedUserModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'blocker_id') String blockerId,@JsonKey(name: 'blocked_id') String blockedId,@JsonKey(name: 'created_at') String createdAt, String? username,@JsonKey(name: 'user_tag') String? userTag,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class __$BlockedUserModelCopyWithImpl<$Res>
    implements _$BlockedUserModelCopyWith<$Res> {
  __$UserMetadataModelCopyWithImpl_unused() {}
  __$BlockedUserModelCopyWithImpl(this._self, this._then);

  final _BlockedUserModel _self;
  final $Res Function(_BlockedUserModel) _then;

/// Create a copy of BlockedUserModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? blockerId = null,Object? blockedId = null,Object? createdAt = null,Object? username = freezed,Object? userTag = freezed,Object? avatarUrl = freezed,}) {
  return _then(_BlockedUserModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,blockerId: null == blockerId ? _self.blockerId : blockerId // ignore: cast_nullable_to_non_nullable
as String,blockedId: null == blockedId ? _self.blockedId : blockedId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,userTag: freezed == userTag ? _self.userTag : userTag // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
