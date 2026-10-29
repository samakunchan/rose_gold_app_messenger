// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MessageModel {

 String get id;@JsonKey(name: 'room_id') String get roomId;@JsonKey(name: 'sender_id') String get senderId; String get ciphertext; String get nonce;@JsonKey(name: 'key_fingerprint') String get keyFingerprint;@JsonKey(name: 'created_at') String get createdAt;@JsonKey(name: 'media_url') String? get mediaUrl;
/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MessageModelCopyWith<MessageModel> get copyWith => _$MessageModelCopyWithImpl<MessageModel>(this as MessageModel, _$identity);

  /// Serializes this MessageModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as MessageModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MessageModel&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.roomId, _this.roomId) || other.roomId == _this.roomId)&&(identical(other.senderId, _this.senderId) || other.senderId == _this.senderId)&&(identical(other.ciphertext, _this.ciphertext) || other.ciphertext == _this.ciphertext)&&(identical(other.nonce, _this.nonce) || other.nonce == _this.nonce)&&(identical(other.keyFingerprint, _this.keyFingerprint) || other.keyFingerprint == _this.keyFingerprint)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.mediaUrl, _this.mediaUrl) || other.mediaUrl == _this.mediaUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as MessageModel;
  return Object.hash(runtimeType,_this.id,_this.roomId,_this.senderId,_this.ciphertext,_this.nonce,_this.keyFingerprint,_this.createdAt,_this.mediaUrl);
}

@override
String toString() {
  final _this = this as MessageModel;
  return 'MessageModel(id: ${_this.id}, roomId: ${_this.roomId}, senderId: ${_this.senderId}, ciphertext: ${_this.ciphertext}, nonce: ${_this.nonce}, keyFingerprint: ${_this.keyFingerprint}, createdAt: ${_this.createdAt}, mediaUrl: ${_this.mediaUrl})';
}


}

