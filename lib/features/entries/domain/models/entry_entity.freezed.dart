// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'entry_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$EntryEntity {

 String get fieldListId; String get answer; String get question; DateTime get creationAt; DateTime get lastModificationAt; int get order; bool get didAskedAtCurrentTestRound; Rank get rank; int get askedCount; int get wronglyAnsweredCount; double get wrongness; String? get id; DateTime? get emulatedCreatedAt;
/// Create a copy of EntryEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EntryEntityCopyWith<EntryEntity> get copyWith => _$EntryEntityCopyWithImpl<EntryEntity>(this as EntryEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EntryEntity&&(identical(other.fieldListId, fieldListId) || other.fieldListId == fieldListId)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.question, question) || other.question == question)&&(identical(other.creationAt, creationAt) || other.creationAt == creationAt)&&(identical(other.lastModificationAt, lastModificationAt) || other.lastModificationAt == lastModificationAt)&&(identical(other.order, order) || other.order == order)&&(identical(other.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound) || other.didAskedAtCurrentTestRound == didAskedAtCurrentTestRound)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.askedCount, askedCount) || other.askedCount == askedCount)&&(identical(other.wronglyAnsweredCount, wronglyAnsweredCount) || other.wronglyAnsweredCount == wronglyAnsweredCount)&&(identical(other.wrongness, wrongness) || other.wrongness == wrongness)&&(identical(other.id, id) || other.id == id)&&(identical(other.emulatedCreatedAt, emulatedCreatedAt) || other.emulatedCreatedAt == emulatedCreatedAt));
}


@override
int get hashCode => Object.hash(runtimeType,fieldListId,answer,question,creationAt,lastModificationAt,order,didAskedAtCurrentTestRound,rank,askedCount,wronglyAnsweredCount,wrongness,id,emulatedCreatedAt);

@override
String toString() {
  return 'EntryEntity(fieldListId: $fieldListId, answer: $answer, question: $question, creationAt: $creationAt, lastModificationAt: $lastModificationAt, order: $order, didAskedAtCurrentTestRound: $didAskedAtCurrentTestRound, rank: $rank, askedCount: $askedCount, wronglyAnsweredCount: $wronglyAnsweredCount, wrongness: $wrongness, id: $id, emulatedCreatedAt: $emulatedCreatedAt)';
}


}

