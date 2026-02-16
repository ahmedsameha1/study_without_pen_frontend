import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/entries_event.dart';
import 'package:uuid/uuid.dart';

void main() {
  test('Supports value equality', () {
    String fieldListId = const Uuid().v4();
    expect(
      EntriesSubscriptionRequested(fieldListId),
      EntriesSubscriptionRequested(fieldListId),
    );
    expect(const PrepareTab(1), const PrepareTab(1));
  });
}
