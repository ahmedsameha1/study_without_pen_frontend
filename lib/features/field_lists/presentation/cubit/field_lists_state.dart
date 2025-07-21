import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_without_pen_by_flutter/common/state_status.dart';

part 'field_lists_state.freezed.dart';

@freezed
abstract class FieldListsState with _$FieldListsState {
  const factory FieldListsState([@Default(StateStatus.loading) StateStatus stateStatus,
  @Default('') String fieldName]) = _FieldListsState;
}