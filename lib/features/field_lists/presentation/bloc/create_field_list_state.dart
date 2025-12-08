import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';

part 'create_field_list_state.freezed.dart';

enum CreateFieldListStatus { initial, loading, success, failure }

@freezed
abstract class CreateFieldListState with _$CreateFieldListState {
  const factory CreateFieldListState({
    @Default(CreateFieldListStatus.initial) CreateFieldListStatus status,
    @Default('') String name,
    @Default(CheckType.NON_STRICT_IGNORE_CASE) CheckType checkType,
    @Default(false) bool readAnswer,
    @Default(4294967295) int color,
  }) = _CreateFieldListState;
}
