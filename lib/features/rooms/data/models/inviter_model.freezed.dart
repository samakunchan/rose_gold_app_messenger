// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inviter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InviterModel {

 String get username;@JsonKey(name: 'user_tag') String get userTag; String? get id;@JsonKey(name: 'avatar_url') String? get avatarUrl;
/// Create a copy of InviterModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InviterModelCopyWith<InviterModel> get copyWith => _$InviterModelCopyWithImpl<InviterModel>(this as InviterModel, _$identity);

  /// Serializes this InviterModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as InviterModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InviterModel&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.userTag, _this.userTag) || other.userTag == _this.userTag)&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as InviterModel;
  return Object.hash(runtimeType,_this.username,_this.userTag,_this.id,_this.avatarUrl);
}

@override
String toString() {
  final _this = this as InviterModel;
  return 'InviterModel(username: ${_this.username}, userTag: ${_this.userTag}, id: ${_this.id}, avatarUrl: ${_this.avatarUrl})';
}


}

/// @nodoc
abstract mixin class $InviterModelCopyWith<$Res>  {
  factory $InviterModelCopyWith(InviterModel value, $Res Function(InviterModel) _then) = _$InviterModelCopyWithImpl;
@useResult
$Res call({
 String username,@JsonKey(name: 'user_tag') String userTag, String? id,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class _$InviterModelCopyWithImpl<$Res>
    implements $InviterModelCopyWith<$Res> {
  _$InviterModelCopyWithImpl(this._self, this._then);

  final InviterModel _self;
  final $Res Function(InviterModel) _then;

/// Create a copy of InviterModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? username = null,Object? userTag = null,Object? id = freezed,Object? avatarUrl = freezed,}) {
  return _then(InviterModel(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,userTag: null == userTag ? _self.userTag : userTag // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [InviterModel].
extension InviterModelPatterns on InviterModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InviterModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InviterModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InviterModel value)  $default,){
final _that = this;
switch (_that) {
case _InviterModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InviterModel value)?  $default,){
final _that = this;
switch (_that) {
case _InviterModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String username, @JsonKey(name: 'user_tag')  String userTag,  String? id, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InviterModel() when $default != null:
return $default(_that.username,_that.userTag,_that.id,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String username, @JsonKey(name: 'user_tag')  String userTag,  String? id, @JsonKey(name: 'avatar_url')  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _InviterModel():
return $default(_that.username,_that.userTag,_that.id,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String username, @JsonKey(name: 'user_tag')  String userTag,  String? id, @JsonKey(name: 'avatar_url')  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _InviterModel() when $default != null:
return $default(_that.username,_that.userTag,_that.id,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InviterModel implements InviterModel {
   _InviterModel({required this.username, @JsonKey(name: 'user_tag') required this.userTag, this.id, @JsonKey(name: 'avatar_url') this.avatarUrl});
  factory _InviterModel.fromJson(Map<String, dynamic> json) => _$InviterModelFromJson(json);

@override final  String username;
@override@JsonKey(name: 'user_tag') final  String userTag;
@override final  String? id;
@override@JsonKey(name: 'avatar_url') final  String? avatarUrl;

/// Create a copy of InviterModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InviterModelCopyWith<_InviterModel> get copyWith => __$InviterModelCopyWithImpl<_InviterModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InviterModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _InviterModel&&(identical(other.username, username) || other.username == username)&&(identical(other.userTag, userTag) || other.userTag == userTag)&&(identical(other.id, id) || other.id == id)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,username,userTag,id,avatarUrl);
}

@override
String toString() {
    return 'InviterModel(username: $username, userTag: $userTag, id: $id, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$InviterModelCopyWith<$Res> implements $InviterModelCopyWith<$Res> {
  factory _$InviterModelCopyWith(_InviterModel value, $Res Function(_InviterModel) _then) = __$InviterModelCopyWithImpl;
@override @useResult
$Res call({
 String username,@JsonKey(name: 'user_tag') String userTag, String? id,@JsonKey(name: 'avatar_url') String? avatarUrl
});




}
/// @nodoc
class __$InviterModelCopyWithImpl<$Res>
    implements _$InviterModelCopyWith<$Res> {
  __$InviterModelCopyWithImpl(this._self, this._then);

  final _InviterModel _self;
  final $Res Function(_InviterModel) _then;

/// Create a copy of InviterModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? username = null,Object? userTag = null,Object? id = freezed,Object? avatarUrl = freezed,}) {
  return _then(_InviterModel(
username: null == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String,userTag: null == userTag ? _self.userTag : userTag // ignore: cast_nullable_to_non_nullable
as String,id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
