// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'theme_mode_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ThemeModeModel {

 String get label; ThemeMode get mode;
/// Create a copy of ThemeModeModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ThemeModeModelCopyWith<ThemeModeModel> get copyWith => _$ThemeModeModelCopyWithImpl<ThemeModeModel>(this as ThemeModeModel, _$identity);

  /// Serializes this ThemeModeModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  final _this = this as ThemeModeModel;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ThemeModeModel&&(identical(other.label, _this.label) || other.label == _this.label)&&(identical(other.mode, _this.mode) || other.mode == _this.mode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
  final _this = this as ThemeModeModel;
  return Object.hash(runtimeType,_this.label,_this.mode);
}

@override
String toString() {
  final _this = this as ThemeModeModel;
  return 'ThemeModeModel(label: ${_this.label}, mode: ${_this.mode})';
}


}

/// @nodoc
abstract mixin class $ThemeModeModelCopyWith<$Res>  {
  factory $ThemeModeModelCopyWith(ThemeModeModel value, $Res Function(ThemeModeModel) _then) = _$ThemeModeModelCopyWithImpl;
@useResult
$Res call({
 String label, ThemeMode mode
});




}
/// @nodoc
class _$ThemeModeModelCopyWithImpl<$Res>
    implements $ThemeModeModelCopyWith<$Res> {
  _$ThemeModeModelCopyWithImpl(this._self, this._then);

  final ThemeModeModel _self;
  final $Res Function(ThemeModeModel) _then;

/// Create a copy of ThemeModeModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? label = null,Object? mode = null,}) {
  return _then(ThemeModeModel(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ThemeMode,
  ));
}

}


/// Adds pattern-matching-related methods to [ThemeModeModel].
extension ThemeModeModelPatterns on ThemeModeModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ThemeModeModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ThemeModeModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ThemeModeModel value)  $default,){
final _that = this;
switch (_that) {
case _ThemeModeModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ThemeModeModel value)?  $default,){
final _that = this;
switch (_that) {
case _ThemeModeModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String label,  ThemeMode mode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ThemeModeModel() when $default != null:
return $default(_that.label,_that.mode);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String label,  ThemeMode mode)  $default,) {final _that = this;
switch (_that) {
case _ThemeModeModel():
return $default(_that.label,_that.mode);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String label,  ThemeMode mode)?  $default,) {final _that = this;
switch (_that) {
case _ThemeModeModel() when $default != null:
return $default(_that.label,_that.mode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ThemeModeModel implements ThemeModeModel {
   _ThemeModeModel({required this.label, required this.mode});
  factory _ThemeModeModel.fromJson(Map<String, dynamic> json) => _$ThemeModeModelFromJson(json);

@override final  String label;
@override final  ThemeMode mode;

/// Create a copy of ThemeModeModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ThemeModeModelCopyWith<_ThemeModeModel> get copyWith => __$ThemeModeModelCopyWithImpl<_ThemeModeModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ThemeModeModelToJson(this, );
}

@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _ThemeModeModel&&(identical(other.label, label) || other.label == label)&&(identical(other.mode, mode) || other.mode == mode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode {
    return Object.hash(runtimeType,label,mode);
}

@override
String toString() {
    return 'ThemeModeModel(label: $label, mode: $mode)';
}


}

/// @nodoc
abstract mixin class _$ThemeModeModelCopyWith<$Res> implements $ThemeModeModelCopyWith<$Res> {
  factory _$ThemeModeModelCopyWith(_ThemeModeModel value, $Res Function(_ThemeModeModel) _then) = __$ThemeModeModelCopyWithImpl;
@override @useResult
$Res call({
 String label, ThemeMode mode
});




}
/// @nodoc
class __$ThemeModeModelCopyWithImpl<$Res>
    implements _$ThemeModeModelCopyWith<$Res> {
  __$ThemeModeModelCopyWithImpl(this._self, this._then);

  final _ThemeModeModel _self;
  final $Res Function(_ThemeModeModel) _then;

/// Create a copy of ThemeModeModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? label = null,Object? mode = null,}) {
  return _then(_ThemeModeModel(
label: null == label ? _self.label : label // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ThemeMode,
  ));
}


}

// dart format on
