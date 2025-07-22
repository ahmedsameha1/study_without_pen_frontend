import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_without_pen_by_flutter/common/state_status.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';

part 'fields_state.freezed.dart';

@freezed
abstract class FieldsState with _$FieldsState {
  const factory FieldsState(
      [@Default(StateStatus.loading) StateStatus fieldsStateStatus,
      @Default([]) List<FieldEntity> fields]) = _FieldsState;
}
