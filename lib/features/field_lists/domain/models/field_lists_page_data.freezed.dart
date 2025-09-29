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
  String? get fieldName;
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
            (identical(other.fieldName, fieldName) ||
                other.fieldName == fieldName) &&
            const DeepCollectionEquality()
                .equals(other.fieldLists, fieldLists));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, fieldName, const DeepCollectionEquality().hash(fieldLists));

  @override
  String toString() {
    return 'FieldListsPageData(fieldName: $fieldName, fieldLists: $fieldLists)';
  }
}

/// @nodoc
abstract mixin class $FieldListsPageDataCopyWith<$Res> {
  factory $FieldListsPageDataCopyWith(
          FieldListsPageData value, $Res Function(FieldListsPageData) _then) =
      _$FieldListsPageDataCopyWithImpl;
  @useResult
  $Res call({String? fieldName, List<FieldListEntity> fieldLists});
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
    Object? fieldName = freezed,
    Object? fieldLists = null,
  }) {
    return _then(_self.copyWith(
      fieldName: freezed == fieldName
          ? _self.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldLists: null == fieldLists
          ? _self.fieldLists
          : fieldLists // ignore: cast_nullable_to_non_nullable
              as List<FieldListEntity>,
    ));
  }
}

/// @nodoc

class _FieldListsPageData implements FieldListsPageData {
  const _FieldListsPageData(
      {this.fieldName, required final List<FieldListEntity> fieldLists})
      : _fieldLists = fieldLists;

  @override
  final String? fieldName;
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
            (identical(other.fieldName, fieldName) ||
                other.fieldName == fieldName) &&
            const DeepCollectionEquality()
                .equals(other._fieldLists, _fieldLists));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, fieldName, const DeepCollectionEquality().hash(_fieldLists));

  @override
  String toString() {
    return 'FieldListsPageData(fieldName: $fieldName, fieldLists: $fieldLists)';
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
  $Res call({String? fieldName, List<FieldListEntity> fieldLists});
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
    Object? fieldName = freezed,
    Object? fieldLists = null,
  }) {
    return _then(_FieldListsPageData(
      fieldName: freezed == fieldName
          ? _self.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String?,
      fieldLists: null == fieldLists
          ? _self._fieldLists
          : fieldLists // ignore: cast_nullable_to_non_nullable
              as List<FieldListEntity>,
    ));
  }
}

// dart format on
