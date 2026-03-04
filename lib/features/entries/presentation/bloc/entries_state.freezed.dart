// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entries_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EntriesState {

 EntriesStatus get status; EntriesPageData? get entriesPageData; int get currentTabIndex; List<TabData> get tabs;
/// Create a copy of EntriesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntriesStateCopyWith<EntriesState> get copyWith => _$EntriesStateCopyWithImpl<EntriesState>(this as EntriesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntriesState&&(identical(other.status, status) || other.status == status)&&(identical(other.entriesPageData, entriesPageData) || other.entriesPageData == entriesPageData)&&(identical(other.currentTabIndex, currentTabIndex) || other.currentTabIndex == currentTabIndex)&&const DeepCollectionEquality().equals(other.tabs, tabs));
}


@override
int get hashCode => Object.hash(runtimeType,status,entriesPageData,currentTabIndex,const DeepCollectionEquality().hash(tabs));

@override
String toString() {
  return 'EntriesState(status: $status, entriesPageData: $entriesPageData, currentTabIndex: $currentTabIndex, tabs: $tabs)';
}


}

/// @nodoc
abstract mixin class $EntriesStateCopyWith<$Res>  {
  factory $EntriesStateCopyWith(EntriesState value, $Res Function(EntriesState) _then) = _$EntriesStateCopyWithImpl;
@useResult
$Res call({
 EntriesStatus status, EntriesPageData? entriesPageData, int currentTabIndex, List<TabData> tabs
});


$EntriesPageDataCopyWith<$Res>? get entriesPageData;

}
/// @nodoc
class _$EntriesStateCopyWithImpl<$Res>
    implements $EntriesStateCopyWith<$Res> {
  _$EntriesStateCopyWithImpl(this._self, this._then);

  final EntriesState _self;
  final $Res Function(EntriesState) _then;

/// Create a copy of EntriesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? entriesPageData = freezed,Object? currentTabIndex = null,Object? tabs = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EntriesStatus,entriesPageData: freezed == entriesPageData ? _self.entriesPageData : entriesPageData // ignore: cast_nullable_to_non_nullable
as EntriesPageData?,currentTabIndex: null == currentTabIndex ? _self.currentTabIndex : currentTabIndex // ignore: cast_nullable_to_non_nullable
as int,tabs: null == tabs ? _self.tabs : tabs // ignore: cast_nullable_to_non_nullable
as List<TabData>,
  ));
}
/// Create a copy of EntriesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntriesPageDataCopyWith<$Res>? get entriesPageData {
    if (_self.entriesPageData == null) {
    return null;
  }

  return $EntriesPageDataCopyWith<$Res>(_self.entriesPageData!, (value) {
    return _then(_self.copyWith(entriesPageData: value));
  });
}
}


