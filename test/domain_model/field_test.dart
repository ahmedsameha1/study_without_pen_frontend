import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/domain_model/field.dart';
import 'package:uuid/uuid.dart';

main() {
  group("_id tests", () {
    test("_id is a valid UUID", () {
      final uuid = Uuid();
      expect(() => Field(""), throwsArgumentError);
      expect(() => Field("whfw"), throwsArgumentError);
      expect(() => Field(uuid.v4()), returnsNormally);
    });

    test("_id has been assigned the correct value", () {
      Uuid uuid = Uuid();
      String uuidString = uuid.v4();
      final field = Field(uuidString);
      final id = field.id;
      expect(uuidString, id);
    });
  });
}