/// @nodoc
abstract mixin class $EntryEntityCopyWith<$Res>  {
  factory $EntryEntityCopyWith(EntryEntity value, $Res Function(EntryEntity) _then) = _$EntryEntityCopyWithImpl;
@useResult
$Res call({
 String? id, String fieldListId, String answer, String question, DateTime creationAt, DateTime lastModificationAt, int order, bool didAskedAtCurrentTestRound, DateTime? emulatedCreatedAt, Rank rank, int askedCount, int wronglyAnsweredCount, double wrongness
});




}
/// @nodoc
class _$EntryEntityCopyWithImpl<$Res>
    implements $EntryEntityCopyWith<$Res> {
  _$EntryEntityCopyWithImpl(this._self, this._then);

  final EntryEntity _self;
  final $Res Function(EntryEntity) _then;

/// Create a copy of EntryEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? fieldListId = null,Object? answer = null,Object? question = null,Object? creationAt = null,Object? lastModificationAt = null,Object? order = null,Object? didAskedAtCurrentTestRound = null,Object? emulatedCreatedAt = freezed,Object? rank = null,Object? askedCount = null,Object? wronglyAnsweredCount = null,Object? wrongness = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fieldListId: null == fieldListId ? _self.fieldListId : fieldListId // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,creationAt: null == creationAt ? _self.creationAt : creationAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastModificationAt: null == lastModificationAt ? _self.lastModificationAt : lastModificationAt // ignore: cast_nullable_to_non_nullable
as DateTime,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,didAskedAtCurrentTestRound: null == didAskedAtCurrentTestRound ? _self.didAskedAtCurrentTestRound : didAskedAtCurrentTestRound // ignore: cast_nullable_to_non_nullable
as bool,emulatedCreatedAt: freezed == emulatedCreatedAt ? _self.emulatedCreatedAt : emulatedCreatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as Rank,askedCount: null == askedCount ? _self.askedCount : askedCount // ignore: cast_nullable_to_non_nullable
as int,wronglyAnsweredCount: null == wronglyAnsweredCount ? _self.wronglyAnsweredCount : wronglyAnsweredCount // ignore: cast_nullable_to_non_nullable
as int,wrongness: null == wrongness ? _self.wrongness : wrongness // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [EntryEntity].
extension EntryEntityPatterns on EntryEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EntryEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EntryEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EntryEntity value)  $default,){
final _that = this;
switch (_that) {
case _EntryEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EntryEntity value)?  $default,){
final _that = this;
switch (_that) {
case _EntryEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String fieldListId,  String answer,  String question,  DateTime creationAt,  DateTime lastModificationAt,  int order,  bool didAskedAtCurrentTestRound,  DateTime? emulatedCreatedAt,  Rank rank,  int askedCount,  int wronglyAnsweredCount,  double wrongness)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EntryEntity() when $default != null:
return $default(_that.id,_that.fieldListId,_that.answer,_that.question,_that.creationAt,_that.lastModificationAt,_that.order,_that.didAskedAtCurrentTestRound,_that.emulatedCreatedAt,_that.rank,_that.askedCount,_that.wronglyAnsweredCount,_that.wrongness);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String fieldListId,  String answer,  String question,  DateTime creationAt,  DateTime lastModificationAt,  int order,  bool didAskedAtCurrentTestRound,  DateTime? emulatedCreatedAt,  Rank rank,  int askedCount,  int wronglyAnsweredCount,  double wrongness)  $default,) {final _that = this;
switch (_that) {
case _EntryEntity():
return $default(_that.id,_that.fieldListId,_that.answer,_that.question,_that.creationAt,_that.lastModificationAt,_that.order,_that.didAskedAtCurrentTestRound,_that.emulatedCreatedAt,_that.rank,_that.askedCount,_that.wronglyAnsweredCount,_that.wrongness);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String fieldListId,  String answer,  String question,  DateTime creationAt,  DateTime lastModificationAt,  int order,  bool didAskedAtCurrentTestRound,  DateTime? emulatedCreatedAt,  Rank rank,  int askedCount,  int wronglyAnsweredCount,  double wrongness)?  $default,) {final _that = this;
switch (_that) {
case _EntryEntity() when $default != null:
return $default(_that.id,_that.fieldListId,_that.answer,_that.question,_that.creationAt,_that.lastModificationAt,_that.order,_that.didAskedAtCurrentTestRound,_that.emulatedCreatedAt,_that.rank,_that.askedCount,_that.wronglyAnsweredCount,_that.wrongness);case _:
  return null;

}
}

}

/// @nodoc


class _EntryEntity extends EntryEntity {
   _EntryEntity({this.id, required final  String fieldListId, required final  String answer, required final  String question, required final  DateTime creationAt, required final  DateTime lastModificationAt, final  int order = Entrys.ORDER_MINIMUM_VALUE, final  bool didAskedAtCurrentTestRound = true, this.emulatedCreatedAt, final  Rank rank = Rank.normal, final  int askedCount = 0, final  int wronglyAnsweredCount = 0, final  double wrongness = 0}): super._(fieldListId: fieldListId, answer: answer, question: question, creationAt: creationAt, lastModificationAt: lastModificationAt, order: order, didAskedAtCurrentTestRound: didAskedAtCurrentTestRound, rank: rank, askedCount: askedCount, wronglyAnsweredCount: wronglyAnsweredCount, wrongness: wrongness);
  

@override final  String? id;
@override final  DateTime? emulatedCreatedAt;

/// Create a copy of EntryEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EntryEntityCopyWith<_EntryEntity> get copyWith => __$EntryEntityCopyWithImpl<_EntryEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EntryEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.fieldListId, fieldListId) || other.fieldListId == fieldListId)&&(identical(other.answer, answer) || other.answer == answer)&&(identical(other.question, question) || other.question == question)&&(identical(other.creationAt, creationAt) || other.creationAt == creationAt)&&(identical(other.lastModificationAt, lastModificationAt) || other.lastModificationAt == lastModificationAt)&&(identical(other.order, order) || other.order == order)&&(identical(other.didAskedAtCurrentTestRound, didAskedAtCurrentTestRound) || other.didAskedAtCurrentTestRound == didAskedAtCurrentTestRound)&&(identical(other.emulatedCreatedAt, emulatedCreatedAt) || other.emulatedCreatedAt == emulatedCreatedAt)&&(identical(other.rank, rank) || other.rank == rank)&&(identical(other.askedCount, askedCount) || other.askedCount == askedCount)&&(identical(other.wronglyAnsweredCount, wronglyAnsweredCount) || other.wronglyAnsweredCount == wronglyAnsweredCount)&&(identical(other.wrongness, wrongness) || other.wrongness == wrongness));
}


