import 'package:study_without_pen_by_flutter/domain_model/has_id.dart';

abstract class Test extends HasId {
  late String _fieldListId;
  Test(String uuid, String fieldListId): super(uuid) {
    final regexp = RegExp(
        "[0-9a-fA-F]{8}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{4}\-[0-9a-fA-F]{12}");
    /////////////////////////////////////////////////////////////////////////
    // _fieldListId validation
    if (!regexp.hasMatch(fieldListId)) {
      throw ArgumentError("_fieldListId must be a valid UUID");
    }
    this._fieldListId = fieldListId;
  }

  String get fieldListId => _fieldListId;
}