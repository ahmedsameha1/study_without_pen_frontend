import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/common/theme.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/models/entry_entity.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/pages/entry_card.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../../common/common_finders.dart';

class OnTap extends Mock {
  void call();
}

void main() {
  group('English', () {
    final OnTap onTap = OnTap();
    const Locale currentLocale = Locale('en');
    const expectedScoreString = 'Score';
    const expectedWrongnessString = 'Wrongness';
    const expectedLowString = 'Low';
    const expectedNormalString = 'Normal';
    const expectedImportantString = 'Important';
    const expectedVitalString = 'Vital';
    final entry1 = EntryEntity(
      fieldListId: const Uuid().v4(),
      answer: 'answer',
      question: 'question',
      creationAt: DateTime(2025),
      lastModificationAt: DateTime(2025),
      rank: Rank.low,
      askedCount: 10,
      wronglyAnsweredCount: 1,
    );
    final entry2 = EntryEntity(
      fieldListId: const Uuid().v4(),
      answer: 'answer',
      question: 'question',
      creationAt: DateTime(2025),
      lastModificationAt: DateTime(2025),
      rank: Rank.low,
      askedCount: 10,
      wronglyAnsweredCount: 4,
    );
    final entry3 = EntryEntity(
      fieldListId: const Uuid().v4(),
      answer: 'answer',
      question: 'question',
      creationAt: DateTime(2025),
      lastModificationAt: DateTime(2025),
      rank: Rank.low,
      askedCount: 10,
      wronglyAnsweredCount: 5,
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
          home: EntryCard(entry: entry1, onTap: onTap.call),
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
        const BorderSide(color: Colors.green, width: 4),
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
      expect(
        (scoreChip.label as Text).data,
        '$expectedScoreString: ${entry1.score}',
      );
      expect(
        scoreChip.labelStyle,
        Theme.of(tester.element(find.byWidget(scoreChip))).textTheme.labelSmall,
      );
      expect(scoreChip.padding, EdgeInsets.zero);
      Chip wrongnessChip = tester.widget(
        find.descendant(
          of: find.byWidget(scoreRankRow),
          matching: find.byType(Chip).at(1),
        ),
      );
      expect(
        (wrongnessChip.label as Text).data,
        '$expectedWrongnessString: ${entry1.wrongness}',
      );
      expect(
        wrongnessChip.labelStyle,
        Theme.of(
          tester.element(find.byWidget(wrongnessChip)),
        ).textTheme.labelSmall,
      );
      expect(wrongnessChip.padding, EdgeInsets.zero);
      Chip rankChip = tester.widget(
        find.descendant(
          of: find.byWidget(scoreRankRow),
          matching: find.byType(Chip).at(2),
        ),
      );
      expect((rankChip.label as Text).data, expectedLowString);
      expect(
        rankChip.labelStyle,
        Theme.of(tester.element(find.byWidget(rankChip))).textTheme.labelSmall,
      );
      expect(rankChip.padding, EdgeInsets.zero);
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
      Text questionText = tester.widget(
        find.descendant(
          of: find.byWidget(outerColumn),
          matching: find.descendant(
            of: rowFinder.at(2),
            matching: find.descendant(
              of: find.byType(Flexible),
              matching: find.descendant(
                of: centerFinder,
                matching: find.byType(Text),
              ),
            ),
          ),
        ),
      );
      expect(questionText.textAlign, TextAlign.center);
      expect(
        questionText.style,
        Theme.of(
          tester.element(find.byWidget(questionText)),
        ).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.w600),
      );
      expect(questionText.data, entry1.question);
      SizedBox questionAnswerSizedBox = tester.widget(
        find.descendant(
          of: find.byWidget(outerColumn),
          matching: find.byKey(const Key('questionAnswerSizedBox')),
        ),
      );
      expect(questionAnswerSizedBox.height, 10);
      Text answerText = tester.widget(
        find.descendant(
          of: find.byWidget(outerColumn),
          matching: find.descendant(
            of: rowFinder.at(3),
            matching: find.descendant(
              of: find.byType(Flexible),
              matching: find.descendant(
                of: centerFinder,
                matching: find.byType(Text),
              ),
            ),
          ),
        ),
      );
      expect(answerText.textAlign, TextAlign.center);
      expect(
        answerText.style,
        Theme.of(
          tester.element(find.byWidget(questionText)),
        ).textTheme.bodyLarge,
      );
      expect(answerText.data, entry1.answer);
    });

    testWidgets('rank is normal', (WidgetTester tester) async {
      await tester.binding.setLocale('en', 'US');
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,
          theme: AppTheme.theme,
          home: EntryCard(
            entry: entry1.copyWith(rank: Rank.normal),
            onTap: onTap.call,
          ),
        ),
      );
      Chip rankChip = tester.widget(
        find.descendant(of: rowFinder, matching: find.byType(Chip).at(2)),
      );
      expect((rankChip.label as Text).data, expectedNormalString);
    });

    testWidgets('rank is Important', (WidgetTester tester) async {
      await tester.binding.setLocale('en', 'US');
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,
          theme: AppTheme.theme,
          home: EntryCard(
            entry: entry1.copyWith(rank: Rank.important),
            onTap: onTap.call,
          ),
        ),
      );
      Chip rankChip = tester.widget(
        find.descendant(of: rowFinder, matching: find.byType(Chip).at(2)),
      );
      expect((rankChip.label as Text).data, expectedImportantString);
    });

    testWidgets('rank is Vital', (WidgetTester tester) async {
      await tester.binding.setLocale('en', 'US');
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,
          theme: AppTheme.theme,
          home: EntryCard(
            entry: entry1.copyWith(rank: Rank.vital),
            onTap: onTap.call,
          ),
        ),
      );
      Chip rankChip = tester.widget(
        find.descendant(of: rowFinder, matching: find.byType(Chip).at(2)),
      );
      expect((rankChip.label as Text).data, expectedVitalString);
    });

    testWidgets('woringness is in middle', (WidgetTester tester) async {
      await tester.binding.setLocale('en', 'US');
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,
          theme: AppTheme.theme,
          home: EntryCard(entry: entry2, onTap: onTap.call),
        ),
      );
      Container container = tester.widget(
        find.descendant(
          of: find.byType(ClipPath),
          matching: find.byType(Container),
        ),
      );
      expect(
        ((container.decoration! as BoxDecoration).border! as Border).left,
        const BorderSide(color: Colors.yellow, width: 4),
      );
    });

    testWidgets('woringness is in high', (WidgetTester tester) async {
      await tester.binding.setLocale('en', 'US');
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,
          theme: AppTheme.theme,
          home: EntryCard(entry: entry3, onTap: onTap.call),
        ),
      );
      Container container = tester.widget(
        find.descendant(
          of: find.byType(ClipPath),
          matching: find.byType(Container),
        ),
      );
      expect(
        ((container.decoration! as BoxDecoration).border! as Border).left,
        BorderSide(color: Colors.red.shade700, width: 4),
      );
    });

    testWidgets('tapping the EntryCard calling onTap', (
      WidgetTester tester,
    ) async {
      await tester.binding.setLocale('en', 'US');
      await tester.pumpWidget(
        MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: currentLocale,
          theme: AppTheme.theme,
          home: EntryCard(entry: entry3, onTap: onTap.call),
        ),
      );
      await tester.tap(find.byType(EntryCard));
      await tester.pumpAndSettle();
      verify(onTap.call).called(1);
    });
  });
}
