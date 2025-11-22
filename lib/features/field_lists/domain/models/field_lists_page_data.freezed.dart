// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_lists_page_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FieldListsPageData {
  FieldEntity? get field;
  List<FieldListEntity> get fieldLists;

  /// Create a copy of FieldListsPageData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FieldListsPageDataCopyWith<FieldListsPageData> get copyWith =>
      _$FieldListsPageDataCopyWithImpl<FieldListsPageData>(
          this as FieldListsPageData, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FieldListsPageData &&
            (identical(other.field, field) || other.field == field) &&
            const DeepCollectionEquality()
                .equals(other.fieldLists, fieldLists));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, field, const DeepCollectionEquality().hash(fieldLists));

  @override
  String toString() {
    return 'FieldListsPageData(field: $field, fieldLists: $fieldLists)';
  }
}

/// @nodoc
abstract mixin class $FieldListsPageDataCopyWith<$Res> {
  factory $FieldListsPageDataCopyWith(
          FieldListsPageData value, $Res Function(FieldListsPageData) _then) =
      _$FieldListsPageDataCopyWithImpl;
  @useResult
  $Res call({FieldEntity? field, List<FieldListEntity> fieldLists});

  $FieldEntityCopyWith<$Res>? get field;
}

/// @nodoc
class _$FieldListsPageDataCopyWithImpl<$Res>
    implements $FieldListsPageDataCopyWith<$Res> {
  _$FieldListsPageDataCopyWithImpl(this._self, this._then);

  final FieldListsPageData _self;
  final $Res Function(FieldListsPageData) _then;

  /// Create a copy of FieldListsPageData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? field = freezed,
    Object? fieldLists = null,
  }) {
    return _then(_self.copyWith(
      field: freezed == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as FieldEntity?,
      fieldLists: null == fieldLists
          ? _self.fieldLists
          : fieldLists // ignore: cast_nullable_to_non_nullable
              as List<FieldListEntity>,
    ));
  }

  /// Create a copy of FieldListsPageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FieldEntityCopyWith<$Res>? get field {
    if (_self.field == null) {
      return null;
    }

    return $FieldEntityCopyWith<$Res>(_self.field!, (value) {
      return _then(_self.copyWith(field: value));
    });
  }
}

/// @nodoc

class _FieldListsPageData implements FieldListsPageData {
  const _FieldListsPageData(
      {this.field, required final List<FieldListEntity> fieldLists})
      : _fieldLists = fieldLists;

  @override
  final FieldEntity? field;
  final List<FieldListEntity> _fieldLists;
  @override
  List<FieldListEntity> get fieldLists {
    if (_fieldLists is EqualUnmodifiableListView) return _fieldLists;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_fieldLists);
  }

  /// Create a copy of FieldListsPageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FieldListsPageDataCopyWith<_FieldListsPageData> get copyWith =>
      __$FieldListsPageDataCopyWithImpl<_FieldListsPageData>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FieldListsPageData &&
            (identical(other.field, field) || other.field == field) &&
            const DeepCollectionEquality()
                .equals(other._fieldLists, _fieldLists));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, field, const DeepCollectionEquality().hash(_fieldLists));

  @override
  String toString() {
    return 'FieldListsPageData(field: $field, fieldLists: $fieldLists)';
  }
}

/// @nodoc
abstract mixin class _$FieldListsPageDataCopyWith<$Res>
    implements $FieldListsPageDataCopyWith<$Res> {
  factory _$FieldListsPageDataCopyWith(
          _FieldListsPageData value, $Res Function(_FieldListsPageData) _then) =
      __$FieldListsPageDataCopyWithImpl;
  @override
  @useResult
  $Res call({FieldEntity? field, List<FieldListEntity> fieldLists});

  @override
  $FieldEntityCopyWith<$Res>? get field;
}

/// @nodoc
class __$FieldListsPageDataCopyWithImpl<$Res>
    implements _$FieldListsPageDataCopyWith<$Res> {
  __$FieldListsPageDataCopyWithImpl(this._self, this._then);

  final _FieldListsPageData _self;
  final $Res Function(_FieldListsPageData) _then;

  /// Create a copy of FieldListsPageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? field = freezed,
    Object? fieldLists = null,
  }) {
    return _then(_FieldListsPageData(
      field: freezed == field
          ? _self.field
          : field // ignore: cast_nullable_to_non_nullable
              as FieldEntity?,
      fieldLists: null == fieldLists
          ? _self._fieldLists
          : fieldLists // ignore: cast_nullable_to_non_nullable
              as List<FieldListEntity>,
    ));
  }

  /// Create a copy of FieldListsPageData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FieldEntityCopyWith<$Res>? get field {
    if (_self.field == null) {
      return null;
    }

    return $FieldEntityCopyWith<$Res>(_self.field!, (value) {
      return _then(_self.copyWith(field: value));
    });
  }
}

// dart format on
