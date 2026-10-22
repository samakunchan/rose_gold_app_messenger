// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room_invitation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RoomInvitationModel {

 String get id;@JsonKey(name: 'room_id') String get roomId;@JsonKey(name: 'inviter_id') String get inviterId;@JsonKey(name: 'invited_user_id') String get invitedUserId;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'updated_at') String get updatedAt; String get status; InviterModel? get inviter;@JsonKey(name: 'rooms') RoomModel? get room;
/// Create a copy of RoomInvitationModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoomInvitationModelCopyWith<RoomInvitationModel> get copyWith => _$RoomInvitationModelCopyWithImpl<RoomInvitationModel>(this as RoomInvitationModel, _$identity);

  /// Serializes this RoomInvitationModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as RoomInvitationModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoomInvitationModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.inviterId, _this.inviterId) || other.inviterId == _this.inviterId)&&(identical(other.invitedUserId, _this.invitedUserId) || other.invitedUserId == _this.invitedUserId)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.updatedAt, _this.updatedAt) || other.updatedAt == _this.updatedAt)&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.inviter, _this.inviter) || other.inviter == _this.inviter)&&(identical(other.room, _this.room) || other.room == _this.room));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as RoomInvitationModel;
  return Object.hash(runtimeType,_this.id,_this.roomId,_this.inviterId,_this.invitedUserId,_this.createdAt,_this.updatedAt,_this.status,_this.inviter,_this.room);
}

@override
String toString() {
  final _this = this as RoomInvitationModel;
  return 'RoomInvitationModel(id: ${_this.id}, roomId: ${_this.roomId}, inviterId: ${_this.inviterId}, invitedUserId: ${_this.invitedUserId}, createdAt: ${_this.createdAt}, updatedAt: ${_this.updatedAt}, status: ${_this.status}, inviter: ${_this.inviter}, room: ${_this.room})';
}


}

/// @nodoc
abstract mixin class $RoomInvitationModelCopyWith<$Res>  {
  factory $RoomInvitationModelCopyWith(RoomInvitationModel value, $Res Function(RoomInvitationModel) _then) = _$RoomInvitationModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'room_id') String roomId,@JsonKey(name: 'inviter_id') String inviterId,@JsonKey(name: 'invited_user_id') String invitedUserId,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt, String status, InviterModel? inviter,@JsonKey(name: 'rooms') RoomModel? room
});


$InviterModelCopyWith<$Res>? get inviter;$RoomModelCopyWith<$Res>? get room;

}
/// @nodoc
class _$RoomInvitationModelCopyWithImpl<$Res>
    implements $RoomInvitationModelCopyWith<$Res> {
  _$RoomInvitationModelCopyWithImpl(this._self, this._then);

  final RoomInvitationModel _self;
  final $Res Function(RoomInvitationModel) _then;

/// Create a copy of RoomInvitationModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = null,Object? inviterId = null,Object? invitedUserId = null,Object? createdAt = null,Object? updatedAt = null,Object? status = null,Object? inviter = freezed,Object? room = freezed,}) {
  return _then(RoomInvitationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,inviterId: null == inviterId ? _self.inviterId : inviterId // ignore: cast_nullable_to_non_nullable
as String,invitedUserId: null == invitedUserId ? _self.invitedUserId : invitedUserId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,inviter: freezed == inviter ? _self.inviter : inviter // ignore: cast_nullable_to_non_nullable
as InviterModel?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as RoomModel?,
  ));
}
/// Create a copy of RoomInvitationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InviterModelCopyWith<$Res>? get inviter {
    if (_self.inviter == null) {
    return null;
  }

  return $InviterModelCopyWith<$Res>(_self.inviter!, (value) {
    return _then(_self.copyWith(inviter: value));
  });
}/// Create a copy of RoomInvitationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoomModelCopyWith<$Res>? get room {
    if (_self.room == null) {
    return null;
  }

  return $RoomModelCopyWith<$Res>(_self.room!, (value) {
    return _then(_self.copyWith(room: value));
  });
}
}


