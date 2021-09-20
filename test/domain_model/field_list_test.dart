import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/field_list.dart';
import 'package:uuid/uuid.dart';

main() {
  final uuid = Uuid();
  group("_id tests", () {
    test("_id is a valid UUID", () {
      expect(() => FieldList(""), throwsArgumentError);
      expect(() => FieldList("whfw"), throwsArgumentError);
      expect(() => FieldList(uuid.v4()), returnsNormally);
    });
    test("_id has been assigned the correct value", () {
      String uuidString = uuid.v4();
      final fieldList = FieldList(uuidString);
      final id = fieldList.id;
      expect(uuidString, id);
    });
  });
}
