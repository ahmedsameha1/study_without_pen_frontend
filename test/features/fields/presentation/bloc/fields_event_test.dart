import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/fields_event.dart';

void main() {
  test('Supports value equality', () {
    expect(
      FieldsSubscriptionRequested('hi'),
      FieldsSubscriptionRequested('hi'),
    );
    expect(
      FieldsSubscriptionRequested('hi'),
      isNot(FieldsSubscriptionRequested('hello')),
    );
    expect(DeleteField('hi'), DeleteField('hi'));
    expect(DeleteField('hi'), isNot(DeleteField('hello')));
  });
}
