import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/bloc/study_test_state.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/pages/study_tab_view.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/pages/study_test_page_view_content.dart';
import 'package:study_without_pen_by_flutter/features/study_test/presentation/pages/test_tab_view.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../../common/common_finders.dart';

void main() {
  group('English locale', () {
    Locale currentLocale = const Locale('en');
    String expectedStudyString = 'Study';
    String expectedTestString = 'Test';
    const studyCount = 23;
    const testCount = 74;
    const StudyTestTab tab = StudyTestTab.study;
    EntryEntity entry = EntryEntity(
      fieldListId: const Uuid().v4(),
      answer: 'answer',
      question: 'question',
      creationAt: DateTime(2025),
      lastModificationAt: DateTime(2025),
    );
    testWidgets('Test the precense of the main widgets', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: const [AppLocalizations.delegate],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,
          //theme: AppTheme.theme,
          home: Scaffold(
            body: StudyTestPageViewContent(
              entry: entry,
              studyCount: studyCount,
              testCount: testCount,
              tab: tab,
            ),
          ),
        ),
      );
      DefaultTabController defaultTabController = tester.widget(
        find.descendant(
          of: find.byType(StudyTestPageViewContent),
          matching: find.byType(DefaultTabController),
        ),
      );
      expect(defaultTabController.length, 2);
      Column column = tester.widget(
        find.descendant(
          of: find.byWidget(defaultTabController),
          matching: find.byKey(const Key('outerColumn')),
        ),
      );
      TabBar tabBar = tester.widget(
        find.descendant(
          of: find.byWidget(column),
          matching: find.byType(TabBar),
        ),
      );
      expect((tabBar.tabs[0] as Text).data, expectedStudyString);
      expect((tabBar.tabs[1] as Text).data, expectedTestString);
      TabBarView tabBarView = tester.widget(
        find.descendant(
          of: find.byWidget(column),
          matching: find.descendant(
            of: expandedFinder,
            matching: find.byType(TabBarView),
          ),
        ),
      );
      expect(tabBarView.physics, const NeverScrollableScrollPhysics());
      expect(tabBarView.children[0], isA<StudyTabView>());
      expect(tabBarView.children[1], isA<TestTabView>());
      expect(find.text('$studyCount'), findsOne);
      await tester.tap(find.text(expectedTestString));
      await tester.pumpAndSettle();
      expect(find.text('$testCount'), findsOne);
    });
  });
}
