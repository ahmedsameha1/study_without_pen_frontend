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

 List<EntryEntity> get entries; int get currentEntryIndex; List<EntryCounts> get counts;
/// Create a copy of StudyTestState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudyTestStateCopyWith<StudyTestState> get copyWith => _$StudyTestStateCopyWithImpl<StudyTestState>(this as StudyTestState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudyTestState&&const DeepCollectionEquality().equals(other.entries, entries)&&(identical(other.currentEntryIndex, currentEntryIndex) || other.currentEntryIndex == currentEntryIndex)&&const DeepCollectionEquality().equals(other.counts, counts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(entries),currentEntryIndex,const DeepCollectionEquality().hash(counts));

@override
String toString() {
  return 'StudyTestState(entries: $entries, currentEntryIndex: $currentEntryIndex, counts: $counts)';
}


}

/// @nodoc
abstract mixin class $StudyTestStateCopyWith<$Res>  {
  factory $StudyTestStateCopyWith(StudyTestState value, $Res Function(StudyTestState) _then) = _$StudyTestStateCopyWithImpl;
@useResult
$Res call({
 List<EntryEntity> entries, int currentEntryIndex, List<EntryCounts> counts
});




}
/// @nodoc
class _$StudyTestStateCopyWithImpl<$Res>
    implements $StudyTestStateCopyWith<$Res> {
  _$StudyTestStateCopyWithImpl(this._self, this._then);

  final StudyTestState _self;
  final $Res Function(StudyTestState) _then;

/// Create a copy of StudyTestState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? entries = null,Object? currentEntryIndex = null,Object? counts = null,}) {
  return _then(_self.copyWith(
entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryEntity>,currentEntryIndex: null == currentEntryIndex ? _self.currentEntryIndex : currentEntryIndex // ignore: cast_nullable_to_non_nullable
as int,counts: null == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as List<EntryCounts>,
  ));
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<EntryEntity> entries,  int currentEntryIndex,  List<EntryCounts> counts)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudyTestState() when $default != null:
return $default(_that.entries,_that.currentEntryIndex,_that.counts);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<EntryEntity> entries,  int currentEntryIndex,  List<EntryCounts> counts)  $default,) {final _that = this;
switch (_that) {
case _StudyTestState():
return $default(_that.entries,_that.currentEntryIndex,_that.counts);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<EntryEntity> entries,  int currentEntryIndex,  List<EntryCounts> counts)?  $default,) {final _that = this;
switch (_that) {
case _StudyTestState() when $default != null:
return $default(_that.entries,_that.currentEntryIndex,_that.counts);case _:
  return null;

}
}

}

/// @nodoc


class _StudyTestState implements StudyTestState {
  const _StudyTestState({final  List<EntryEntity> entries = const [], this.currentEntryIndex = 0, final  List<EntryCounts> counts = const []}): assert(entries.length == counts.length, 'entries length must be equal to counts length'),_entries = entries,_counts = counts;
  

 final  List<EntryEntity> _entries;
@override@JsonKey() List<EntryEntity> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}

@override@JsonKey() final  int currentEntryIndex;
 final  List<EntryCounts> _counts;
@override@JsonKey() List<EntryCounts> get counts {
  if (_counts is EqualUnmodifiableListView) return _counts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_counts);
}


/// Create a copy of StudyTestState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudyTestStateCopyWith<_StudyTestState> get copyWith => __$StudyTestStateCopyWithImpl<_StudyTestState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudyTestState&&const DeepCollectionEquality().equals(other._entries, _entries)&&(identical(other.currentEntryIndex, currentEntryIndex) || other.currentEntryIndex == currentEntryIndex)&&const DeepCollectionEquality().equals(other._counts, _counts));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_entries),currentEntryIndex,const DeepCollectionEquality().hash(_counts));

@override
String toString() {
  return 'StudyTestState(entries: $entries, currentEntryIndex: $currentEntryIndex, counts: $counts)';
}


}

/// @nodoc
abstract mixin class _$StudyTestStateCopyWith<$Res> implements $StudyTestStateCopyWith<$Res> {
  factory _$StudyTestStateCopyWith(_StudyTestState value, $Res Function(_StudyTestState) _then) = __$StudyTestStateCopyWithImpl;
@override @useResult
$Res call({
 List<EntryEntity> entries, int currentEntryIndex, List<EntryCounts> counts
});




}
/// @nodoc
class __$StudyTestStateCopyWithImpl<$Res>
    implements _$StudyTestStateCopyWith<$Res> {
  __$StudyTestStateCopyWithImpl(this._self, this._then);

  final _StudyTestState _self;
  final $Res Function(_StudyTestState) _then;

/// Create a copy of StudyTestState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? entries = null,Object? currentEntryIndex = null,Object? counts = null,}) {
  return _then(_StudyTestState(
entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryEntity>,currentEntryIndex: null == currentEntryIndex ? _self.currentEntryIndex : currentEntryIndex // ignore: cast_nullable_to_non_nullable
as int,counts: null == counts ? _self._counts : counts // ignore: cast_nullable_to_non_nullable
as List<EntryCounts>,
  ));
}


}

// dart format on
