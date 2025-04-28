import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/cubit/create_field_cubit.dart';

void main() {
  test('has the correct initial state', () {
    CreateFieldCubit createFieldCubit = CreateFieldCubit();
    expect(createFieldCubit.state, CreateFieldState.initial);
  });
}
