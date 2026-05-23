import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../field_lists/domain/models/field_list_entity.dart';
import 'field_list_note_entity.dart';

part 'field_list_notes_page_data.freezed.dart';

@freezed
abstract class FieldListNotesPageData with _$FieldListNotesPageData{
  const factory FieldListNotesPageData({
    required FieldListEntity fieldList,
    required List<FieldListNoteEntity> fieldListNotes,
  })= _FieldListNotesPageData;
}