// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entries_page_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EntriesPageData {

 FieldListEntity get fieldList; List<EntryEntity> get entries;
/// Create a copy of EntriesPageData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntriesPageDataCopyWith<EntriesPageData> get copyWith => _$EntriesPageDataCopyWithImpl<EntriesPageData>(this as EntriesPageData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntriesPageData&&(identical(other.fieldList, fieldList) || other.fieldList == fieldList)&&const DeepCollectionEquality().equals(other.entries, entries));
}


@override
int get hashCode => Object.hash(runtimeType,fieldList,const DeepCollectionEquality().hash(entries));

@override
String toString() {
  return 'EntriesPageData(fieldList: $fieldList, entries: $entries)';
}


}

/// @nodoc
abstract mixin class $EntriesPageDataCopyWith<$Res>  {
  factory $EntriesPageDataCopyWith(EntriesPageData value, $Res Function(EntriesPageData) _then) = _$EntriesPageDataCopyWithImpl;
@useResult
$Res call({
 FieldListEntity fieldList, List<EntryEntity> entries
});


$FieldListEntityCopyWith<$Res> get fieldList;

}
/// @nodoc
class _$EntriesPageDataCopyWithImpl<$Res>
    implements $EntriesPageDataCopyWith<$Res> {
  _$EntriesPageDataCopyWithImpl(this._self, this._then);

  final EntriesPageData _self;
  final $Res Function(EntriesPageData) _then;

/// Create a copy of EntriesPageData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fieldList = null,Object? entries = null,}) {
  return _then(_self.copyWith(
fieldList: null == fieldList ? _self.fieldList : fieldList // ignore: cast_nullable_to_non_nullable
as FieldListEntity,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryEntity>,
  ));
}
/// Create a copy of EntriesPageData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldListEntityCopyWith<$Res> get fieldList {
  
  return $FieldListEntityCopyWith<$Res>(_self.fieldList, (value) {
    return _then(_self.copyWith(fieldList: value));
  });
}
}


/// Adds pattern-matching-related methods to [EntriesPageData].
extension EntriesPageDataPatterns on EntriesPageData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntriesPageData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntriesPageData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntriesPageData value)  $default,){
final _that = this;
switch (_that) {
case _EntriesPageData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntriesPageData value)?  $default,){
final _that = this;
switch (_that) {
case _EntriesPageData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FieldListEntity fieldList,  List<EntryEntity> entries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntriesPageData() when $default != null:
return $default(_that.fieldList,_that.entries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FieldListEntity fieldList,  List<EntryEntity> entries)  $default,) {final _that = this;
switch (_that) {
case _EntriesPageData():
return $default(_that.fieldList,_that.entries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FieldListEntity fieldList,  List<EntryEntity> entries)?  $default,) {final _that = this;
switch (_that) {
case _EntriesPageData() when $default != null:
return $default(_that.fieldList,_that.entries);case _:
  return null;

}
}

}

/// @nodoc


class _EntriesPageData implements EntriesPageData {
  const _EntriesPageData({required this.fieldList, required final  List<EntryEntity> entries}): _entries = entries;
  

@override final  FieldListEntity fieldList;
 final  List<EntryEntity> _entries;
@override List<EntryEntity> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}


/// Create a copy of EntriesPageData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntriesPageDataCopyWith<_EntriesPageData> get copyWith => __$EntriesPageDataCopyWithImpl<_EntriesPageData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntriesPageData&&(identical(other.fieldList, fieldList) || other.fieldList == fieldList)&&const DeepCollectionEquality().equals(other._entries, _entries));
}


@override
int get hashCode => Object.hash(runtimeType,fieldList,const DeepCollectionEquality().hash(_entries));

@override
String toString() {
  return 'EntriesPageData(fieldList: $fieldList, entries: $entries)';
}


}

/// @nodoc
abstract mixin class _$EntriesPageDataCopyWith<$Res> implements $EntriesPageDataCopyWith<$Res> {
  factory _$EntriesPageDataCopyWith(_EntriesPageData value, $Res Function(_EntriesPageData) _then) = __$EntriesPageDataCopyWithImpl;
@override @useResult
$Res call({
 FieldListEntity fieldList, List<EntryEntity> entries
});


@override $FieldListEntityCopyWith<$Res> get fieldList;

}
/// @nodoc
class __$EntriesPageDataCopyWithImpl<$Res>
    implements _$EntriesPageDataCopyWith<$Res> {
  __$EntriesPageDataCopyWithImpl(this._self, this._then);

  final _EntriesPageData _self;
  final $Res Function(_EntriesPageData) _then;

/// Create a copy of EntriesPageData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fieldList = null,Object? entries = null,}) {
  return _then(_EntriesPageData(
fieldList: null == fieldList ? _self.fieldList : fieldList // ignore: cast_nullable_to_non_nullable
as FieldListEntity,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryEntity>,
  ));
}

/// Create a copy of EntriesPageData
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
