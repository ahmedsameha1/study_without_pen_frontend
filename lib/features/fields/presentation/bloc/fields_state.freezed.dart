// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'fields_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FieldsState {

 FieldsStatus get status; List<(FieldEntity, int)> get fieldsWithFieldListsCount;
/// Create a copy of FieldsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldsStateCopyWith<FieldsState> get copyWith => _$FieldsStateCopyWithImpl<FieldsState>(this as FieldsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.fieldsWithFieldListsCount, fieldsWithFieldListsCount));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(fieldsWithFieldListsCount));

@override
String toString() {
  return 'FieldsState(status: $status, fieldsWithFieldListsCount: $fieldsWithFieldListsCount)';
}


}

/// @nodoc
abstract mixin class $FieldsStateCopyWith<$Res>  {
  factory $FieldsStateCopyWith(FieldsState value, $Res Function(FieldsState) _then) = _$FieldsStateCopyWithImpl;
@useResult
$Res call({
 FieldsStatus status, List<(FieldEntity, int)> fieldsWithFieldListsCount
});




}
/// @nodoc
class _$FieldsStateCopyWithImpl<$Res>
    implements $FieldsStateCopyWith<$Res> {
  _$FieldsStateCopyWithImpl(this._self, this._then);

  final FieldsState _self;
  final $Res Function(FieldsState) _then;

/// Create a copy of FieldsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? fieldsWithFieldListsCount = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FieldsStatus,fieldsWithFieldListsCount: null == fieldsWithFieldListsCount ? _self.fieldsWithFieldListsCount : fieldsWithFieldListsCount // ignore: cast_nullable_to_non_nullable
as List<(FieldEntity, int)>,
  ));
}

}


/// Adds pattern-matching-related methods to [FieldsState].
extension FieldsStatePatterns on FieldsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FieldsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FieldsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FieldsState value)  $default,){
final _that = this;
switch (_that) {
case _FieldsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FieldsState value)?  $default,){
final _that = this;
switch (_that) {
case _FieldsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FieldsStatus status,  List<(FieldEntity, int)> fieldsWithFieldListsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldsState() when $default != null:
return $default(_that.status,_that.fieldsWithFieldListsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FieldsStatus status,  List<(FieldEntity, int)> fieldsWithFieldListsCount)  $default,) {final _that = this;
switch (_that) {
case _FieldsState():
return $default(_that.status,_that.fieldsWithFieldListsCount);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FieldsStatus status,  List<(FieldEntity, int)> fieldsWithFieldListsCount)?  $default,) {final _that = this;
switch (_that) {
case _FieldsState() when $default != null:
return $default(_that.status,_that.fieldsWithFieldListsCount);case _:
  return null;

}
}

}

/// @nodoc


class _FieldsState implements FieldsState {
  const _FieldsState([this.status = FieldsStatus.initial, final  List<(FieldEntity, int)> fieldsWithFieldListsCount = const []]): _fieldsWithFieldListsCount = fieldsWithFieldListsCount;
  

@override@JsonKey() final  FieldsStatus status;
 final  List<(FieldEntity, int)> _fieldsWithFieldListsCount;
@override@JsonKey() List<(FieldEntity, int)> get fieldsWithFieldListsCount {
  if (_fieldsWithFieldListsCount is EqualUnmodifiableListView) return _fieldsWithFieldListsCount;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fieldsWithFieldListsCount);
}


/// Create a copy of FieldsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldsStateCopyWith<_FieldsState> get copyWith => __$FieldsStateCopyWithImpl<_FieldsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._fieldsWithFieldListsCount, _fieldsWithFieldListsCount));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_fieldsWithFieldListsCount));

@override
String toString() {
  return 'FieldsState(status: $status, fieldsWithFieldListsCount: $fieldsWithFieldListsCount)';
}


}

/// @nodoc
abstract mixin class _$FieldsStateCopyWith<$Res> implements $FieldsStateCopyWith<$Res> {
  factory _$FieldsStateCopyWith(_FieldsState value, $Res Function(_FieldsState) _then) = __$FieldsStateCopyWithImpl;
@override @useResult
$Res call({
 FieldsStatus status, List<(FieldEntity, int)> fieldsWithFieldListsCount
});




}
/// @nodoc
class __$FieldsStateCopyWithImpl<$Res>
    implements _$FieldsStateCopyWith<$Res> {
  __$FieldsStateCopyWithImpl(this._self, this._then);

  final _FieldsState _self;
  final $Res Function(_FieldsState) _then;

/// Create a copy of FieldsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? fieldsWithFieldListsCount = null,}) {
  return _then(_FieldsState(
null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FieldsStatus,null == fieldsWithFieldListsCount ? _self._fieldsWithFieldListsCount : fieldsWithFieldListsCount // ignore: cast_nullable_to_non_nullable
as List<(FieldEntity, int)>,
  ));
}


}

// dart format on
