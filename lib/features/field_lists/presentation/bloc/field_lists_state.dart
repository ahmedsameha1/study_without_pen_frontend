import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_lists_page_data.dart';

part 'field_lists_state.freezed.dart';

enum FieldListsStatus { initial, loading, success, failure }

@freezed
abstract class FieldListsState with _$FieldListsState {
  const factory FieldListsState(
      {@Default(FieldListsStatus.initial) FieldListsStatus status,
      FieldListsPageData? fieldListsPageData}) = _FieldListsState;
}
