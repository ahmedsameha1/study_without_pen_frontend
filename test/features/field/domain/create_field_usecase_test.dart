import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/create_field_usecase.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('throws ArgumentError when there is a validation error', () {
    DateTime creationAt = DateTime(2020, 1, 1);
    final fieldId = const Uuid().v4();
    final name = "";
    int usageCount = 0;
    int color = 0xff520404;
    final usecase = CreateFieldUseCase();
    expect(
        () => usecase.call(fieldId, "wofhwefwe", name, creationAt, creationAt,
            usageCount, color),
        throwsA(predicate((e) =>
            e is ArgumentError && e.message == 'Field name cannot be blank')));
  });
}
