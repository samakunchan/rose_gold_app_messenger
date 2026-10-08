// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_metadata_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserMetadataModel {

 String get email; String get sub;@JsonKey(name: 'target_app') String get targetApp;@JsonKey(name: 'email_verified') bool get emailVerified;@JsonKey(name: 'phone_verified') bool get phoneVerified; String? get username;
/// Create a copy of UserMetadataModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserMetadataModelCopyWith<UserMetadataModel> get copyWith => _$UserMetadataModelCopyWithImpl<UserMetadataModel>(this as UserMetadataModel, _$identity);

  /// Serializes this UserMetadataModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as UserMetadataModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserMetadataModel&&(identical(other.email, _this.email) || other.email == _this.email)&&(identical(other.sub, _this.sub) || other.sub == _this.sub)&&(identical(other.targetApp, _this.targetApp) || other.targetApp == _this.targetApp)&&(identical(other.emailVerified, _this.emailVerified) || other.emailVerified == _this.emailVerified)&&(identical(other.phoneVerified, _this.phoneVerified) || other.phoneVerified == _this.phoneVerified)&&(identical(other.username, _this.username) || other.username == _this.username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as UserMetadataModel;
  return Object.hash(runtimeType,_this.email,_this.sub,_this.targetApp,_this.emailVerified,_this.phoneVerified,_this.username);
}

@override
String toString() {
  final _this = this as UserMetadataModel;
  return 'UserMetadataModel(email: ${_this.email}, sub: ${_this.sub}, targetApp: ${_this.targetApp}, emailVerified: ${_this.emailVerified}, phoneVerified: ${_this.phoneVerified}, username: ${_this.username})';
}


}

/// @nodoc
abstract mixin class $UserMetadataModelCopyWith<$Res>  {
  factory $UserMetadataModelCopyWith(UserMetadataModel value, $Res Function(UserMetadataModel) _then) = _$UserMetadataModelCopyWithImpl;
@useResult
$Res call({
 String email, String sub,@JsonKey(name: 'target_app') String targetApp,@JsonKey(name: 'email_verified') bool emailVerified,@JsonKey(name: 'phone_verified') bool phoneVerified, String? username
});




}
/// @nodoc
class _$UserMetadataModelCopyWithImpl<$Res>
    implements $UserMetadataModelCopyWith<$Res> {
  _$UserMetadataModelCopyWithImpl(this._self, this._then);

  final UserMetadataModel _self;
  final $Res Function(UserMetadataModel) _then;

/// Create a copy of UserMetadataModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? email = null,Object? sub = null,Object? targetApp = null,Object? emailVerified = null,Object? phoneVerified = null,Object? username = freezed,}) {
  return _then(UserMetadataModel(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,sub: null == sub ? _self.sub : sub // ignore: cast_nullable_to_non_nullable
as String,targetApp: null == targetApp ? _self.targetApp : targetApp // ignore: cast_nullable_to_non_nullable
as String,emailVerified: null == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool,phoneVerified: null == phoneVerified ? _self.phoneVerified : phoneVerified // ignore: cast_nullable_to_non_nullable
as bool,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserMetadataModel].
extension UserMetadataModelPatterns on UserMetadataModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserMetadataModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserMetadataModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserMetadataModel value)  $default,){
final _that = this;
switch (_that) {
case _UserMetadataModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserMetadataModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserMetadataModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String email,  String sub, @JsonKey(name: 'target_app')  String targetApp, @JsonKey(name: 'email_verified')  bool emailVerified, @JsonKey(name: 'phone_verified')  bool phoneVerified,  String? username)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserMetadataModel() when $default != null:
return $default(_that.email,_that.sub,_that.targetApp,_that.emailVerified,_that.phoneVerified,_that.username);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String email,  String sub, @JsonKey(name: 'target_app')  String targetApp, @JsonKey(name: 'email_verified')  bool emailVerified, @JsonKey(name: 'phone_verified')  bool phoneVerified,  String? username)  $default,) {final _that = this;
switch (_that) {
case _UserMetadataModel():
return $default(_that.email,_that.sub,_that.targetApp,_that.emailVerified,_that.phoneVerified,_that.username);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String email,  String sub, @JsonKey(name: 'target_app')  String targetApp, @JsonKey(name: 'email_verified')  bool emailVerified, @JsonKey(name: 'phone_verified')  bool phoneVerified,  String? username)?  $default,) {final _that = this;
switch (_that) {
case _UserMetadataModel() when $default != null:
return $default(_that.email,_that.sub,_that.targetApp,_that.emailVerified,_that.phoneVerified,_that.username);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserMetadataModel implements UserMetadataModel {
   _UserMetadataModel({required this.email, required this.sub, @JsonKey(name: 'target_app') required this.targetApp, @JsonKey(name: 'email_verified') required this.emailVerified, @JsonKey(name: 'phone_verified') required this.phoneVerified, this.username});
  factory _UserMetadataModel.fromJson(Map<String, dynamic> json) => _$UserMetadataModelFromJson(json);

@override final  String email;
@override final  String sub;
@override@JsonKey(name: 'target_app') final  String targetApp;
@override@JsonKey(name: 'email_verified') final  bool emailVerified;
@override@JsonKey(name: 'phone_verified') final  bool phoneVerified;
@override final  String? username;

/// Create a copy of UserMetadataModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserMetadataModelCopyWith<_UserMetadataModel> get copyWith => __$UserMetadataModelCopyWithImpl<_UserMetadataModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserMetadataModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserMetadataModel&&(identical(other.email, email) || other.email == email)&&(identical(other.sub, sub) || other.sub == sub)&&(identical(other.targetApp, targetApp) || other.targetApp == targetApp)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.phoneVerified, phoneVerified) || other.phoneVerified == phoneVerified)&&(identical(other.username, username) || other.username == username));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,email,sub,targetApp,emailVerified,phoneVerified,username);
}

@override
String toString() {
    return 'UserMetadataModel(email: $email, sub: $sub, targetApp: $targetApp, emailVerified: $emailVerified, phoneVerified: $phoneVerified, username: $username)';
}


}

/// @nodoc
abstract mixin class _$UserMetadataModelCopyWith<$Res> implements $UserMetadataModelCopyWith<$Res> {
  factory _$UserMetadataModelCopyWith(_UserMetadataModel value, $Res Function(_UserMetadataModel) _then) = __$UserMetadataModelCopyWithImpl;
@override @useResult
$Res call({
 String email, String sub,@JsonKey(name: 'target_app') String targetApp,@JsonKey(name: 'email_verified') bool emailVerified,@JsonKey(name: 'phone_verified') bool phoneVerified, String? username
});




}
/// @nodoc
class __$UserMetadataModelCopyWithImpl<$Res>
    implements _$UserMetadataModelCopyWith<$Res> {
  __$UserMetadataModelCopyWithImpl(this._self, this._then);

  final _UserMetadataModel _self;
  final $Res Function(_UserMetadataModel) _then;

/// Create a copy of UserMetadataModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? email = null,Object? sub = null,Object? targetApp = null,Object? emailVerified = null,Object? phoneVerified = null,Object? username = freezed,}) {
  return _then(_UserMetadataModel(
email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,sub: null == sub ? _self.sub : sub // ignore: cast_nullable_to_non_nullable
as String,targetApp: null == targetApp ? _self.targetApp : targetApp // ignore: cast_nullable_to_non_nullable
as String,emailVerified: null == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as bool,phoneVerified: null == phoneVerified ? _self.phoneVerified : phoneVerified // ignore: cast_nullable_to_non_nullable
as bool,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
