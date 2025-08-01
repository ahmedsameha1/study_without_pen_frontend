import 'package:freezed_annotation/freezed_annotation.dart';

part 'field_lists_state.freezed.dart';

enum FieldListsStatus { initial, loading, success, failure }

@freezed
abstract class FieldListsState with _$FieldListsState {
  const factory FieldListsState(
      [@Default(FieldListsStatus.initial) FieldListsStatus status,
      @Default('') String fieldName]) = _FieldListsState;
}
