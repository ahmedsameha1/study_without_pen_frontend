// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tab_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TabData {

 String get name; String get description; TabDataStatus get status; bool get outdated; List<EntryEntity> get entries;
/// Create a copy of TabData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TabDataCopyWith<TabData> get copyWith => _$TabDataCopyWithImpl<TabData>(this as TabData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TabData&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.outdated, outdated) || other.outdated == outdated)&&const DeepCollectionEquality().equals(other.entries, entries));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,status,outdated,const DeepCollectionEquality().hash(entries));

@override
String toString() {
  return 'TabData(name: $name, description: $description, status: $status, outdated: $outdated, entries: $entries)';
}


}

/// @nodoc
abstract mixin class $TabDataCopyWith<$Res>  {
  factory $TabDataCopyWith(TabData value, $Res Function(TabData) _then) = _$TabDataCopyWithImpl;
@useResult
$Res call({
 String name, String description, TabDataStatus status, bool outdated, List<EntryEntity> entries
});




}
/// @nodoc
class _$TabDataCopyWithImpl<$Res>
    implements $TabDataCopyWith<$Res> {
  _$TabDataCopyWithImpl(this._self, this._then);

  final TabData _self;
  final $Res Function(TabData) _then;

/// Create a copy of TabData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? description = null,Object? status = null,Object? outdated = null,Object? entries = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TabDataStatus,outdated: null == outdated ? _self.outdated : outdated // ignore: cast_nullable_to_non_nullable
as bool,entries: null == entries ? _self.entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryEntity>,
  ));
}

}


/// Adds pattern-matching-related methods to [TabData].
extension TabDataPatterns on TabData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TabData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TabData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TabData value)  $default,){
final _that = this;
switch (_that) {
case _TabData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TabData value)?  $default,){
final _that = this;
switch (_that) {
case _TabData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String description,  TabDataStatus status,  bool outdated,  List<EntryEntity> entries)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TabData() when $default != null:
return $default(_that.name,_that.description,_that.status,_that.outdated,_that.entries);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String description,  TabDataStatus status,  bool outdated,  List<EntryEntity> entries)  $default,) {final _that = this;
switch (_that) {
case _TabData():
return $default(_that.name,_that.description,_that.status,_that.outdated,_that.entries);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String description,  TabDataStatus status,  bool outdated,  List<EntryEntity> entries)?  $default,) {final _that = this;
switch (_that) {
case _TabData() when $default != null:
return $default(_that.name,_that.description,_that.status,_that.outdated,_that.entries);case _:
  return null;

}
}

}

/// @nodoc


class _TabData implements TabData {
  const _TabData({required this.name, required this.description, this.status = TabDataStatus.loading, this.outdated = true, final  List<EntryEntity> entries = const []}): _entries = entries;
  

@override final  String name;
@override final  String description;
@override@JsonKey() final  TabDataStatus status;
@override@JsonKey() final  bool outdated;
 final  List<EntryEntity> _entries;
@override@JsonKey() List<EntryEntity> get entries {
  if (_entries is EqualUnmodifiableListView) return _entries;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_entries);
}


/// Create a copy of TabData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TabDataCopyWith<_TabData> get copyWith => __$TabDataCopyWithImpl<_TabData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TabData&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.status, status) || other.status == status)&&(identical(other.outdated, outdated) || other.outdated == outdated)&&const DeepCollectionEquality().equals(other._entries, _entries));
}


@override
int get hashCode => Object.hash(runtimeType,name,description,status,outdated,const DeepCollectionEquality().hash(_entries));

@override
String toString() {
  return 'TabData(name: $name, description: $description, status: $status, outdated: $outdated, entries: $entries)';
}


}

/// @nodoc
abstract mixin class _$TabDataCopyWith<$Res> implements $TabDataCopyWith<$Res> {
  factory _$TabDataCopyWith(_TabData value, $Res Function(_TabData) _then) = __$TabDataCopyWithImpl;
@override @useResult
$Res call({
 String name, String description, TabDataStatus status, bool outdated, List<EntryEntity> entries
});




}
/// @nodoc
class __$TabDataCopyWithImpl<$Res>
    implements _$TabDataCopyWith<$Res> {
  __$TabDataCopyWithImpl(this._self, this._then);

  final _TabData _self;
  final $Res Function(_TabData) _then;

/// Create a copy of TabData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? description = null,Object? status = null,Object? outdated = null,Object? entries = null,}) {
  return _then(_TabData(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TabDataStatus,outdated: null == outdated ? _self.outdated : outdated // ignore: cast_nullable_to_non_nullable
as bool,entries: null == entries ? _self._entries : entries // ignore: cast_nullable_to_non_nullable
as List<EntryEntity>,
  ));
}


}

// dart format on
