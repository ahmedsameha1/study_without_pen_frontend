// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field_lists_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FieldListsState {
  FieldListsStatus get status;
  FieldListsPageData? get fieldListsPageData;

  /// Create a copy of FieldListsState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $FieldListsStateCopyWith<FieldListsState> get copyWith =>
      _$FieldListsStateCopyWithImpl<FieldListsState>(
          this as FieldListsState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is FieldListsState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.fieldListsPageData, fieldListsPageData) ||
                other.fieldListsPageData == fieldListsPageData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, fieldListsPageData);

  @override
  String toString() {
    return 'FieldListsState(status: $status, fieldListsPageData: $fieldListsPageData)';
  }
}

/// @nodoc
abstract mixin class $FieldListsStateCopyWith<$Res> {
  factory $FieldListsStateCopyWith(
          FieldListsState value, $Res Function(FieldListsState) _then) =
      _$FieldListsStateCopyWithImpl;
  @useResult
  $Res call({FieldListsStatus status, FieldListsPageData? fieldListsPageData});

  $FieldListsPageDataCopyWith<$Res>? get fieldListsPageData;
}

/// @nodoc
class _$FieldListsStateCopyWithImpl<$Res>
    implements $FieldListsStateCopyWith<$Res> {
  _$FieldListsStateCopyWithImpl(this._self, this._then);

  final FieldListsState _self;
  final $Res Function(FieldListsState) _then;

  /// Create a copy of FieldListsState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? fieldListsPageData = freezed,
  }) {
    return _then(_self.copyWith(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as FieldListsStatus,
      fieldListsPageData: freezed == fieldListsPageData
          ? _self.fieldListsPageData
          : fieldListsPageData // ignore: cast_nullable_to_non_nullable
              as FieldListsPageData?,
    ));
  }

  /// Create a copy of FieldListsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FieldListsPageDataCopyWith<$Res>? get fieldListsPageData {
    if (_self.fieldListsPageData == null) {
      return null;
    }

    return $FieldListsPageDataCopyWith<$Res>(_self.fieldListsPageData!,
        (value) {
      return _then(_self.copyWith(fieldListsPageData: value));
    });
  }
}

/// @nodoc

class _FieldListsState implements FieldListsState {
  const _FieldListsState(
      {this.status = FieldListsStatus.initial, this.fieldListsPageData});

  @override
  @JsonKey()
  final FieldListsStatus status;
  @override
  final FieldListsPageData? fieldListsPageData;

  /// Create a copy of FieldListsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$FieldListsStateCopyWith<_FieldListsState> get copyWith =>
      __$FieldListsStateCopyWithImpl<_FieldListsState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _FieldListsState &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.fieldListsPageData, fieldListsPageData) ||
                other.fieldListsPageData == fieldListsPageData));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, fieldListsPageData);

  @override
  String toString() {
    return 'FieldListsState(status: $status, fieldListsPageData: $fieldListsPageData)';
  }
}

/// @nodoc
abstract mixin class _$FieldListsStateCopyWith<$Res>
    implements $FieldListsStateCopyWith<$Res> {
  factory _$FieldListsStateCopyWith(
          _FieldListsState value, $Res Function(_FieldListsState) _then) =
      __$FieldListsStateCopyWithImpl;
  @override
  @useResult
  $Res call({FieldListsStatus status, FieldListsPageData? fieldListsPageData});

  @override
  $FieldListsPageDataCopyWith<$Res>? get fieldListsPageData;
}

/// @nodoc
class __$FieldListsStateCopyWithImpl<$Res>
    implements _$FieldListsStateCopyWith<$Res> {
  __$FieldListsStateCopyWithImpl(this._self, this._then);

  final _FieldListsState _self;
  final $Res Function(_FieldListsState) _then;

  /// Create a copy of FieldListsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? status = null,
    Object? fieldListsPageData = freezed,
  }) {
    return _then(_FieldListsState(
      status: null == status
          ? _self.status
          : status // ignore: cast_nullable_to_non_nullable
              as FieldListsStatus,
      fieldListsPageData: freezed == fieldListsPageData
          ? _self.fieldListsPageData
          : fieldListsPageData // ignore: cast_nullable_to_non_nullable
              as FieldListsPageData?,
    ));
  }

  /// Create a copy of FieldListsState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $FieldListsPageDataCopyWith<$Res>? get fieldListsPageData {
    if (_self.fieldListsPageData == null) {
      return null;
    }

    return $FieldListsPageDataCopyWith<$Res>(_self.fieldListsPageData!,
        (value) {
      return _then(_self.copyWith(fieldListsPageData: value));
    });
  }
}

// dart format on
