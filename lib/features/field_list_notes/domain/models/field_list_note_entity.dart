import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../database/app_database.dart';

part 'field_list_note_entity.freezed.dart';

@freezed
abstract class FieldListNoteEntity with _$FieldListNoteEntity {
  FieldListNoteEntity._({
    required this.text,
    required this.creationAt,
    required this.lastModificationAt,
  }) : assert(
         text.trim().length > FieldListNotes.MINIMUM_LENGTH_OF_TEXT &&
             text.length < FieldListNotes.MAXIMUM_LENGTH_OF_TEXT,
         'text must be between ${FieldListNotes.MAXIMUM_LENGTH_OF_TEXT} and ${FieldListNotes.MAXIMUM_LENGTH_OF_TEXT} characters',
       ),
       assert(
         lastModificationAt.isAtSameMomentAs(creationAt) ||
             lastModificationAt.isAfter(creationAt),
         'lastModification cannot be before creationAt',
       );
  factory FieldListNoteEntity({
    String? id,
    required String fieldListId,
    required String text,
    required DateTime creationAt,
    required DateTime lastModificationAt,
  }) = _FieldListNoteEntity;
  @override
  final String text;
  @override
  final DateTime creationAt;
  @override
  final DateTime lastModificationAt;
}
