import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_event.dart';

void main() {
  test('Supports value equality', () {
    expect(ChangeEntry(3), ChangeEntry(3));
    expect(ChangeEntry(3), isNot(ChangeEntry(5)));
    expect(ChangeTab(0), ChangeTab(0));
    expect(ChangeTab(1), isNot(ChangeTab(0)));
    expect(ChangeUserAnswer('hi'), ChangeUserAnswer('hi'));
    expect(ChangeUserAnswer('hello'), isNot(ChangeUserAnswer('hi')));
  });
}