/// @nodoc
abstract mixin class $MessageModelCopyWith<$Res>  {
  factory $MessageModelCopyWith(MessageModel value, $Res Function(MessageModel) _then) = _$MessageModelCopyWithImpl;
@useResult
$Res call({
 String id,@JsonKey(name: 'room_id') String roomId,@JsonKey(name: 'sender_id') String senderId, String ciphertext, String nonce,@JsonKey(name: 'key_fingerprint') String keyFingerprint,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'media_url') String? mediaUrl
});




}
/// @nodoc
class _$MessageModelCopyWithImpl<$Res>
    implements $MessageModelCopyWith<$Res> {
  _$MessageModelCopyWithImpl(this._self, this._then);

  final MessageModel _self;
  final $Res Function(MessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? roomId = null,Object? senderId = null,Object? ciphertext = null,Object? nonce = null,Object? keyFingerprint = null,Object? createdAt = null,Object? mediaUrl = freezed,}) {
  return _then(MessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,ciphertext: null == ciphertext ? _self.ciphertext : ciphertext // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,keyFingerprint: null == keyFingerprint ? _self.keyFingerprint : keyFingerprint // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MessageModel].
extension MessageModelPatterns on MessageModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MessageModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MessageModel value)  $default,){
final _that = this;
switch (_that) {
case _MessageModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MessageModel value)?  $default,){
final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'sender_id')  String senderId,  String ciphertext,  String nonce, @JsonKey(name: 'key_fingerprint')  String keyFingerprint, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'media_url')  String? mediaUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that.id,_that.roomId,_that.senderId,_that.ciphertext,_that.nonce,_that.keyFingerprint,_that.createdAt,_that.mediaUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id, @JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'sender_id')  String senderId,  String ciphertext,  String nonce, @JsonKey(name: 'key_fingerprint')  String keyFingerprint, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'media_url')  String? mediaUrl)  $default,) {final _that = this;
switch (_that) {
case _MessageModel():
return $default(_that.id,_that.roomId,_that.senderId,_that.ciphertext,_that.nonce,_that.keyFingerprint,_that.createdAt,_that.mediaUrl);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id, @JsonKey(name: 'room_id')  String roomId, @JsonKey(name: 'sender_id')  String senderId,  String ciphertext,  String nonce, @JsonKey(name: 'key_fingerprint')  String keyFingerprint, @JsonKey(name: 'created_at')  String createdAt, @JsonKey(name: 'media_url')  String? mediaUrl)?  $default,) {final _that = this;
switch (_that) {
case _MessageModel() when $default != null:
return $default(_that.id,_that.roomId,_that.senderId,_that.ciphertext,_that.nonce,_that.keyFingerprint,_that.createdAt,_that.mediaUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MessageModel implements MessageModel {
   _MessageModel({required this.id, @JsonKey(name: 'room_id') required this.roomId, @JsonKey(name: 'sender_id') required this.senderId, required this.ciphertext, required this.nonce, @JsonKey(name: 'key_fingerprint') required this.keyFingerprint, @JsonKey(name: 'created_at') required this.createdAt, @JsonKey(name: 'media_url') this.mediaUrl});
  factory _MessageModel.fromJson(Map<String, dynamic> json) => _$MessageModelFromJson(json);

@override final  String id;
@override@JsonKey(name: 'room_id') final  String roomId;
@override@JsonKey(name: 'sender_id') final  String senderId;
@override final  String ciphertext;
@override final  String nonce;
@override@JsonKey(name: 'key_fingerprint') final  String keyFingerprint;
@override@JsonKey(name: 'created_at') final  String createdAt;
@override@JsonKey(name: 'media_url') final  String? mediaUrl;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MessageModelCopyWith<_MessageModel> get copyWith => __$MessageModelCopyWithImpl<_MessageModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MessageModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _MessageModel&&(identical(other.id, id) || other.id == id)&&(identical(other.roomId, roomId) || other.roomId == roomId)&&(identical(other.senderId, senderId) || other.senderId == senderId)&&(identical(other.ciphertext, ciphertext) || other.ciphertext == ciphertext)&&(identical(other.nonce, nonce) || other.nonce == nonce)&&(identical(other.keyFingerprint, keyFingerprint) || other.keyFingerprint == keyFingerprint)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.mediaUrl, mediaUrl) || other.mediaUrl == mediaUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,id,roomId,senderId,ciphertext,nonce,keyFingerprint,createdAt,mediaUrl);
}

@override
String toString() {
    return 'MessageModel(id: $id, roomId: $roomId, senderId: $senderId, ciphertext: $ciphertext, nonce: $nonce, keyFingerprint: $keyFingerprint, createdAt: $createdAt, mediaUrl: $mediaUrl)';
}


}

/// @nodoc
abstract mixin class _$MessageModelCopyWith<$Res> implements $MessageModelCopyWith<$Res> {
  factory _$MessageModelCopyWith(_MessageModel value, $Res Function(_MessageModel) _then) = __$MessageModelCopyWithImpl;
@override @useResult
$Res call({
 String id,@JsonKey(name: 'room_id') String roomId,@JsonKey(name: 'sender_id') String senderId, String ciphertext, String nonce,@JsonKey(name: 'key_fingerprint') String keyFingerprint,@JsonKey(name: 'created_at') String createdAt,@JsonKey(name: 'media_url') String? mediaUrl
});




}
/// @nodoc
class __$MessageModelCopyWithImpl<$Res>
    implements _$MessageModelCopyWith<$Res> {
  __$MessageModelCopyWithImpl(this._self, this._then);

  final _MessageModel _self;
  final $Res Function(_MessageModel) _then;

/// Create a copy of MessageModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? roomId = null,Object? senderId = null,Object? ciphertext = null,Object? nonce = null,Object? keyFingerprint = null,Object? createdAt = null,Object? mediaUrl = freezed,}) {
  return _then(_MessageModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,roomId: null == roomId ? _self.roomId : roomId // ignore: cast_nullable_to_non_nullable
as String,senderId: null == senderId ? _self.senderId : senderId // ignore: cast_nullable_to_non_nullable
as String,ciphertext: null == ciphertext ? _self.ciphertext : ciphertext // ignore: cast_nullable_to_non_nullable
as String,nonce: null == nonce ? _self.nonce : nonce // ignore: cast_nullable_to_non_nullable
as String,keyFingerprint: null == keyFingerprint ? _self.keyFingerprint : keyFingerprint // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,mediaUrl: freezed == mediaUrl ? _self.mediaUrl : mediaUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
