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
  StateStatus get stateStatus;
  String get fieldName;

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
            (identical(other.stateStatus, stateStatus) ||
                other.stateStatus == stateStatus) &&
            (identical(other.fieldName, fieldName) ||
                other.fieldName == fieldName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stateStatus, fieldName);

  @override
  String toString() {
    return 'FieldListsState(stateStatus: $stateStatus, fieldName: $fieldName)';
  }
}

/// @nodoc
abstract mixin class $FieldListsStateCopyWith<$Res> {
  factory $FieldListsStateCopyWith(
          FieldListsState value, $Res Function(FieldListsState) _then) =
      _$FieldListsStateCopyWithImpl;
  @useResult
  $Res call({StateStatus stateStatus, String fieldName});
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
    Object? stateStatus = null,
    Object? fieldName = null,
  }) {
    return _then(_self.copyWith(
      stateStatus: null == stateStatus
          ? _self.stateStatus
          : stateStatus // ignore: cast_nullable_to_non_nullable
              as StateStatus,
      fieldName: null == fieldName
          ? _self.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _FieldListsState implements FieldListsState {
  const _FieldListsState(
      [this.stateStatus = StateStatus.loading, this.fieldName = '']);

  @override
  @JsonKey()
  final StateStatus stateStatus;
  @override
  @JsonKey()
  final String fieldName;

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
            (identical(other.stateStatus, stateStatus) ||
                other.stateStatus == stateStatus) &&
            (identical(other.fieldName, fieldName) ||
                other.fieldName == fieldName));
  }

  @override
  int get hashCode => Object.hash(runtimeType, stateStatus, fieldName);

  @override
  String toString() {
    return 'FieldListsState(stateStatus: $stateStatus, fieldName: $fieldName)';
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
  $Res call({StateStatus stateStatus, String fieldName});
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
    Object? stateStatus = null,
    Object? fieldName = null,
  }) {
    return _then(_FieldListsState(
      null == stateStatus
          ? _self.stateStatus
          : stateStatus // ignore: cast_nullable_to_non_nullable
              as StateStatus,
      null == fieldName
          ? _self.fieldName
          : fieldName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

// dart format on
