import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/field_list_notes/presentation/bloc/field_list_notes_event.dart';

void main() {
  test('test equality', () {
    expect(
      FieldListNotesSubscriptionRequested('f'),
      FieldListNotesSubscriptionRequested('f'),
    );
    expect(
      FieldListNotesSubscriptionRequested('f'),
      isNot(FieldListNotesSubscriptionRequested('fwe')),
    );
  });
}
