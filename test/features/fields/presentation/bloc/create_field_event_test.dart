import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/create_field_event.dart';

void main() {
  test('test equality', () {
    expect(
      const CreateFieldNameChanged('hi'),
      const CreateFieldNameChanged('hi'),
    );
    expect(
      const CreateFieldNameChanged('hi'),
      isNot(const CreateFieldNameChanged('hello')),
    );
    expect(
      const CreateFieldColorChanged(55),
      const CreateFieldColorChanged(55),
    );
    expect(
      const CreateFieldColorChanged(55),
      isNot(const CreateFieldColorChanged(66)),
    );
    expect(const CreateFieldSubmitted(), const CreateFieldSubmitted());
  });
}
