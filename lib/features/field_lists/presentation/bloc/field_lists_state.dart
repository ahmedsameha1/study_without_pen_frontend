import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';

part 'field_lists_state.freezed.dart';

enum FieldListsStatus { initial, loading, success, failure }

@freezed
abstract class FieldListsState with _$FieldListsState {
  const factory FieldListsState(
          {@Default(FieldListsStatus.initial) FieldListsStatus status,
          @Default('') String fieldName,
          @Default(<FieldListEntity>[]) List<FieldListEntity> fieldLists}) =
      _FieldListsState;
}