@override
int get hashCode => Object.hash(runtimeType,id,fieldListId,answer,question,creationAt,lastModificationAt,order,didAskedAtCurrentTestRound,emulatedCreatedAt,rank,askedCount,wronglyAnsweredCount,wrongness);

@override
String toString() {
  return 'EntryEntity(id: $id, fieldListId: $fieldListId, answer: $answer, question: $question, creationAt: $creationAt, lastModificationAt: $lastModificationAt, order: $order, didAskedAtCurrentTestRound: $didAskedAtCurrentTestRound, emulatedCreatedAt: $emulatedCreatedAt, rank: $rank, askedCount: $askedCount, wronglyAnsweredCount: $wronglyAnsweredCount, wrongness: $wrongness)';
}


}

/// @nodoc
abstract mixin class _$EntryEntityCopyWith<$Res> implements $EntryEntityCopyWith<$Res> {
  factory _$EntryEntityCopyWith(_EntryEntity value, $Res Function(_EntryEntity) _then) = __$EntryEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String fieldListId, String answer, String question, DateTime creationAt, DateTime lastModificationAt, int order, bool didAskedAtCurrentTestRound, DateTime? emulatedCreatedAt, Rank rank, int askedCount, int wronglyAnsweredCount, double wrongness
});




}
/// @nodoc
class __$EntryEntityCopyWithImpl<$Res>
    implements _$EntryEntityCopyWith<$Res> {
  __$EntryEntityCopyWithImpl(this._self, this._then);

  final _EntryEntity _self;
  final $Res Function(_EntryEntity) _then;

/// Create a copy of EntryEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? fieldListId = null,Object? answer = null,Object? question = null,Object? creationAt = null,Object? lastModificationAt = null,Object? order = null,Object? didAskedAtCurrentTestRound = null,Object? emulatedCreatedAt = freezed,Object? rank = null,Object? askedCount = null,Object? wronglyAnsweredCount = null,Object? wrongness = null,}) {
  return _then(_EntryEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fieldListId: null == fieldListId ? _self.fieldListId : fieldListId // ignore: cast_nullable_to_non_nullable
as String,answer: null == answer ? _self.answer : answer // ignore: cast_nullable_to_non_nullable
as String,question: null == question ? _self.question : question // ignore: cast_nullable_to_non_nullable
as String,creationAt: null == creationAt ? _self.creationAt : creationAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastModificationAt: null == lastModificationAt ? _self.lastModificationAt : lastModificationAt // ignore: cast_nullable_to_non_nullable
as DateTime,order: null == order ? _self.order : order // ignore: cast_nullable_to_non_nullable
as int,didAskedAtCurrentTestRound: null == didAskedAtCurrentTestRound ? _self.didAskedAtCurrentTestRound : didAskedAtCurrentTestRound // ignore: cast_nullable_to_non_nullable
as bool,emulatedCreatedAt: freezed == emulatedCreatedAt ? _self.emulatedCreatedAt : emulatedCreatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,rank: null == rank ? _self.rank : rank // ignore: cast_nullable_to_non_nullable
as Rank,askedCount: null == askedCount ? _self.askedCount : askedCount // ignore: cast_nullable_to_non_nullable
as int,wronglyAnsweredCount: null == wronglyAnsweredCount ? _self.wronglyAnsweredCount : wronglyAnsweredCount // ignore: cast_nullable_to_non_nullable
as int,wrongness: null == wrongness ? _self.wrongness : wrongness // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
