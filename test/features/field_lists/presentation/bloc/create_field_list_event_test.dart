import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_event.dart';

void main() {
  test('Supports value equality', () {
    expect(CreateFieldListNameChanged('hi'), CreateFieldListNameChanged('hi'));
    expect(
      CreateFieldListCheckTypeChanged(CheckType.DO_NOT_IGNORE_CASE),
      CreateFieldListCheckTypeChanged(CheckType.DO_NOT_IGNORE_CASE),
    );
    expect(
      CreateFieldListReadAnswerChanged(true),
      CreateFieldListReadAnswerChanged(true),
    );
    expect(
      CreateFieldListColorChanged(Colors.grey.toARGB32()),
      CreateFieldListColorChanged(Colors.grey.toARGB32()),
    );
    expect(CreateFieldListSubmitted(), CreateFieldListSubmitted());
  });
}
