import 'package:study_without_pen_by_flutter/domain_model/has_id.dart';

abstract class Note extends HasId {
  late String _text;
  // TODO Do we need last modification at or last fetch time
  Note(String uuid, String text) : super(uuid) {
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
  }
}

class FieldNote extends Note {
  FieldNote(String uuid, String text) : super(uuid, text);
}
