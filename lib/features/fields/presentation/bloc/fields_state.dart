import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/models/field_entity.dart';

part 'fields_state.freezed.dart';

enum FieldsStatus { initial, loading, success, failure }

@freezed
abstract class FieldsState with _$FieldsState {
  const factory FieldsState([
    @Default(FieldsStatus.initial) FieldsStatus status,
    @Default([]) List<(FieldEntity, int)> fieldsWithFieldListsCount,
  ]) = _FieldsState;
}
