import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';

part 'create_entry_state.freezed.dart';

enum CreateEntryStatus {
  initial,
  loading,
  success,
  failure,
  duplicationFailure,
}

@freezed
abstract class CreateEntryState with _$CreateEntryState {
  const factory CreateEntryState({
    @Default(CreateEntryStatus.loading) CreateEntryStatus status,
    @Default('') String question,
    @Default('') String answer,
    @Default('') String order,
    @Default(1) int rank,
    FieldListEntity? fieldList,
  }) = _CreateEntryState;
}
