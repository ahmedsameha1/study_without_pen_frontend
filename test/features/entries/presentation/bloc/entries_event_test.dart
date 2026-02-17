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
    expect(PrepareTab(1, DateTime(2025)), PrepareTab(1, DateTime(2025)));
    expect(PrepareTab(1, DateTime(2025)), isNot(PrepareTab(1, DateTime(2024))));
  });
}
