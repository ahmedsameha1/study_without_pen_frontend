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

 StateStatus get fieldsStateStatus; List<FieldEntity> get fields;
/// Create a copy of FieldsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldsStateCopyWith<FieldsState> get copyWith => _$FieldsStateCopyWithImpl<FieldsState>(this as FieldsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldsState&&(identical(other.fieldsStateStatus, fieldsStateStatus) || other.fieldsStateStatus == fieldsStateStatus)&&const DeepCollectionEquality().equals(other.fields, fields));
}


@override
int get hashCode => Object.hash(runtimeType,fieldsStateStatus,const DeepCollectionEquality().hash(fields));

@override
String toString() {
  return 'FieldsState(fieldsStateStatus: $fieldsStateStatus, fields: $fields)';
}


}

/// @nodoc
abstract mixin class $FieldsStateCopyWith<$Res>  {
  factory $FieldsStateCopyWith(FieldsState value, $Res Function(FieldsState) _then) = _$FieldsStateCopyWithImpl;
@useResult
$Res call({
 StateStatus fieldsStateStatus, List<FieldEntity> fields
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
@pragma('vm:prefer-inline') @override $Res call({Object? fieldsStateStatus = null,Object? fields = null,}) {
  return _then(_self.copyWith(
fieldsStateStatus: null == fieldsStateStatus ? _self.fieldsStateStatus : fieldsStateStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,fields: null == fields ? _self.fields : fields // ignore: cast_nullable_to_non_nullable
as List<FieldEntity>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StateStatus fieldsStateStatus,  List<FieldEntity> fields)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldsState() when $default != null:
return $default(_that.fieldsStateStatus,_that.fields);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StateStatus fieldsStateStatus,  List<FieldEntity> fields)  $default,) {final _that = this;
switch (_that) {
case _FieldsState():
return $default(_that.fieldsStateStatus,_that.fields);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StateStatus fieldsStateStatus,  List<FieldEntity> fields)?  $default,) {final _that = this;
switch (_that) {
case _FieldsState() when $default != null:
return $default(_that.fieldsStateStatus,_that.fields);case _:
  return null;

}
}

}

/// @nodoc


class _FieldsState implements FieldsState {
  const _FieldsState([this.fieldsStateStatus = StateStatus.loading, final  List<FieldEntity> fields = const []]): _fields = fields;
  

@override@JsonKey() final  StateStatus fieldsStateStatus;
 final  List<FieldEntity> _fields;
@override@JsonKey() List<FieldEntity> get fields {
  if (_fields is EqualUnmodifiableListView) return _fields;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fields);
}


/// Create a copy of FieldsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldsStateCopyWith<_FieldsState> get copyWith => __$FieldsStateCopyWithImpl<_FieldsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldsState&&(identical(other.fieldsStateStatus, fieldsStateStatus) || other.fieldsStateStatus == fieldsStateStatus)&&const DeepCollectionEquality().equals(other._fields, _fields));
}


@override
int get hashCode => Object.hash(runtimeType,fieldsStateStatus,const DeepCollectionEquality().hash(_fields));

@override
String toString() {
  return 'FieldsState(fieldsStateStatus: $fieldsStateStatus, fields: $fields)';
}


}

/// @nodoc
abstract mixin class _$FieldsStateCopyWith<$Res> implements $FieldsStateCopyWith<$Res> {
  factory _$FieldsStateCopyWith(_FieldsState value, $Res Function(_FieldsState) _then) = __$FieldsStateCopyWithImpl;
@override @useResult
$Res call({
 StateStatus fieldsStateStatus, List<FieldEntity> fields
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
@override @pragma('vm:prefer-inline') $Res call({Object? fieldsStateStatus = null,Object? fields = null,}) {
  return _then(_FieldsState(
null == fieldsStateStatus ? _self.fieldsStateStatus : fieldsStateStatus // ignore: cast_nullable_to_non_nullable
as StateStatus,null == fields ? _self._fields : fields // ignore: cast_nullable_to_non_nullable
as List<FieldEntity>,
  ));
}


}

// dart format on
