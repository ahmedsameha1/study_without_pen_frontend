import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/create_entry_event.dart';

void main() {
  test('Supports value equality', () {
    expect(CreateEntryRankChanged(1), CreateEntryRankChanged(1));
    expect(
      CreateEntryQuestionChanged('question'),
      CreateEntryQuestionChanged('question'),
    );
    expect(
      CreateEntryAnswerChanged('answer'),
      CreateEntryAnswerChanged('answer'),
    );
    expect(CreateEntryOrderChanged('10'), CreateEntryOrderChanged('10'));
    expect(CreateEntrySubmitted(), CreateEntrySubmitted());
    expect(
      CreateEntrySubscriptionRequested('fieldListId'),
      CreateEntrySubscriptionRequested('fieldListId'),
    );
  });
}
