import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';

void main() {
  DateTime creationAt = DateTime(2020, 1, 1);
  final userAccountId = 'wohfgowe';
  late String name;
  final usageCount = 0;
  int color = 0xff520404;
  test('FieldEntity throws AssertionError when created with invalid name', () {
    name = "";
    expect(
        () => FieldEntity(null, userAccountId, name, creationAt, creationAt,
            usageCount, color),
        throwsA(predicate((e) =>
            e is AssertionError &&
            e.message == 'Field name must be between 1 and 64 characters')));
  });
}
