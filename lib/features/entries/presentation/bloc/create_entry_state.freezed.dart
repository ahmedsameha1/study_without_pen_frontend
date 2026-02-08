// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_entry_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CreateEntryState {

 CreateEntryStatus get status; String get question; String get answer; String get order; Rank get rank; FieldListEntity? get fieldList;
/// Create a copy of CreateEntryState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateEntryStateCopyWith<CreateEntryState> get copyWith => _$CreateEntryStateCopyWithImpl<CreateEntryState>(this as CreateEntryState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateEntryState&&(identical(other.status, status) || other.status == status)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.order, order) || other.order == order)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.fieldList, fieldList) || other.fieldList == fieldList));
}


@override
int get hashCode => Object.hash(runtimeType,status,question,answer,order,rank,fieldList);

@override
String toString() {
  return 'CreateEntryState(status: $status, question: $question, answer: $answer, order: $order, rank: $rank, fieldList: $fieldList)';
}


}

/// @nodoc
abstract mixin class $CreateEntryStateCopyWith<$Res>  {
  factory $CreateEntryStateCopyWith(CreateEntryState value, $Res Function(CreateEntryState) _then) = _$CreateEntryStateCopyWithImpl;
@useResult
$Res call({
 CreateEntryStatus status, String question, String answer, String order, Rank rank, FieldListEntity? fieldList
});


$FieldListEntityCopyWith<$Res>? get fieldList;

}
/// @nodoc
class _$CreateEntryStateCopyWithImpl<$Res>
    implements $CreateEntryStateCopyWith<$Res> {
  _$CreateEntryStateCopyWithImpl(this._self, this._then);

  final CreateEntryState _self;
  final $Res Function(CreateEntryState) _then;

/// Create a copy of CreateEntryState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? question = null,Object? answer = null,Object? order = null,Object? rank = null,Object? fieldList = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CreateEntryStatus,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as Rank,fieldList: freezed == fieldList ? _self.fieldList : fieldList // ignore: cast_nullable_to_non_nullable
as FieldListEntity?,
  ));
}
/// Create a copy of CreateEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldListEntityCopyWith<$Res>? get fieldList {
    if (_self.fieldList == null) {
    return null;
  }

  return $FieldListEntityCopyWith<$Res>(_self.fieldList!, (value) {
    return _then(_self.copyWith(fieldList: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreateEntryState].
extension CreateEntryStatePatterns on CreateEntryState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateEntryState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateEntryState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateEntryState value)  $default,){
final _that = this;
switch (_that) {
case _CreateEntryState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateEntryState value)?  $default,){
final _that = this;
switch (_that) {
case _CreateEntryState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CreateEntryStatus status,  String question,  String answer,  String order,  Rank rank,  FieldListEntity? fieldList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateEntryState() when $default != null:
return $default(_that.status,_that.question,_that.answer,_that.order,_that.rank,_that.fieldList);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CreateEntryStatus status,  String question,  String answer,  String order,  Rank rank,  FieldListEntity? fieldList)  $default,) {final _that = this;
switch (_that) {
case _CreateEntryState():
return $default(_that.status,_that.question,_that.answer,_that.order,_that.rank,_that.fieldList);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CreateEntryStatus status,  String question,  String answer,  String order,  Rank rank,  FieldListEntity? fieldList)?  $default,) {final _that = this;
switch (_that) {
case _CreateEntryState() when $default != null:
return $default(_that.status,_that.question,_that.answer,_that.order,_that.rank,_that.fieldList);case _:
  return null;

}
}

}

/// @nodoc


class _CreateEntryState implements CreateEntryState {
  const _CreateEntryState({this.status = CreateEntryStatus.loading, this.question = '', this.answer = '', this.order = '', this.rank = Rank.normal, this.fieldList});
  

@override@JsonKey() final  CreateEntryStatus status;
@override@JsonKey() final  String question;
@override@JsonKey() final  String answer;
@override@JsonKey() final  String order;
@override@JsonKey() final  Rank rank;
@override final  FieldListEntity? fieldList;

/// Create a copy of CreateEntryState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateEntryStateCopyWith<_CreateEntryState> get copyWith => __$CreateEntryStateCopyWithImpl<_CreateEntryState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateEntryState&&(identical(other.status, status) || other.status == status)&&(identical(other.question, question) || other.question == question)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.order, order) || other.order == order)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.fieldList, fieldList) || other.fieldList == fieldList));
}


@override
int get hashCode => Object.hash(runtimeType,status,question,answer,order,rank,fieldList);

@override
String toString() {
  return 'CreateEntryState(status: $status, question: $question, answer: $answer, order: $order, rank: $rank, fieldList: $fieldList)';
}


}

/// @nodoc
abstract mixin class _$CreateEntryStateCopyWith<$Res> implements $CreateEntryStateCopyWith<$Res> {
  factory _$CreateEntryStateCopyWith(_CreateEntryState value, $Res Function(_CreateEntryState) _then) = __$CreateEntryStateCopyWithImpl;
@override @useResult
$Res call({
 CreateEntryStatus status, String question, String answer, String order, Rank rank, FieldListEntity? fieldList
});


@override $FieldListEntityCopyWith<$Res>? get fieldList;

}
/// @nodoc
class __$CreateEntryStateCopyWithImpl<$Res>
    implements _$CreateEntryStateCopyWith<$Res> {
  __$CreateEntryStateCopyWithImpl(this._self, this._then);

  final _CreateEntryState _self;
  final $Res Function(_CreateEntryState) _then;

/// Create a copy of CreateEntryState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? question = null,Object? answer = null,Object? order = null,Object? rank = null,Object? fieldList = freezed,}) {
  return _then(_CreateEntryState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as CreateEntryStatus,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as String,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as Rank,fieldList: freezed == fieldList ? _self.fieldList : fieldList // ignore: cast_nullable_to_non_nullable
as FieldListEntity?,
  ));
}

/// Create a copy of CreateEntryState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$FieldListEntityCopyWith<$Res>? get fieldList {
    if (_self.fieldList == null) {
    return null;
  }

  return $FieldListEntityCopyWith<$Res>(_self.fieldList!, (value) {
    return _then(_self.copyWith(fieldList: value));
  });
}
}

// dart format on
