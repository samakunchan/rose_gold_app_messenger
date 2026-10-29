// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_public_key_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserPublicKeyModel {

@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'public_key') String get publicKey;@JsonKey(name: 'key_fingerprint') String get keyFingerprint;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt;
/// Create a copy of UserPublicKeyModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserPublicKeyModelCopyWith<UserPublicKeyModel> get copyWith => _$UserPublicKeyModelCopyWithImpl<UserPublicKeyModel>(this as UserPublicKeyModel, _$identity);

  /// Serializes this UserPublicKeyModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserPublicKeyModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserPublicKeyModel&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.publicKey, _this.publicKey) || other.publicKey == _this.publicKey)&&(identical(other.keyFingerprint, _this.keyFingerprint) || other.keyFingerprint == _this.keyFingerprint)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserPublicKeyModel;
  return Object.hash(runtimeType,_this.userId,_this.publicKey,_this.keyFingerprint,_this.createdAt,_this.updatedAt);
}

@override
String toString() {
  final _this = this as UserPublicKeyModel;
  return 'UserPublicKeyModel(userId: ${_this.userId}, publicKey: ${_this.publicKey}, keyFingerprint: ${_this.keyFingerprint}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt})';
}


}

/// @nodoc
abstract mixin class $UserPublicKeyModelCopyWith<$Res>  {
  factory $UserPublicKeyModelCopyWith(UserPublicKeyModel value, $Res Function(UserPublicKeyModel) _then) = _$UserPublicKeyModelCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'public_key') String publicKey,@JsonKey(name: 'key_fingerprint') String keyFingerprint,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class _$UserPublicKeyModelCopyWithImpl<$Res>
    implements $UserPublicKeyModelCopyWith<$Res> {
  _$UserPublicKeyModelCopyWithImpl(this._self, this._then);

  final UserPublicKeyModel _self;
  final $Res Function(UserPublicKeyModel) _then;

/// Create a copy of UserPublicKeyModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? publicKey = null,Object? keyFingerprint = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(UserPublicKeyModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,publicKey: null == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as String,keyFingerprint: null == keyFingerprint ? _self.keyFingerprint : keyFingerprint // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UserPublicKeyModel].
extension UserPublicKeyModelPatterns on UserPublicKeyModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserPublicKeyModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserPublicKeyModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserPublicKeyModel value)  $default,){
final _that = this;
switch (_that) {
case _UserPublicKeyModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserPublicKeyModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserPublicKeyModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'public_key')  String publicKey, @JsonKey(name: 'key_fingerprint')  String keyFingerprint, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserPublicKeyModel() when $default != null:
return $default(_that.userId,_that.publicKey,_that.keyFingerprint,_that.createdAt,_that.updatedAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'public_key')  String publicKey, @JsonKey(name: 'key_fingerprint')  String keyFingerprint, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _UserPublicKeyModel():
return $default(_that.userId,_that.publicKey,_that.keyFingerprint,_that.createdAt,_that.updatedAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'public_key')  String publicKey, @JsonKey(name: 'key_fingerprint')  String keyFingerprint, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _UserPublicKeyModel() when $default != null:
return $default(_that.userId,_that.publicKey,_that.keyFingerprint,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserPublicKeyModel implements UserPublicKeyModel {
   _UserPublicKeyModel({@JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'public_key') required this.publicKey, @JsonKey(name: 'key_fingerprint') required this.keyFingerprint, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt});
  factory _UserPublicKeyModel.fromJson(Map<String, dynamic> json) => _$UserPublicKeyModelFromJson(json);

@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'public_key') final  String publicKey;
@override@JsonKey(name: 'key_fingerprint') final  String keyFingerprint;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;

/// Create a copy of UserPublicKeyModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserPublicKeyModelCopyWith<_UserPublicKeyModel> get copyWith => __$UserPublicKeyModelCopyWithImpl<_UserPublicKeyModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserPublicKeyModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserPublicKeyModel&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.publicKey, publicKey) || other.publicKey == publicKey)&&(identical(other.keyFingerprint, keyFingerprint) || other.keyFingerprint == keyFingerprint)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,userId,publicKey,keyFingerprint,createdAt,updatedAt);
}

@override
String toString() {
    return 'UserPublicKeyModel(userId: $userId, publicKey: $publicKey, keyFingerprint: $keyFingerprint, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$UserPublicKeyModelCopyWith<$Res> implements $UserPublicKeyModelCopyWith<$Res> {
  factory _$UserPublicKeyModelCopyWith(_UserPublicKeyModel value, $Res Function(_UserPublicKeyModel) _then) = __$UserPublicKeyModelCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'public_key') String publicKey,@JsonKey(name: 'key_fingerprint') String keyFingerprint,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt
});




}
/// @nodoc
class __$UserPublicKeyModelCopyWithImpl<$Res>
    implements _$UserPublicKeyModelCopyWith<$Res> {
  __$UserPublicKeyModelCopyWithImpl(this._self, this._then);

  final _UserPublicKeyModel _self;
  final $Res Function(_UserPublicKeyModel) _then;

/// Create a copy of UserPublicKeyModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? publicKey = null,Object? keyFingerprint = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_UserPublicKeyModel(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,publicKey: null == publicKey ? _self.publicKey : publicKey // ignore: cast_nullable_to_non_nullable
as String,keyFingerprint: null == keyFingerprint ? _self.keyFingerprint : keyFingerprint // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
