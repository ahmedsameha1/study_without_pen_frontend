import 'package:study_without_pen_by_flutter/domain_model/has_id.dart';

abstract class Note extends HasId {
  Note(String uuid) : super(uuid);
}

class FieldNote extends Note {
  FieldNote(String uuid) : super(uuid);
}