/// Adds pattern-matching-related methods to [EntriesState].
extension EntriesStatePatterns on EntriesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntriesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntriesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntriesState value)  $default,){
final _that = this;
switch (_that) {
case _EntriesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntriesState value)?  $default,){
final _that = this;
switch (_that) {
case _EntriesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EntriesStatus status,  EntriesPageData? entriesPageData,  int currentTabIndex,  List<TabData> tabs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntriesState() when $default != null:
return $default(_that.status,_that.entriesPageData,_that.currentTabIndex,_that.tabs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EntriesStatus status,  EntriesPageData? entriesPageData,  int currentTabIndex,  List<TabData> tabs)  $default,) {final _that = this;
switch (_that) {
case _EntriesState():
return $default(_that.status,_that.entriesPageData,_that.currentTabIndex,_that.tabs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EntriesStatus status,  EntriesPageData? entriesPageData,  int currentTabIndex,  List<TabData> tabs)?  $default,) {final _that = this;
switch (_that) {
case _EntriesState() when $default != null:
return $default(_that.status,_that.entriesPageData,_that.currentTabIndex,_that.tabs);case _:
  return null;

}
}

}

/// @nodoc


class _EntriesState implements EntriesState {
  const _EntriesState({this.status = EntriesStatus.initial, this.entriesPageData, this.currentTabIndex = 0, final  List<TabData> tabs = const [TabData(status: TabDataStatus.loading, outdated: true, name: scoreTabName, description: scoreTabDescription, entries: <EntryEntity>[]), TabData(status: TabDataStatus.loading, outdated: true, name: strugglingTabName, description: strugglingTabDescription, entries: <EntryEntity>[]), TabData(status: TabDataStatus.loading, outdated: true, name: todayTabName, description: todayTabDescription, entries: <EntryEntity>[]), TabData(status: TabDataStatus.loading, outdated: true, name: unseenTabName, description: unseenTabDescription, entries: <EntryEntity>[]), TabData(status: TabDataStatus.loading, outdated: true, name: browseTabName, description: browseTabDescription, entries: <EntryEntity>[]), TabData(status: TabDataStatus.loading, outdated: true, name: searchTabName, description: searchTabDescription, entries: <EntryEntity>[])]}): _tabs = tabs;
  

@override@JsonKey() final  EntriesStatus status;
@override final  EntriesPageData? entriesPageData;
@override@JsonKey() final  int currentTabIndex;
 final  List<TabData> _tabs;
@override@JsonKey() List<TabData> get tabs {
  if (_tabs is EqualUnmodifiableListView) return _tabs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tabs);
}


/// Create a copy of EntriesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntriesStateCopyWith<_EntriesState> get copyWith => __$EntriesStateCopyWithImpl<_EntriesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntriesState&&(identical(other.status, status) || other.status == status)&&(identical(other.entriesPageData, entriesPageData) || other.entriesPageData == entriesPageData)&&(identical(other.currentTabIndex, currentTabIndex) || other.currentTabIndex == currentTabIndex)&&const DeepCollectionEquality().equals(other._tabs, _tabs));
}


@override
int get hashCode => Object.hash(runtimeType,status,entriesPageData,currentTabIndex,const DeepCollectionEquality().hash(_tabs));

@override
String toString() {
  return 'EntriesState(status: $status, entriesPageData: $entriesPageData, currentTabIndex: $currentTabIndex, tabs: $tabs)';
}


}

/// @nodoc
abstract mixin class _$EntriesStateCopyWith<$Res> implements $EntriesStateCopyWith<$Res> {
  factory _$EntriesStateCopyWith(_EntriesState value, $Res Function(_EntriesState) _then) = __$EntriesStateCopyWithImpl;
@override @useResult
$Res call({
 EntriesStatus status, EntriesPageData? entriesPageData, int currentTabIndex, List<TabData> tabs
});


@override $EntriesPageDataCopyWith<$Res>? get entriesPageData;

}
/// @nodoc
class __$EntriesStateCopyWithImpl<$Res>
    implements _$EntriesStateCopyWith<$Res> {
  __$EntriesStateCopyWithImpl(this._self, this._then);

  final _EntriesState _self;
  final $Res Function(_EntriesState) _then;

/// Create a copy of EntriesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? entriesPageData = freezed,Object? currentTabIndex = null,Object? tabs = null,}) {
  return _then(_EntriesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EntriesStatus,entriesPageData: freezed == entriesPageData ? _self.entriesPageData : entriesPageData // ignore: cast_nullable_to_non_nullable
as EntriesPageData?,currentTabIndex: null == currentTabIndex ? _self.currentTabIndex : currentTabIndex // ignore: cast_nullable_to_non_nullable
as int,tabs: null == tabs ? _self._tabs : tabs // ignore: cast_nullable_to_non_nullable
as List<TabData>,
  ));
}

/// Create a copy of EntriesState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EntriesPageDataCopyWith<$Res>? get entriesPageData {
    if (_self.entriesPageData == null) {
    return null;
  }

  return $EntriesPageDataCopyWith<$Res>(_self.entriesPageData!, (value) {
    return _then(_self.copyWith(entriesPageData: value));
  });
}
}

// dart format on
