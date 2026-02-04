import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/common/theme.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/pages/entry_card.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../../common/common_finders.dart';

void main() {
  group('English', () {
    const Locale currentLocale = Locale('en');
    const expectedScoreString = 'Score';
    const expectedLowString = 'Low';
    const expectedNormalString = 'Normal';
    const expectedImportantString = 'Important';
    const expectedVitalString = 'Vital';
    const expectedTestString = 'Test';
    const expectedStudyString = 'Study';
    final entry = EntryEntity(
      fieldListId: const Uuid().v4(),
      answer: 'answer',
      question: 'question',
      creationAt: DateTime(2025),
      lastModificationAt: DateTime(2025),
      rank: 0,
    );
    testWidgets('Test the precense of the main widgets', (
      WidgetTester tester,
    ) async {
      await tester.binding.setLocale('en', 'US');
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,
          theme: AppTheme.theme,
          home: EntryCard(entry: entry),
        ),
      );
      expect(
        find.descendant(
          of: find.byType(EntryCard),
          matching: find.byType(Dismissible),
        ),
        findsOne,
      );
      expect(
        find.descendant(
          of: find.byType(Dismissible),
          matching: find.byType(InkWell).at(0),
        ),
        findsOne,
      );
      Card card = tester.widget(
        find.descendant(of: find.byType(InkWell), matching: find.byType(Card)),
      );
      expect(card.elevation, 5);
      expect(card.margin!.horizontal, 30);
      expect(card.margin!.vertical, 20);
      ClipPath clipPath = tester.widget(
        find.descendant(
          of: find.byWidget(card),
          matching: find.byType(ClipPath),
        ),
      );
      expect(
        ((clipPath.clipper! as ShapeBorderClipper).shape
                as RoundedRectangleBorder)
            .borderRadius,
        BorderRadius.circular(10),
      );
      Container container = tester.widget(
        find.descendant(
          of: find.byWidget(clipPath),
          matching: find.byType(Container),
        ),
      );
      expect(container.padding!.horizontal, 20);
      expect(container.padding!.vertical, 20);
      expect(
        ((container.decoration! as BoxDecoration).border! as Border).left,
        BorderSide(color: Colors.red.shade700, width: 7),
      );
      Column outerColumn = tester.widget(
        find.descendant(of: find.byWidget(container), matching: columnFinder),
      );
      Row firstRow = tester.widget(
        find.descendant(
          of: find.byWidget(outerColumn),
          matching: rowFinder.at(0),
        ),
      );
      expect(firstRow.mainAxisAlignment, MainAxisAlignment.spaceBetween);
      Row scoreRankRow = tester.widget(
        find.descendant(of: find.byWidget(firstRow), matching: rowFinder),
      );
      Chip scoreChip = tester.widget(
        find.descendant(
          of: find.byWidget(scoreRankRow),
          matching: find.byType(Chip).at(0),
        ),
      );
      expect((scoreChip.label as Text).data, startsWith(expectedScoreString));
      Chip rankChip = tester.widget(
        find.descendant(
          of: find.byWidget(scoreRankRow),
          matching: find.byType(Chip).at(1),
        ),
      );
      expect((rankChip.label as Text).data, startsWith(expectedLowString));
      expect(
        find.descendant(
          of: find.byWidget(firstRow),
          matching: find.byType(PopupMenuButton<String>),
        ),
        findsOne,
      );
      SizedBox scoreRankQuestionSizedBox = tester.widget(
        find.descendant(
          of: find.byWidget(outerColumn),
          matching: find.byKey(const Key('scoreRankQuestionSizedBox')),
        ),
      );
      expect(scoreRankQuestionSizedBox.height, 10);
      SelectableText questionSelectableText = tester.widget(
        find.descendant(
          of: find.byWidget(outerColumn),
          matching: find.descendant(
            of: rowFinder.at(2),
            matching: find.descendant(
              of: find.byType(Flexible),
              matching: find.descendant(
                of: centerFinder,
                matching: find.byType(SelectableText),
              ),
            ),
          ),
        ),
      );
      expect(questionSelectableText.textAlign, TextAlign.center);
      expect(
        questionSelectableText.style,
        Theme.of(
          tester.element(find.byWidget(questionSelectableText)),
        ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
      );
      expect(questionSelectableText.data, entry.question);
      SizedBox questionAnswerSizedBox = tester.widget(
        find.descendant(
          of: find.byWidget(outerColumn),
          matching: find.byKey(const Key('questionAnswerSizedBox')),
        ),
      );
      expect(questionAnswerSizedBox.height, 10);
      SelectableText answerSelectableText = tester.widget(
        find.descendant(
          of: find.byWidget(outerColumn),
          matching: find.descendant(
            of: rowFinder.at(3),
            matching: find.descendant(
              of: find.byType(Flexible),
              matching: find.descendant(
                of: centerFinder,
                matching: find.byType(SelectableText),
              ),
            ),
          ),
        ),
      );
      expect(answerSelectableText.textAlign, TextAlign.center);
      expect(
        answerSelectableText.style,
        Theme.of(
          tester.element(find.byWidget(questionSelectableText)),
        ).textTheme.bodyLarge,
      );
      expect(answerSelectableText.data, entry.answer);
      SizedBox answerButtonsSizedBox = tester.widget(
        find.descendant(
          of: find.byWidget(outerColumn),
          matching: find.byKey(const Key('answerButtonsSizedBox')),
        ),
      );
      expect(answerButtonsSizedBox.height, 10);
      Row buttonsRow = tester.widget(
        find.descendant(
          of: find.byWidget(outerColumn),
          matching: rowFinder.at(4),
        ),
      );
      expect(buttonsRow.mainAxisAlignment, MainAxisAlignment.spaceAround);
      ElevatedButton studyButton = tester.widget(
        find.descendant(
          of: find.byWidget(buttonsRow),
          matching: find.byType(ElevatedButton).at(0),
        ),
      );
      expect(
        studyButton.style,
        ElevatedButton.styleFrom(
          backgroundColor: Theme.of(
            tester.element(find.byType(ElevatedButton).at(0)),
          ).colorScheme.onSecondary,
        ),
      );
      Text studyText = tester.widget(
        find.descendant(
          of: find.byWidget(studyButton),
          matching: find.text(expectedStudyString),
        ),
      );
      expect(
        studyText.style,
        Theme.of(tester.element(find.byWidget(studyText))).textTheme.titleSmall,
      );
      ElevatedButton testButton = tester.widget(
        find.descendant(
          of: find.byWidget(buttonsRow),
          matching: find.byType(ElevatedButton).at(1),
        ),
      );
      expect(
        testButton.style,
        ElevatedButton.styleFrom(
          backgroundColor: Theme.of(
            tester.element(find.byType(ElevatedButton).at(1)),
          ).colorScheme.onSecondary,
        ),
      );
      Text testText = tester.widget(
        find.descendant(
          of: find.byWidget(testButton),
          matching: find.text(expectedTestString),
        ),
      );
      expect(
        testText.style,
        Theme.of(tester.element(find.byWidget(testText))).textTheme.titleSmall,
      );
    });

    testWidgets('rank is normal', (WidgetTester tester) async {
      await tester.binding.setLocale('en', 'US');
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,
          theme: AppTheme.theme,
          home: EntryCard(entry: entry.copyWith(rank: 1)),
        ),
      );
      Chip rankChip = tester.widget(
        find.descendant(of: rowFinder, matching: find.byType(Chip).at(1)),
      );
      expect((rankChip.label as Text).data, startsWith(expectedNormalString));
    });

    testWidgets('rank is Important', (WidgetTester tester) async {
      await tester.binding.setLocale('en', 'US');
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,
          theme: AppTheme.theme,
          home: EntryCard(entry: entry.copyWith(rank: 2)),
        ),
      );
      Chip rankChip = tester.widget(
        find.descendant(of: rowFinder, matching: find.byType(Chip).at(1)),
      );
      expect(
        (rankChip.label as Text).data,
        startsWith(expectedImportantString),
      );
    });

    testWidgets('rank is Vital', (WidgetTester tester) async {
      await tester.binding.setLocale('en', 'US');
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,
          theme: AppTheme.theme,
          home: EntryCard(entry: entry.copyWith(rank: 3)),
        ),
      );
      Chip rankChip = tester.widget(
        find.descendant(of: rowFinder, matching: find.byType(Chip).at(1)),
      );
      expect((rankChip.label as Text).data, startsWith(expectedVitalString));
    });
  });
}
