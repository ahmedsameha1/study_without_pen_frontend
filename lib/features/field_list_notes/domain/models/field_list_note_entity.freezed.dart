// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_list_note_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FieldListNoteEntity {

 String get text; DateTime get creationAt; DateTime get lastModificationAt; String? get id; String get fieldListId;
/// Create a copy of FieldListNoteEntity
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FieldListNoteEntityCopyWith<FieldListNoteEntity> get copyWith => _$FieldListNoteEntityCopyWithImpl<FieldListNoteEntity>(this as FieldListNoteEntity, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FieldListNoteEntity&&(identical(other.text, text) || other.text == text)&&(identical(other.creationAt, creationAt) || other.creationAt == creationAt)&&(identical(other.lastModificationAt, lastModificationAt) || other.lastModificationAt == lastModificationAt)&&(identical(other.id, id) || other.id == id)&&(identical(other.fieldListId, fieldListId) || other.fieldListId == fieldListId));
}


@override
int get hashCode => Object.hash(runtimeType,text,creationAt,lastModificationAt,id,fieldListId);

@override
String toString() {
  return 'FieldListNoteEntity(text: $text, creationAt: $creationAt, lastModificationAt: $lastModificationAt, id: $id, fieldListId: $fieldListId)';
}


}

/// @nodoc
abstract mixin class $FieldListNoteEntityCopyWith<$Res>  {
  factory $FieldListNoteEntityCopyWith(FieldListNoteEntity value, $Res Function(FieldListNoteEntity) _then) = _$FieldListNoteEntityCopyWithImpl;
@useResult
$Res call({
 String? id, String fieldListId, String text, DateTime creationAt, DateTime lastModificationAt
});




}
/// @nodoc
class _$FieldListNoteEntityCopyWithImpl<$Res>
    implements $FieldListNoteEntityCopyWith<$Res> {
  _$FieldListNoteEntityCopyWithImpl(this._self, this._then);

  final FieldListNoteEntity _self;
  final $Res Function(FieldListNoteEntity) _then;

/// Create a copy of FieldListNoteEntity
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? fieldListId = null,Object? text = null,Object? creationAt = null,Object? lastModificationAt = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fieldListId: null == fieldListId ? _self.fieldListId : fieldListId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,creationAt: null == creationAt ? _self.creationAt : creationAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastModificationAt: null == lastModificationAt ? _self.lastModificationAt : lastModificationAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [FieldListNoteEntity].
extension FieldListNoteEntityPatterns on FieldListNoteEntity {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FieldListNoteEntity value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FieldListNoteEntity() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FieldListNoteEntity value)  $default,){
final _that = this;
switch (_that) {
case _FieldListNoteEntity():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FieldListNoteEntity value)?  $default,){
final _that = this;
switch (_that) {
case _FieldListNoteEntity() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String fieldListId,  String text,  DateTime creationAt,  DateTime lastModificationAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FieldListNoteEntity() when $default != null:
return $default(_that.id,_that.fieldListId,_that.text,_that.creationAt,_that.lastModificationAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String fieldListId,  String text,  DateTime creationAt,  DateTime lastModificationAt)  $default,) {final _that = this;
switch (_that) {
case _FieldListNoteEntity():
return $default(_that.id,_that.fieldListId,_that.text,_that.creationAt,_that.lastModificationAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String fieldListId,  String text,  DateTime creationAt,  DateTime lastModificationAt)?  $default,) {final _that = this;
switch (_that) {
case _FieldListNoteEntity() when $default != null:
return $default(_that.id,_that.fieldListId,_that.text,_that.creationAt,_that.lastModificationAt);case _:
  return null;

}
}

}

/// @nodoc


class _FieldListNoteEntity extends FieldListNoteEntity {
   _FieldListNoteEntity({this.id, required this.fieldListId, required final  String text, required final  DateTime creationAt, required final  DateTime lastModificationAt}): super._(text: text, creationAt: creationAt, lastModificationAt: lastModificationAt);
  

@override final  String? id;
@override final  String fieldListId;

/// Create a copy of FieldListNoteEntity
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FieldListNoteEntityCopyWith<_FieldListNoteEntity> get copyWith => __$FieldListNoteEntityCopyWithImpl<_FieldListNoteEntity>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FieldListNoteEntity&&(identical(other.id, id) || other.id == id)&&(identical(other.fieldListId, fieldListId) || other.fieldListId == fieldListId)&&(identical(other.text, text) || other.text == text)&&(identical(other.creationAt, creationAt) || other.creationAt == creationAt)&&(identical(other.lastModificationAt, lastModificationAt) || other.lastModificationAt == lastModificationAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,fieldListId,text,creationAt,lastModificationAt);

@override
String toString() {
  return 'FieldListNoteEntity(id: $id, fieldListId: $fieldListId, text: $text, creationAt: $creationAt, lastModificationAt: $lastModificationAt)';
}


}

/// @nodoc
abstract mixin class _$FieldListNoteEntityCopyWith<$Res> implements $FieldListNoteEntityCopyWith<$Res> {
  factory _$FieldListNoteEntityCopyWith(_FieldListNoteEntity value, $Res Function(_FieldListNoteEntity) _then) = __$FieldListNoteEntityCopyWithImpl;
@override @useResult
$Res call({
 String? id, String fieldListId, String text, DateTime creationAt, DateTime lastModificationAt
});




}
/// @nodoc
class __$FieldListNoteEntityCopyWithImpl<$Res>
    implements _$FieldListNoteEntityCopyWith<$Res> {
  __$FieldListNoteEntityCopyWithImpl(this._self, this._then);

  final _FieldListNoteEntity _self;
  final $Res Function(_FieldListNoteEntity) _then;

/// Create a copy of FieldListNoteEntity
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? fieldListId = null,Object? text = null,Object? creationAt = null,Object? lastModificationAt = null,}) {
  return _then(_FieldListNoteEntity(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,fieldListId: null == fieldListId ? _self.fieldListId : fieldListId // ignore: cast_nullable_to_non_nullable
as String,text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,creationAt: null == creationAt ? _self.creationAt : creationAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastModificationAt: null == lastModificationAt ? _self.lastModificationAt : lastModificationAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
