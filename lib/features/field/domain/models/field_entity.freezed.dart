// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FieldEntity {
  String get name;
  String? get id;
  String get userAccountId;
  DateTime get creationAt;
  DateTime get lastModificationAt;
  int get usageCount;
  int get color;

  /// Create a copy of FieldEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FieldEntityCopyWith<FieldEntity> get copyWith =>
      _$FieldEntityCopyWithImpl<FieldEntity>(this as FieldEntity, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FieldEntity &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userAccountId, userAccountId) ||
                other.userAccountId == userAccountId) &&
            (identical(other.creationAt, creationAt) ||
                other.creationAt == creationAt) &&
            (identical(other.lastModificationAt, lastModificationAt) ||
                other.lastModificationAt == lastModificationAt) &&
            (identical(other.usageCount, usageCount) ||
                other.usageCount == usageCount) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, name, id, userAccountId,
      creationAt, lastModificationAt, usageCount, color);

  @override
  String toString() {
    return 'FieldEntity(name: $name, id: $id, userAccountId: $userAccountId, creationAt: $creationAt, lastModificationAt: $lastModificationAt, usageCount: $usageCount, color: $color)';
  }
}

/// @nodoc
abstract mixin class $FieldEntityCopyWith<$Res> {
  factory $FieldEntityCopyWith(
          FieldEntity value, $Res Function(FieldEntity) _then) =
      _$FieldEntityCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      String userAccountId,
      String name,
      DateTime creationAt,
      DateTime lastModificationAt,
      int usageCount,
      int color});
}

/// @nodoc
class _$FieldEntityCopyWithImpl<$Res> implements $FieldEntityCopyWith<$Res> {
  _$FieldEntityCopyWithImpl(this._self, this._then);

  final FieldEntity _self;
  final $Res Function(FieldEntity) _then;

  /// Create a copy of FieldEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? userAccountId = null,
    Object? name = null,
    Object? creationAt = null,
    Object? lastModificationAt = null,
    Object? usageCount = null,
    Object? color = null,
  }) {
    return _then(_self.copyWith(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      userAccountId: null == userAccountId
          ? _self.userAccountId
          : userAccountId // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      creationAt: null == creationAt
          ? _self.creationAt
          : creationAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      lastModificationAt: null == lastModificationAt
          ? _self.lastModificationAt
          : lastModificationAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      usageCount: null == usageCount
          ? _self.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int,
      color: null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc

class _FieldEntity extends FieldEntity {
  _FieldEntity(this.id, this.userAccountId, final String name, this.creationAt,
      this.lastModificationAt, this.usageCount, this.color)
      : super._(name);

  @override
  final String? id;
  @override
  final String userAccountId;
  @override
  final DateTime creationAt;
  @override
  final DateTime lastModificationAt;
  @override
  final int usageCount;
  @override
  final int color;

  /// Create a copy of FieldEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FieldEntityCopyWith<_FieldEntity> get copyWith =>
      __$FieldEntityCopyWithImpl<_FieldEntity>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FieldEntity &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userAccountId, userAccountId) ||
                other.userAccountId == userAccountId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.creationAt, creationAt) ||
                other.creationAt == creationAt) &&
            (identical(other.lastModificationAt, lastModificationAt) ||
                other.lastModificationAt == lastModificationAt) &&
            (identical(other.usageCount, usageCount) ||
                other.usageCount == usageCount) &&
            (identical(other.color, color) || other.color == color));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, userAccountId, name,
      creationAt, lastModificationAt, usageCount, color);

  @override
  String toString() {
    return 'FieldEntity(id: $id, userAccountId: $userAccountId, name: $name, creationAt: $creationAt, lastModificationAt: $lastModificationAt, usageCount: $usageCount, color: $color)';
  }
}

/// @nodoc
abstract mixin class _$FieldEntityCopyWith<$Res>
    implements $FieldEntityCopyWith<$Res> {
  factory _$FieldEntityCopyWith(
          _FieldEntity value, $Res Function(_FieldEntity) _then) =
      __$FieldEntityCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String userAccountId,
      String name,
      DateTime creationAt,
      DateTime lastModificationAt,
      int usageCount,
      int color});
}

/// @nodoc
class __$FieldEntityCopyWithImpl<$Res> implements _$FieldEntityCopyWith<$Res> {
  __$FieldEntityCopyWithImpl(this._self, this._then);

  final _FieldEntity _self;
  final $Res Function(_FieldEntity) _then;

  /// Create a copy of FieldEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? userAccountId = null,
    Object? name = null,
    Object? creationAt = null,
    Object? lastModificationAt = null,
    Object? usageCount = null,
    Object? color = null,
  }) {
    return _then(_FieldEntity(
      freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      null == userAccountId
          ? _self.userAccountId
          : userAccountId // ignore: cast_nullable_to_non_nullable
              as String,
      null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      null == creationAt
          ? _self.creationAt
          : creationAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == lastModificationAt
          ? _self.lastModificationAt
          : lastModificationAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == usageCount
          ? _self.usageCount
          : usageCount // ignore: cast_nullable_to_non_nullable
              as int,
      null == color
          ? _self.color
          : color // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

// dart format on
