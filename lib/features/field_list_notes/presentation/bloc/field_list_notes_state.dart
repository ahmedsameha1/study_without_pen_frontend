import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/models/field_list_note_entity.dart';

part 'field_list_notes_state.freezed.dart';

enum FieldListNotesStatus { initial, loading, success, failure }

@freezed
abstract class FieldListNotesState with _$FieldListNotesState {
  const factory FieldListNotesState({
    @Default(FieldListNotesStatus.initial) FieldListNotesStatus status,
    @Default([]) List<FieldListNoteEntity> fieldListNotes,
  }) = _FieldListNotesState;
}
