import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';

part 'entries_page_data.freezed.dart';

@freezed
abstract class EntriesPageData with _$EntriesPageData {
  const factory EntriesPageData({
    required FieldListEntity fieldList,
    required List<EntryEntity> entries,
  }) = _EntriesPageData;
}
