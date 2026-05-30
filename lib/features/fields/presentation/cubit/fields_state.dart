import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../common/state_status.dart';
import '../../domain/models/field_entity.dart';

part 'fields_state.freezed.dart';

@freezed
abstract class FieldsState with _$FieldsState {
  const factory FieldsState([
    @Default(StateStatus.loading) StateStatus fieldsStateStatus,
    @Default([]) List<(FieldEntity, int)> fieldsWithFieldListsCount,
  ]) = _FieldsState;
}