/// Adds pattern-matching-related methods to [RoomInvitationModel].
extension RoomInvitationModelPatterns on RoomInvitationModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoomInvitationModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoomInvitationModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoomInvitationModel value)  $default,){
final _that = this;
switch (_that) {
case _RoomInvitationModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoomInvitationModel value)?  $default,){
final _that = this;
switch (_that) {
case _RoomInvitationModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'inviter_id')  String inviterId, @JsonKey(name: 'invited_user_id')  String invitedUserId, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  String status,  InviterModel? inviter, @JsonKey(name: 'rooms')  RoomModel? room)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoomInvitationModel() when $default != null:
return $default(_that.id,_that.roomId,_that.inviterId,_that.invitedUserId,_that.createdAt,_that.updatedAt,_that.status,_that.inviter,_that.room);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'inviter_id')  String inviterId, @JsonKey(name: 'invited_user_id')  String invitedUserId, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  String status,  InviterModel? inviter, @JsonKey(name: 'rooms')  RoomModel? room)  $default,) {final _that = this;
switch (_that) {
case _RoomInvitationModel():
return $default(_that.id,_that.roomId,_that.inviterId,_that.invitedUserId,_that.createdAt,_that.updatedAt,_that.status,_that.inviter,_that.room);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'inviter_id')  String inviterId, @JsonKey(name: 'invited_user_id')  String invitedUserId, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'updated_at')  String updatedAt,  String status,  InviterModel? inviter, @JsonKey(name: 'rooms')  RoomModel? room)?  $default,) {final _that = this;
switch (_that) {
case _RoomInvitationModel() when $default != null:
return $default(_that.id,_that.roomId,_that.inviterId,_that.invitedUserId,_that.createdAt,_that.updatedAt,_that.status,_that.inviter,_that.room);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RoomInvitationModel implements RoomInvitationModel {
   _RoomInvitationModel({required this.id, @JsonKey(name: 'room_id') required this.roomId, @JsonKey(name: 'inviter_id') required this.inviterId, @JsonKey(name: 'invited_user_id') required this.invitedUserId, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'updated_at') required this.updatedAt, required this.status, this.inviter, @JsonKey(name: 'rooms') this.room});
  factory _RoomInvitationModel.fromJson(Map<String, dynamic> json) => _$RoomInvitationModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'room_id') final  String roomId;
@override@JsonKey(name: 'inviter_id') final  String inviterId;
@override@JsonKey(name: 'invited_user_id') final  String invitedUserId;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'updated_at') final  String updatedAt;
@override final  String status;
@override final  InviterModel? inviter;
@override@JsonKey(name: 'rooms') final  RoomModel? room;

/// Create a copy of RoomInvitationModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoomInvitationModelCopyWith<_RoomInvitationModel> get copyWith => __$RoomInvitationModelCopyWithImpl<_RoomInvitationModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RoomInvitationModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoomInvitationModel&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.inviterId, inviterId) || other.inviterId == inviterId)&&(identical(other.invitedUserId, invitedUserId) || other.invitedUserId == invitedUserId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.status, status) || other.status == status)&&(identical(other.inviter, inviter) || other.inviter == inviter)&&(identical(other.room, room) || other.room == room));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,roomId,inviterId,invitedUserId,createdAt,updatedAt,status,inviter,room);
}

@override
String toString() {
    return 'RoomInvitationModel(id: $id, roomId: $roomId, inviterId: $inviterId, invitedUserId: $invitedUserId, createdAt: $createdAt, updatedAt: $updatedAt, status: $status, inviter: $inviter, room: $room)';
}


}

/// @nodoc
abstract mixin class _$RoomInvitationModelCopyWith<$Res> implements $RoomInvitationModelCopyWith<$Res> {
  factory _$RoomInvitationModelCopyWith(_RoomInvitationModel value, $Res Function(_RoomInvitationModel) _then) = __$RoomInvitationModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'room_id') String roomId,@JsonKey(name: 'inviter_id') String inviterId,@JsonKey(name: 'invited_user_id') String invitedUserId,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'updated_at') String updatedAt, String status, InviterModel? inviter,@JsonKey(name: 'rooms') RoomModel? room
});


@override $InviterModelCopyWith<$Res>? get inviter;@override $RoomModelCopyWith<$Res>? get room;

}
/// @nodoc
class __$RoomInvitationModelCopyWithImpl<$Res>
    implements _$RoomInvitationModelCopyWith<$Res> {
  __$RoomInvitationModelCopyWithImpl(this._self, this._then);

  final _RoomInvitationModel _self;
  final $Res Function(_RoomInvitationModel) _then;

/// Create a copy of RoomInvitationModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = null,Object? inviterId = null,Object? invitedUserId = null,Object? createdAt = null,Object? updatedAt = null,Object? status = null,Object? inviter = freezed,Object? room = freezed,}) {
  return _then(_RoomInvitationModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,inviterId: null == inviterId ? _self.inviterId : inviterId // ignore: cast_nullable_to_non_nullable
as String,invitedUserId: null == invitedUserId ? _self.invitedUserId : invitedUserId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,inviter: freezed == inviter ? _self.inviter : inviter // ignore: cast_nullable_to_non_nullable
as InviterModel?,room: freezed == room ? _self.room : room // ignore: cast_nullable_to_non_nullable
as RoomModel?,
  ));
}

/// Create a copy of RoomInvitationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$InviterModelCopyWith<$Res>? get inviter {
    if (_self.inviter == null) {
    return null;
  }

  return $InviterModelCopyWith<$Res>(_self.inviter!, (value) {
    return _then(_self.copyWith(inviter: value));
  });
}/// Create a copy of RoomInvitationModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoomModelCopyWith<$Res>? get room {
    if (_self.room == null) {
    return null;
  }

  return $RoomModelCopyWith<$Res>(_self.room!, (value) {
    return _then(_self.copyWith(room: value));
  });
}
}

// dart format on
