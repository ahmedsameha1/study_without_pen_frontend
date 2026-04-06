import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_event.dart';

void main() {
  test('Supports value equality', () {
    expect(ChangeEntry(3), ChangeEntry(3));
    expect(ChangeEntry(3), isNot(ChangeEntry(5)));
  });
}
