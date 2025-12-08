// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_field_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateFieldListState {

 CreateFieldListStatus get status; String get name; CheckType get checkType; bool get readAnswer; int get color;
/// Create a copy of CreateFieldListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateFieldListStateCopyWith<CreateFieldListState> get copyWith => _$CreateFieldListStateCopyWithImpl<CreateFieldListState>(this as CreateFieldListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateFieldListState&&(identical(other.status, status) || other.status == status)&&(identical(other.name, name) || other.name == name)&&(identical(other.checkType, checkType) || other.checkType == checkType)&&(identical(other.readAnswer, readAnswer) || other.readAnswer == readAnswer)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,status,name,checkType,readAnswer,color);

@override
String toString() {
  return 'CreateFieldListState(status: $status, name: $name, checkType: $checkType, readAnswer: $readAnswer, color: $color)';
}


}

/// @nodoc
abstract mixin class $CreateFieldListStateCopyWith<$Res>  {
  factory $CreateFieldListStateCopyWith(CreateFieldListState value, $Res Function(CreateFieldListState) _then) = _$CreateFieldListStateCopyWithImpl;
@useResult
$Res call({
 CreateFieldListStatus status, String name, CheckType checkType, bool readAnswer, int color
});




}
/// @nodoc
class _$CreateFieldListStateCopyWithImpl<$Res>
    implements $CreateFieldListStateCopyWith<$Res> {
  _$CreateFieldListStateCopyWithImpl(this._self, this._then);

  final CreateFieldListState _self;
  final $Res Function(CreateFieldListState) _then;

/// Create a copy of CreateFieldListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? name = null,Object? checkType = null,Object? readAnswer = null,Object? color = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CreateFieldListStatus,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,checkType: null == checkType ? _self.checkType : checkType // ignore: cast_nullable_to_non_nullable
as CheckType,readAnswer: null == readAnswer ? _self.readAnswer : readAnswer // ignore: cast_nullable_to_non_nullable
as bool,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateFieldListState].
extension CreateFieldListStatePatterns on CreateFieldListState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateFieldListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateFieldListState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateFieldListState value)  $default,){
final _that = this;
switch (_that) {
case _CreateFieldListState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateFieldListState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateFieldListState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CreateFieldListStatus status,  String name,  CheckType checkType,  bool readAnswer,  int color)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateFieldListState() when $default != null:
return $default(_that.status,_that.name,_that.checkType,_that.readAnswer,_that.color);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CreateFieldListStatus status,  String name,  CheckType checkType,  bool readAnswer,  int color)  $default,) {final _that = this;
switch (_that) {
case _CreateFieldListState():
return $default(_that.status,_that.name,_that.checkType,_that.readAnswer,_that.color);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CreateFieldListStatus status,  String name,  CheckType checkType,  bool readAnswer,  int color)?  $default,) {final _that = this;
switch (_that) {
case _CreateFieldListState() when $default != null:
return $default(_that.status,_that.name,_that.checkType,_that.readAnswer,_that.color);case _:
  return null;

}
}

}

/// @nodoc


class _CreateFieldListState implements CreateFieldListState {
  const _CreateFieldListState({this.status = CreateFieldListStatus.initial, this.name = '', this.checkType = CheckType.NON_STRICT_IGNORE_CASE, this.readAnswer = false, this.color = 4294967295});
  

@override@JsonKey() final  CreateFieldListStatus status;
@override@JsonKey() final  String name;
@override@JsonKey() final  CheckType checkType;
@override@JsonKey() final  bool readAnswer;
@override@JsonKey() final  int color;

/// Create a copy of CreateFieldListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateFieldListStateCopyWith<_CreateFieldListState> get copyWith => __$CreateFieldListStateCopyWithImpl<_CreateFieldListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateFieldListState&&(identical(other.status, status) || other.status == status)&&(identical(other.name, name) || other.name == name)&&(identical(other.checkType, checkType) || other.checkType == checkType)&&(identical(other.readAnswer, readAnswer) || other.readAnswer == readAnswer)&&(identical(other.color, color) || other.color == color));
}


@override
int get hashCode => Object.hash(runtimeType,status,name,checkType,readAnswer,color);

@override
String toString() {
  return 'CreateFieldListState(status: $status, name: $name, checkType: $checkType, readAnswer: $readAnswer, color: $color)';
}


}

/// @nodoc
abstract mixin class _$CreateFieldListStateCopyWith<$Res> implements $CreateFieldListStateCopyWith<$Res> {
  factory _$CreateFieldListStateCopyWith(_CreateFieldListState value, $Res Function(_CreateFieldListState) _then) = __$CreateFieldListStateCopyWithImpl;
@override @useResult
$Res call({
 CreateFieldListStatus status, String name, CheckType checkType, bool readAnswer, int color
});




}
/// @nodoc
class __$CreateFieldListStateCopyWithImpl<$Res>
    implements _$CreateFieldListStateCopyWith<$Res> {
  __$CreateFieldListStateCopyWithImpl(this._self, this._then);

  final _CreateFieldListState _self;
  final $Res Function(_CreateFieldListState) _then;

/// Create a copy of CreateFieldListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? name = null,Object? checkType = null,Object? readAnswer = null,Object? color = null,}) {
  return _then(_CreateFieldListState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CreateFieldListStatus,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,checkType: null == checkType ? _self.checkType : checkType // ignore: cast_nullable_to_non_nullable
as CheckType,readAnswer: null == readAnswer ? _self.readAnswer : readAnswer // ignore: cast_nullable_to_non_nullable
as bool,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
