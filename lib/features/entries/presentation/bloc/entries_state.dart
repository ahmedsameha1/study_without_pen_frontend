import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entries_page_data.dart';

part 'entries_state.freezed.dart';

enum EntriesStatus { initial, loading, success, failure }

@freezed
abstract class EntriesState with _$EntriesState {
  const factory EntriesState({
    @Default(EntriesStatus.initial) EntriesStatus status,
    EntriesPageData? entriesPageData,
  }) = _EntriesState;
}
