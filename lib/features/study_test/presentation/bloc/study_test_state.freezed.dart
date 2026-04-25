// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'study_test_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudyTestState {

 FieldListEntity get fieldList; List<EntryEntity> get entries; List<EntryCounts> get counts; int get currentEntryIndex; bool? get isUserAnswerCorrect;
/// Create a copy of StudyTestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyTestStateCopyWith<StudyTestState> get copyWith => _$StudyTestStateCopyWithImpl<StudyTestState>(this as StudyTestState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyTestState&&(identical(other.fieldList, fieldList) || other.fieldList == fieldList)&&const DeepCollectionEquality().equals(other.entries, entries)&&const DeepCollectionEquality().equals(other.counts, counts)&&(identical(other.currentEntryIndex, currentEntryIndex) || other.currentEntryIndex == currentEntryIndex)&&(identical(other.isUserAnswerCorrect, isUserAnswerCorrect) || other.isUserAnswerCorrect == isUserAnswerCorrect));
}


@override
int get hashCode => Object.hash(runtimeType,fieldList,const DeepCollectionEquality().hash(entries),const DeepCollectionEquality().hash(counts),currentEntryIndex,isUserAnswerCorrect);

@override
String toString() {
  return 'StudyTestState(fieldList: $fieldList, entries: $entries, counts: $counts, currentEntryIndex: $currentEntryIndex, isUserAnswerCorrect: $isUserAnswerCorrect)';
}


}

/// @nodoc
abstract mixin class $StudyTestStateCopyWith<$Res>  {
  factory $StudyTestStateCopyWith(StudyTestState value, $Res Function(StudyTestState) _then) = _$StudyTestStateCopyWithImpl;
@useResult
$Res call({
 FieldListEntity fieldList, List<EntryEntity> entries, List<EntryCounts> counts, int currentEntryIndex, bool? isUserAnswerCorrect
});


$FieldListEntityCopyWith<$Res> get fieldList;

}
/// @nodoc
class _$StudyTestStateCopyWithImpl<$Res>
    implements $StudyTestStateCopyWith<$Res> {
  _$StudyTestStateCopyWithImpl(this._self, this._then);

  final StudyTestState _self;
  final $Res Function(StudyTestState) _then;

/// Create a copy of StudyTestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fieldList = null,Object? entries = null,Object? counts = null,Object? currentEntryIndex = null,Object? isUserAnswerCorrect = freezed,}) {
  return _then(_self.copyWith(
fieldList: null == fieldList ? _self.fieldList : fieldList // ignore: cast_nullable_to_non_nullable
as FieldListEntity,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryEntity>,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as List<EntryCounts>,currentEntryIndex: null == currentEntryIndex ? _self.currentEntryIndex : currentEntryIndex // ignore: cast_nullable_to_non_nullable
as int,isUserAnswerCorrect: freezed == isUserAnswerCorrect ? _self.isUserAnswerCorrect : isUserAnswerCorrect // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}
/// Create a copy of StudyTestState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldListEntityCopyWith<$Res> get fieldList {
  
  return $FieldListEntityCopyWith<$Res>(_self.fieldList, (value) {
    return _then(_self.copyWith(fieldList: value));
  });
}
}


/// Adds pattern-matching-related methods to [StudyTestState].
extension StudyTestStatePatterns on StudyTestState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudyTestState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudyTestState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudyTestState value)  $default,){
final _that = this;
switch (_that) {
case _StudyTestState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudyTestState value)?  $default,){
final _that = this;
switch (_that) {
case _StudyTestState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( FieldListEntity fieldList,  List<EntryEntity> entries,  List<EntryCounts> counts,  int currentEntryIndex,  bool? isUserAnswerCorrect)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyTestState() when $default != null:
return $default(_that.fieldList,_that.entries,_that.counts,_that.currentEntryIndex,_that.isUserAnswerCorrect);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( FieldListEntity fieldList,  List<EntryEntity> entries,  List<EntryCounts> counts,  int currentEntryIndex,  bool? isUserAnswerCorrect)  $default,) {final _that = this;
switch (_that) {
case _StudyTestState():
return $default(_that.fieldList,_that.entries,_that.counts,_that.currentEntryIndex,_that.isUserAnswerCorrect);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( FieldListEntity fieldList,  List<EntryEntity> entries,  List<EntryCounts> counts,  int currentEntryIndex,  bool? isUserAnswerCorrect)?  $default,) {final _that = this;
switch (_that) {
case _StudyTestState() when $default != null:
return $default(_that.fieldList,_that.entries,_that.counts,_that.currentEntryIndex,_that.isUserAnswerCorrect);case _:
  return null;

}
}

}

/// @nodoc


class _StudyTestState implements StudyTestState {
  const _StudyTestState({required this.fieldList, required final  List<EntryEntity> entries, required final  List<EntryCounts> counts, this.currentEntryIndex = 0, this.isUserAnswerCorrect = null}): assert(entries.length == counts.length, 'entries length must be equal to counts length'),_entries = entries,_counts = counts;
  

@override final  FieldListEntity fieldList;
 final  List<EntryEntity> _entries;
@override List<EntryEntity> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

 final  List<EntryCounts> _counts;
@override List<EntryCounts> get counts {
  if (_counts is EqualUnmodifiableListView) return _counts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_counts);
}

@override@JsonKey() final  int currentEntryIndex;
@override@JsonKey() final  bool? isUserAnswerCorrect;

/// Create a copy of StudyTestState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyTestStateCopyWith<_StudyTestState> get copyWith => __$StudyTestStateCopyWithImpl<_StudyTestState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyTestState&&(identical(other.fieldList, fieldList) || other.fieldList == fieldList)&&const DeepCollectionEquality().equals(other._entries, _entries)&&const DeepCollectionEquality().equals(other._counts, _counts)&&(identical(other.currentEntryIndex, currentEntryIndex) || other.currentEntryIndex == currentEntryIndex)&&(identical(other.isUserAnswerCorrect, isUserAnswerCorrect) || other.isUserAnswerCorrect == isUserAnswerCorrect));
}


