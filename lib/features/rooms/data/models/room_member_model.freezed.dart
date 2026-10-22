// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_member_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoomMemberModel {

 String get id; String get role;@JsonKey(name: 'room_id') String get roomId;@JsonKey(name: 'user_id') String get userId;@JsonKey(name: 'joined_at') String get joinedAt; String? get username; String? get avatarUrl;
/// Create a copy of RoomMemberModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomMemberModelCopyWith<RoomMemberModel> get copyWith => _$RoomMemberModelCopyWithImpl<RoomMemberModel>(this as RoomMemberModel, _$identity);

  /// Serializes this RoomMemberModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RoomMemberModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomMemberModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.role, _this.role) || other.role == _this.role)&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.userId, _this.userId) || other.userId == _this.userId)&&(identical(other.joinedAt, _this.joinedAt) || other.joinedAt == _this.joinedAt)&&(identical(other.username, _this.username) || other.username == _this.username)&&(identical(other.avatarUrl, _this.avatarUrl) || other.avatarUrl == _this.avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RoomMemberModel;
  return Object.hash(runtimeType,_this.id,_this.role,_this.roomId,_this.userId,_this.joinedAt,_this.username,_this.avatarUrl);
}

@override
String toString() {
  final _this = this as RoomMemberModel;
  return 'RoomMemberModel(id: ${_this.id}, role: ${_this.role}, roomId: ${_this.roomId}, userId: ${_this.userId}, joinedAt: ${_this.joinedAt}, username: ${_this.username}, avatarUrl: ${_this.avatarUrl})';
}


}

/// @nodoc
abstract mixin class $RoomMemberModelCopyWith<$Res>  {
  factory $RoomMemberModelCopyWith(RoomMemberModel value, $Res Function(RoomMemberModel) _then) = _$RoomMemberModelCopyWithImpl;
@useResult
$Res call({
 String id, String role,@JsonKey(name: 'room_id') String roomId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'joined_at') String joinedAt, String? username, String? avatarUrl
});




}
/// @nodoc
class _$RoomMemberModelCopyWithImpl<$Res>
    implements $RoomMemberModelCopyWith<$Res> {
  _$RoomMemberModelCopyWithImpl(this._self, this._then);

  final RoomMemberModel _self;
  final $Res Function(RoomMemberModel) _then;

/// Create a copy of RoomMemberModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? role = null,Object? roomId = null,Object? userId = null,Object? joinedAt = null,Object? username = freezed,Object? avatarUrl = freezed,}) {
  return _then(RoomMemberModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RoomMemberModel].
extension RoomMemberModelPatterns on RoomMemberModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomMemberModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomMemberModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomMemberModel value)  $default,){
final _that = this;
switch (_that) {
case _RoomMemberModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomMemberModel value)?  $default,){
final _that = this;
switch (_that) {
case _RoomMemberModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String role, @JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'joined_at')  String joinedAt,  String? username,  String? avatarUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomMemberModel() when $default != null:
return $default(_that.id,_that.role,_that.roomId,_that.userId,_that.joinedAt,_that.username,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String role, @JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'joined_at')  String joinedAt,  String? username,  String? avatarUrl)  $default,) {final _that = this;
switch (_that) {
case _RoomMemberModel():
return $default(_that.id,_that.role,_that.roomId,_that.userId,_that.joinedAt,_that.username,_that.avatarUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String role, @JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'joined_at')  String joinedAt,  String? username,  String? avatarUrl)?  $default,) {final _that = this;
switch (_that) {
case _RoomMemberModel() when $default != null:
return $default(_that.id,_that.role,_that.roomId,_that.userId,_that.joinedAt,_that.username,_that.avatarUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomMemberModel implements RoomMemberModel {
   _RoomMemberModel({required this.id, required this.role, @JsonKey(name: 'room_id') required this.roomId, @JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'joined_at') required this.joinedAt, this.username, this.avatarUrl});
  factory _RoomMemberModel.fromJson(Map<String, dynamic> json) => _$RoomMemberModelFromJson(json);

@override final  String id;
@override final  String role;
@override@JsonKey(name: 'room_id') final  String roomId;
@override@JsonKey(name: 'user_id') final  String userId;
@override@JsonKey(name: 'joined_at') final  String joinedAt;
@override final  String? username;
@override final  String? avatarUrl;

/// Create a copy of RoomMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomMemberModelCopyWith<_RoomMemberModel> get copyWith => __$RoomMemberModelCopyWithImpl<_RoomMemberModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomMemberModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomMemberModel&&(identical(other.id, id) || other.id == id)&&(identical(other.role, role) || other.role == role)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.joinedAt, joinedAt) || other.joinedAt == joinedAt)&&(identical(other.username, username) || other.username == username)&&(identical(other.avatarUrl, avatarUrl) || other.avatarUrl == avatarUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,role,roomId,userId,joinedAt,username,avatarUrl);
}

@override
String toString() {
    return 'RoomMemberModel(id: $id, role: $role, roomId: $roomId, userId: $userId, joinedAt: $joinedAt, username: $username, avatarUrl: $avatarUrl)';
}


}

/// @nodoc
abstract mixin class _$RoomMemberModelCopyWith<$Res> implements $RoomMemberModelCopyWith<$Res> {
  factory _$RoomMemberModelCopyWith(_RoomMemberModel value, $Res Function(_RoomMemberModel) _then) = __$RoomMemberModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String role,@JsonKey(name: 'room_id') String roomId,@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'joined_at') String joinedAt, String? username, String? avatarUrl
});




}
/// @nodoc
class __$RoomMemberModelCopyWithImpl<$Res>
    implements _$RoomMemberModelCopyWith<$Res> {
  __$RoomMemberModelCopyWithImpl(this._self, this._then);

  final _RoomMemberModel _self;
  final $Res Function(_RoomMemberModel) _then;

/// Create a copy of RoomMemberModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? role = null,Object? roomId = null,Object? userId = null,Object? joinedAt = null,Object? username = freezed,Object? avatarUrl = freezed,}) {
  return _then(_RoomMemberModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,joinedAt: null == joinedAt ? _self.joinedAt : joinedAt // ignore: cast_nullable_to_non_nullable
as String,username: freezed == username ? _self.username : username // ignore: cast_nullable_to_non_nullable
as String?,avatarUrl: freezed == avatarUrl ? _self.avatarUrl : avatarUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
