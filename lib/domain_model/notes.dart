import 'package:clock/clock.dart';
import 'package:study_without_pen_by_flutter/domain_model/so_basic.dart';

abstract class Note extends HasRelationalId with ModificationTimeRecord {
  late String _text;
  // TODO Do we need last modification at or last fetch time
  Note(String uuid, String text, String relationalId)
      : super(uuid, relationalId) {
    /////////////////////////////////////////////////////////////////////////
    // _text validation
    if (text.isEmpty) {
      throw ArgumentError("_text cannot be an empty String");
    }
    _text = text;
  }

  String get text => _text;

  set text(String text) {
    /////////////////////////////////////////////////////////////////////////
    // _text validation
    if (text.isEmpty) {
      throw ArgumentError("_text cannot be an empty String");
    }
    _text = text;
    lastModifiedAt = clock.now();
  }
}

class FieldNote extends Note {
  FieldNote(String uuid, String text, String fieldId)
      : super(uuid, text, fieldId);

  String get fieldId => relationalId;
}

class FieldListNote extends Note {
  FieldListNote(String uuid, String text, String fieldListId)
      : super(uuid, text, fieldListId);

  String get fieldListId => relationalId;
}
