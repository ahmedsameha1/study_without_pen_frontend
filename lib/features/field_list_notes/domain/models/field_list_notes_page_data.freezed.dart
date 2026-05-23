// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_list_notes_page_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FieldListNotesPageData {

 FieldListEntity get fieldList; List<FieldListNoteEntity> get fieldListNotes;
/// Create a copy of FieldListNotesPageData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldListNotesPageDataCopyWith<FieldListNotesPageData> get copyWith => _$FieldListNotesPageDataCopyWithImpl<FieldListNotesPageData>(this as FieldListNotesPageData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldListNotesPageData&&(identical(other.fieldList, fieldList) || other.fieldList == fieldList)&&const DeepCollectionEquality().equals(other.fieldListNotes, fieldListNotes));
}


@override
int get hashCode => Object.hash(runtimeType,fieldList,const DeepCollectionEquality().hash(fieldListNotes));

@override
String toString() {
  return 'FieldListNotesPageData(fieldList: $fieldList, fieldListNotes: $fieldListNotes)';
}


}

/// @nodoc
abstract mixin class $FieldListNotesPageDataCopyWith<$Res>  {
  factory $FieldListNotesPageDataCopyWith(FieldListNotesPageData value, $Res Function(FieldListNotesPageData) _then) = _$FieldListNotesPageDataCopyWithImpl;
@useResult
$Res call({
 FieldListEntity fieldList, List<FieldListNoteEntity> fieldListNotes
});


$FieldListEntityCopyWith<$Res> get fieldList;

}
/// @nodoc
class _$FieldListNotesPageDataCopyWithImpl<$Res>
    implements $FieldListNotesPageDataCopyWith<$Res> {
  _$FieldListNotesPageDataCopyWithImpl(this._self, this._then);

  final FieldListNotesPageData _self;
  final $Res Function(FieldListNotesPageData) _then;

/// Create a copy of FieldListNotesPageData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fieldList = null,Object? fieldListNotes = null,}) {
  return _then(_self.copyWith(
fieldList: null == fieldList ? _self.fieldList : fieldList // ignore: cast_nullable_to_non_nullable
as FieldListEntity,fieldListNotes: null == fieldListNotes ? _self.fieldListNotes : fieldListNotes // ignore: cast_nullable_to_non_nullable
as List<FieldListNoteEntity>,
  ));
}
/// Create a copy of FieldListNotesPageData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldListEntityCopyWith<$Res> get fieldList {
  
  return $FieldListEntityCopyWith<$Res>(_self.fieldList, (value) {
    return _then(_self.copyWith(fieldList: value));
  });
}
}


/// Adds pattern-matching-related methods to [FieldListNotesPageData].
extension FieldListNotesPageDataPatterns on FieldListNotesPageData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FieldListNotesPageData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FieldListNotesPageData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FieldListNotesPageData value)  $default,){
final _that = this;
switch (_that) {
case _FieldListNotesPageData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FieldListNotesPageData value)?  $default,){
final _that = this;
switch (_that) {
case _FieldListNotesPageData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FieldListEntity fieldList,  List<FieldListNoteEntity> fieldListNotes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldListNotesPageData() when $default != null:
return $default(_that.fieldList,_that.fieldListNotes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FieldListEntity fieldList,  List<FieldListNoteEntity> fieldListNotes)  $default,) {final _that = this;
switch (_that) {
case _FieldListNotesPageData():
return $default(_that.fieldList,_that.fieldListNotes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FieldListEntity fieldList,  List<FieldListNoteEntity> fieldListNotes)?  $default,) {final _that = this;
switch (_that) {
case _FieldListNotesPageData() when $default != null:
return $default(_that.fieldList,_that.fieldListNotes);case _:
  return null;

}
}

}

/// @nodoc


class _FieldListNotesPageData implements FieldListNotesPageData {
  const _FieldListNotesPageData({required this.fieldList, required final  List<FieldListNoteEntity> fieldListNotes}): _fieldListNotes = fieldListNotes;
  

@override final  FieldListEntity fieldList;
 final  List<FieldListNoteEntity> _fieldListNotes;
@override List<FieldListNoteEntity> get fieldListNotes {
  if (_fieldListNotes is EqualUnmodifiableListView) return _fieldListNotes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fieldListNotes);
}


/// Create a copy of FieldListNotesPageData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldListNotesPageDataCopyWith<_FieldListNotesPageData> get copyWith => __$FieldListNotesPageDataCopyWithImpl<_FieldListNotesPageData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldListNotesPageData&&(identical(other.fieldList, fieldList) || other.fieldList == fieldList)&&const DeepCollectionEquality().equals(other._fieldListNotes, _fieldListNotes));
}


@override
int get hashCode => Object.hash(runtimeType,fieldList,const DeepCollectionEquality().hash(_fieldListNotes));

@override
String toString() {
  return 'FieldListNotesPageData(fieldList: $fieldList, fieldListNotes: $fieldListNotes)';
}


}

/// @nodoc
abstract mixin class _$FieldListNotesPageDataCopyWith<$Res> implements $FieldListNotesPageDataCopyWith<$Res> {
  factory _$FieldListNotesPageDataCopyWith(_FieldListNotesPageData value, $Res Function(_FieldListNotesPageData) _then) = __$FieldListNotesPageDataCopyWithImpl;
@override @useResult
$Res call({
 FieldListEntity fieldList, List<FieldListNoteEntity> fieldListNotes
});


@override $FieldListEntityCopyWith<$Res> get fieldList;

}
/// @nodoc
class __$FieldListNotesPageDataCopyWithImpl<$Res>
    implements _$FieldListNotesPageDataCopyWith<$Res> {
  __$FieldListNotesPageDataCopyWithImpl(this._self, this._then);

  final _FieldListNotesPageData _self;
  final $Res Function(_FieldListNotesPageData) _then;

/// Create a copy of FieldListNotesPageData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fieldList = null,Object? fieldListNotes = null,}) {
  return _then(_FieldListNotesPageData(
fieldList: null == fieldList ? _self.fieldList : fieldList // ignore: cast_nullable_to_non_nullable
as FieldListEntity,fieldListNotes: null == fieldListNotes ? _self._fieldListNotes : fieldListNotes // ignore: cast_nullable_to_non_nullable
as List<FieldListNoteEntity>,
  ));
}

/// Create a copy of FieldListNotesPageData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldListEntityCopyWith<$Res> get fieldList {
  
  return $FieldListEntityCopyWith<$Res>(_self.fieldList, (value) {
    return _then(_self.copyWith(fieldList: value));
  });
}
}

// dart format on
