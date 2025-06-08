import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/models/field_entity.dart';

part 'fields_state.freezed.dart';

enum FieldsStateStatus { loading, failure, success }

@freezed
abstract class FieldsState with _$FieldsState {
  const factory FieldsState(
      [@Default(FieldsStateStatus.loading) FieldsStateStatus fieldsStateStatus,
      @Default([]) List<FieldEntity> fields]) = _FieldsState;
}
