// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_field_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateFieldState {

 CreateFieldStatus get status; String get userAccountId; String get name; int get color;
/// Create a copy of CreateFieldState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateFieldStateCopyWith<CreateFieldState> get copyWith => _$CreateFieldStateCopyWithImpl<CreateFieldState>(this as CreateFieldState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateFieldState&&(identical(other.status, status) || other.status == status)&&(identical(other.userAccountId, userAccountId) || other.userAccountId == userAccountId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,status,userAccountId,name,color);

@override
String toString() {
  return 'CreateFieldState(status: $status, userAccountId: $userAccountId, name: $name, color: $color)';
}


}

/// @nodoc
abstract mixin class $CreateFieldStateCopyWith<$Res>  {
  factory $CreateFieldStateCopyWith(CreateFieldState value, $Res Function(CreateFieldState) _then) = _$CreateFieldStateCopyWithImpl;
@useResult
$Res call({
 CreateFieldStatus status, String userAccountId, String name, int color
});




}
/// @nodoc
class _$CreateFieldStateCopyWithImpl<$Res>
    implements $CreateFieldStateCopyWith<$Res> {
  _$CreateFieldStateCopyWithImpl(this._self, this._then);

  final CreateFieldState _self;
  final $Res Function(CreateFieldState) _then;

/// Create a copy of CreateFieldState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? userAccountId = null,Object? name = null,Object? color = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CreateFieldStatus,userAccountId: null == userAccountId ? _self.userAccountId : userAccountId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateFieldState].
extension CreateFieldStatePatterns on CreateFieldState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateFieldState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateFieldState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateFieldState value)  $default,){
final _that = this;
switch (_that) {
case _CreateFieldState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateFieldState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateFieldState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CreateFieldStatus status,  String userAccountId,  String name,  int color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateFieldState() when $default != null:
return $default(_that.status,_that.userAccountId,_that.name,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CreateFieldStatus status,  String userAccountId,  String name,  int color)  $default,) {final _that = this;
switch (_that) {
case _CreateFieldState():
return $default(_that.status,_that.userAccountId,_that.name,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CreateFieldStatus status,  String userAccountId,  String name,  int color)?  $default,) {final _that = this;
switch (_that) {
case _CreateFieldState() when $default != null:
return $default(_that.status,_that.userAccountId,_that.name,_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _CreateFieldState implements CreateFieldState {
  const _CreateFieldState({this.status = CreateFieldStatus.initial, required this.userAccountId, this.name = '', this.color = 4294967295});
  

@override@JsonKey() final  CreateFieldStatus status;
@override final  String userAccountId;
@override@JsonKey() final  String name;
@override@JsonKey() final  int color;

/// Create a copy of CreateFieldState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateFieldStateCopyWith<_CreateFieldState> get copyWith => __$CreateFieldStateCopyWithImpl<_CreateFieldState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateFieldState&&(identical(other.status, status) || other.status == status)&&(identical(other.userAccountId, userAccountId) || other.userAccountId == userAccountId)&&(identical(other.name, name) || other.name == name)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,status,userAccountId,name,color);

@override
String toString() {
  return 'CreateFieldState(status: $status, userAccountId: $userAccountId, name: $name, color: $color)';
}


}

/// @nodoc
abstract mixin class _$CreateFieldStateCopyWith<$Res> implements $CreateFieldStateCopyWith<$Res> {
  factory _$CreateFieldStateCopyWith(_CreateFieldState value, $Res Function(_CreateFieldState) _then) = __$CreateFieldStateCopyWithImpl;
@override @useResult
$Res call({
 CreateFieldStatus status, String userAccountId, String name, int color
});




}
/// @nodoc
class __$CreateFieldStateCopyWithImpl<$Res>
    implements _$CreateFieldStateCopyWith<$Res> {
  __$CreateFieldStateCopyWithImpl(this._self, this._then);

  final _CreateFieldState _self;
  final $Res Function(_CreateFieldState) _then;

/// Create a copy of CreateFieldState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? userAccountId = null,Object? name = null,Object? color = null,}) {
  return _then(_CreateFieldState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CreateFieldStatus,userAccountId: null == userAccountId ? _self.userAccountId : userAccountId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