@override
int get hashCode => Object.hash(runtimeType,fieldList,const DeepCollectionEquality().hash(_entries),const DeepCollectionEquality().hash(_counts),currentEntryIndex,isUserAnswerCorrect);

@override
String toString() {
  return 'StudyTestState(fieldList: $fieldList, entries: $entries, counts: $counts, currentEntryIndex: $currentEntryIndex, isUserAnswerCorrect: $isUserAnswerCorrect)';
}


}

/// @nodoc
abstract mixin class _$StudyTestStateCopyWith<$Res> implements $StudyTestStateCopyWith<$Res> {
  factory _$StudyTestStateCopyWith(_StudyTestState value, $Res Function(_StudyTestState) _then) = __$StudyTestStateCopyWithImpl;
@override @useResult
$Res call({
 FieldListEntity fieldList, List<EntryEntity> entries, List<EntryCounts> counts, int currentEntryIndex, bool? isUserAnswerCorrect
});


@override $FieldListEntityCopyWith<$Res> get fieldList;

}
/// @nodoc
class __$StudyTestStateCopyWithImpl<$Res>
    implements _$StudyTestStateCopyWith<$Res> {
  __$StudyTestStateCopyWithImpl(this._self, this._then);

  final _StudyTestState _self;
  final $Res Function(_StudyTestState) _then;

/// Create a copy of StudyTestState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fieldList = null,Object? entries = null,Object? counts = null,Object? currentEntryIndex = null,Object? isUserAnswerCorrect = freezed,}) {
  return _then(_StudyTestState(
fieldList: null == fieldList ? _self.fieldList : fieldList // ignore: cast_nullable_to_non_nullable
as FieldListEntity,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryEntity>,counts: null == counts ? _self._counts : counts // ignore: cast_nullable_to_non_nullable
as List<EntryCounts>,currentEntryIndex: null == currentEntryIndex ? _self.currentEntryIndex : currentEntryIndex // ignore: cast_nullable_to_non_nullable
as int,isUserAnswerCorrect: freezed == isUserAnswerCorrect ? _self.isUserAnswerCorrect : isUserAnswerCorrect // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

/// Create a copy of StudyTestState
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
