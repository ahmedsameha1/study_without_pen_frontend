// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_list_notes_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FieldListNotesState {

 FieldListNotesStatus get status; List<FieldListNoteEntity> get fieldListNotes;
/// Create a copy of FieldListNotesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldListNotesStateCopyWith<FieldListNotesState> get copyWith => _$FieldListNotesStateCopyWithImpl<FieldListNotesState>(this as FieldListNotesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldListNotesState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.fieldListNotes, fieldListNotes));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(fieldListNotes));

@override
String toString() {
  return 'FieldListNotesState(status: $status, fieldListNotes: $fieldListNotes)';
}


}

/// @nodoc
abstract mixin class $FieldListNotesStateCopyWith<$Res>  {
  factory $FieldListNotesStateCopyWith(FieldListNotesState value, $Res Function(FieldListNotesState) _then) = _$FieldListNotesStateCopyWithImpl;
@useResult
$Res call({
 FieldListNotesStatus status, List<FieldListNoteEntity> fieldListNotes
});




}
/// @nodoc
class _$FieldListNotesStateCopyWithImpl<$Res>
    implements $FieldListNotesStateCopyWith<$Res> {
  _$FieldListNotesStateCopyWithImpl(this._self, this._then);

  final FieldListNotesState _self;
  final $Res Function(FieldListNotesState) _then;

/// Create a copy of FieldListNotesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? fieldListNotes = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FieldListNotesStatus,fieldListNotes: null == fieldListNotes ? _self.fieldListNotes : fieldListNotes // ignore: cast_nullable_to_non_nullable
as List<FieldListNoteEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [FieldListNotesState].
extension FieldListNotesStatePatterns on FieldListNotesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FieldListNotesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FieldListNotesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FieldListNotesState value)  $default,){
final _that = this;
switch (_that) {
case _FieldListNotesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FieldListNotesState value)?  $default,){
final _that = this;
switch (_that) {
case _FieldListNotesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FieldListNotesStatus status,  List<FieldListNoteEntity> fieldListNotes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldListNotesState() when $default != null:
return $default(_that.status,_that.fieldListNotes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FieldListNotesStatus status,  List<FieldListNoteEntity> fieldListNotes)  $default,) {final _that = this;
switch (_that) {
case _FieldListNotesState():
return $default(_that.status,_that.fieldListNotes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FieldListNotesStatus status,  List<FieldListNoteEntity> fieldListNotes)?  $default,) {final _that = this;
switch (_that) {
case _FieldListNotesState() when $default != null:
return $default(_that.status,_that.fieldListNotes);case _:
  return null;

}
}

}

/// @nodoc


class _FieldListNotesState implements FieldListNotesState {
  const _FieldListNotesState({this.status = FieldListNotesStatus.initial, final  List<FieldListNoteEntity> fieldListNotes = const []}): _fieldListNotes = fieldListNotes;
  

@override@JsonKey() final  FieldListNotesStatus status;
 final  List<FieldListNoteEntity> _fieldListNotes;
@override@JsonKey() List<FieldListNoteEntity> get fieldListNotes {
  if (_fieldListNotes is EqualUnmodifiableListView) return _fieldListNotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fieldListNotes);
}


/// Create a copy of FieldListNotesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldListNotesStateCopyWith<_FieldListNotesState> get copyWith => __$FieldListNotesStateCopyWithImpl<_FieldListNotesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldListNotesState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._fieldListNotes, _fieldListNotes));
}


@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_fieldListNotes));

@override
String toString() {
  return 'FieldListNotesState(status: $status, fieldListNotes: $fieldListNotes)';
}


}

/// @nodoc
abstract mixin class _$FieldListNotesStateCopyWith<$Res> implements $FieldListNotesStateCopyWith<$Res> {
  factory _$FieldListNotesStateCopyWith(_FieldListNotesState value, $Res Function(_FieldListNotesState) _then) = __$FieldListNotesStateCopyWithImpl;
@override @useResult
$Res call({
 FieldListNotesStatus status, List<FieldListNoteEntity> fieldListNotes
});




}
/// @nodoc
class __$FieldListNotesStateCopyWithImpl<$Res>
    implements _$FieldListNotesStateCopyWith<$Res> {
  __$FieldListNotesStateCopyWithImpl(this._self, this._then);

  final _FieldListNotesState _self;
  final $Res Function(_FieldListNotesState) _then;

/// Create a copy of FieldListNotesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? fieldListNotes = null,}) {
  return _then(_FieldListNotesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as FieldListNotesStatus,fieldListNotes: null == fieldListNotes ? _self._fieldListNotes : fieldListNotes // ignore: cast_nullable_to_non_nullable
as List<FieldListNoteEntity>,
  ));
}


}

// dart format on
