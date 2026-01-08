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

 EntriesStatus get status; EntriesPageData? get entriesPageData;
/// Create a copy of EntriesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntriesStateCopyWith<EntriesState> get copyWith => _$EntriesStateCopyWithImpl<EntriesState>(this as EntriesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntriesState&&(identical(other.status, status) || other.status == status)&&(identical(other.entriesPageData, entriesPageData) || other.entriesPageData == entriesPageData));
}


@override
int get hashCode => Object.hash(runtimeType,status,entriesPageData);

@override
String toString() {
  return 'EntriesState(status: $status, entriesPageData: $entriesPageData)';
}


}

/// @nodoc
abstract mixin class $EntriesStateCopyWith<$Res>  {
  factory $EntriesStateCopyWith(EntriesState value, $Res Function(EntriesState) _then) = _$EntriesStateCopyWithImpl;
@useResult
$Res call({
 EntriesStatus status, EntriesPageData? entriesPageData
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
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? entriesPageData = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EntriesStatus,entriesPageData: freezed == entriesPageData ? _self.entriesPageData : entriesPageData // ignore: cast_nullable_to_non_nullable
as EntriesPageData?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( EntriesStatus status,  EntriesPageData? entriesPageData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntriesState() when $default != null:
return $default(_that.status,_that.entriesPageData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( EntriesStatus status,  EntriesPageData? entriesPageData)  $default,) {final _that = this;
switch (_that) {
case _EntriesState():
return $default(_that.status,_that.entriesPageData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( EntriesStatus status,  EntriesPageData? entriesPageData)?  $default,) {final _that = this;
switch (_that) {
case _EntriesState() when $default != null:
return $default(_that.status,_that.entriesPageData);case _:
  return null;

}
}

}

/// @nodoc


class _EntriesState implements EntriesState {
  const _EntriesState({this.status = EntriesStatus.initial, this.entriesPageData});
  

@override@JsonKey() final  EntriesStatus status;
@override final  EntriesPageData? entriesPageData;

/// Create a copy of EntriesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntriesStateCopyWith<_EntriesState> get copyWith => __$EntriesStateCopyWithImpl<_EntriesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntriesState&&(identical(other.status, status) || other.status == status)&&(identical(other.entriesPageData, entriesPageData) || other.entriesPageData == entriesPageData));
}


@override
int get hashCode => Object.hash(runtimeType,status,entriesPageData);

@override
String toString() {
  return 'EntriesState(status: $status, entriesPageData: $entriesPageData)';
}


}

/// @nodoc
abstract mixin class _$EntriesStateCopyWith<$Res> implements $EntriesStateCopyWith<$Res> {
  factory _$EntriesStateCopyWith(_EntriesState value, $Res Function(_EntriesState) _then) = __$EntriesStateCopyWithImpl;
@override @useResult
$Res call({
 EntriesStatus status, EntriesPageData? entriesPageData
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
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? entriesPageData = freezed,}) {
  return _then(_EntriesState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as EntriesStatus,entriesPageData: freezed == entriesPageData ? _self.entriesPageData : entriesPageData // ignore: cast_nullable_to_non_nullable
as EntriesPageData?,
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
