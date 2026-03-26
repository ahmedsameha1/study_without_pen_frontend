import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_bloc.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_state.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/pages/study_test_page.dart';

void main() {
  group('English locale', () {
    Locale currentLocale = const Locale('en');
    group('StudyTestPage', () {
      testWidgets('Test the presence of StudyTestPageView widget', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(home: StudyTestPage(state: const StudyTestState())),
        );
        expect(
          find.descendant(
            of: find.byType(StudyTestPage),
            matching: find.byType(StudyTestPageView),
          ),
          findsOne,
        );
      });
    });

    group('StudyTestPageView', () {
      late StudyTestBloc studyTestBloc;

      setUp(() {
        studyTestBloc = StudyTestBloc(const StudyTestState());
      });

      testWidgets('Test the precense of the main widgets', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: studyTestBloc,
              child: const StudyTestPageView(),
            ),
          ),
        );
      });
    });
  });
}
