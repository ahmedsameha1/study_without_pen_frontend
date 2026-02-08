import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/common/theme.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/entrys_dao.dart';
import 'package:study_without_pen_by_flutter/features/entries/domain/usecases/create_entry_usecase.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/create_entry_bloc.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/create_entry_event.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/bloc/create_entry_state.dart';
import 'package:study_without_pen_by_flutter/features/entries/presentation/pages/create_entry_page.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';

import '../../../common/common_finders.dart';
import '../../../common/widget_testing_helper.dart';

class MockCreateEntryUsecase extends Mock implements CreateEntryUsecase {}

class MockCreateEntryBloc extends Mock implements CreateEntryBloc {}

Future<void> _createCreateEntryPageInASkeleton(
  WidgetTester tester,
  Locale locale,
  CreateEntryUsecase createEntryUsecase,
  CreateEntryBloc createEntryBloc,
  String fieldListId,
) {
  return tester.pumpWidget(
    RepositoryProvider.value(
      value: createEntryUsecase,
      child: MaterialApp(
        theme: AppTheme.theme,
        localizationsDelegates: [AppLocalizations.delegate],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: BlocProvider.value(
          value: createEntryBloc,
          child: CreateEntryPageView(fieldListId: fieldListId),
        ),
      ),
    ),
  );
}

void main() {
  late CreateEntryUsecase createEntryUsecase;
  FieldListEntity fieldListEntity = FieldListEntity(
    id: const Uuid().v4(),
    fieldId: const Uuid().v4(),
    name: 'Calculus',
    creationAt: DateTime(2020),
    lastModificationAt: DateTime(2021),
  );
  setUpAll(() {
    registerFallbackValue(CreateEntryQuestionChanged(""));
  });
  group('English locale', () {
    final Locale currentLocale = Locale('en');
    String expectedCreateEntryString = "Create Entry";
    String expectedQuestionString = 'Question';
    String expectedAnswerString = 'Answer';
    String expectedLowString = 'Low';
    String expectedNormalString = 'Normal';
    String expectedImportantString = 'Important';
    String expectedVitalString = 'Vital';
    String expectedOrderString = 'Order';
    String expectedOptionalString = 'Optional';
    String expectedCreateString = 'Create';
    String expectedQuestionValidationErrorString =
        "Question must be between 1 and 2000 characters";
    String expectedAnswerValidationErrorString =
        "Answer must be between 1 and 2000 characters";
    String expectedOrderValidationErrorString =
        "Order must be between 0 and 65535";
    String expectedCreatedString = 'Created';
    String expectedFailureString = "Error while creation";
    String expectedDublicationFailureString = "Failure: already exists!";
    group('CreateEntryPage', () {
      setUp(() {
        createEntryUsecase = MockCreateEntryUsecase();
        when(
          () => createEntryUsecase.watchFieldList(fieldListEntity.id!),
        ).thenAnswer((_) => Stream.value(fieldListEntity));
      });

      testWidgets('Test the precense of CreateEntryPageView', (
        WidgetTester tester,
      ) async {
        await tester.pumpWidget(
          RepositoryProvider.value(
            value: createEntryUsecase,
            child: MaterialApp(
              localizationsDelegates: [AppLocalizations.delegate],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: currentLocale,
              home: CreateEntryPage(fieldListId: fieldListEntity.id!),
            ),
          ),
        );
        await tester.pump();
        expect(
          find.descendant(
            of: find.byType(CreateEntryPage),
            matching: find.byType(CreateEntryPageView),
          ),
          findsOne,
        );
      });

      testWidgets(
        'Test calling createEntryUsecase.watchFieldList() on initialization',
        (WidgetTester tester) async {
          await tester.pumpWidget(
            RepositoryProvider.value(
              value: createEntryUsecase,
              child: MaterialApp(
                localizationsDelegates: [AppLocalizations.delegate],
                supportedLocales: AppLocalizations.supportedLocales,
                locale: currentLocale,
                home: CreateEntryPage(fieldListId: fieldListEntity.id!),
              ),
            ),
          );
          verify(
            () => createEntryUsecase.watchFieldList(fieldListEntity.id!),
          ).called(1);
        },
      );
    });

    group('CreateEntryPageView', () {
      late CreateEntryBloc createEntryBloc;
      final question = 'question';
      final answer = 'answer';
      final rank = Rank.normal;
      final order = 5;

      setUp(() {
        createEntryBloc = MockCreateEntryBloc();
        when(() => createEntryBloc.state).thenReturn(
          CreateEntryState(
            status: CreateEntryStatus.initial,
            fieldList: fieldListEntity,
          ),
        );
        when(
          () => createEntryUsecase.call(
            question: question,
            answer: answer,
            fieldListId: fieldListEntity.id!,
            rank: rank,
            order: order,
          ),
        ).thenAnswer((_) => Future.value(1));
      });

      testWidgets(
        'Test the precense of the main widgets when status is not loading',
        (WidgetTester tester) async {
          whenListen<CreateEntryState>(
            createEntryBloc,
            Stream.fromIterable([
              CreateEntryState(
                status: CreateEntryStatus.initial,
                fieldList: fieldListEntity,
              ),
            ]),
          );
          await _createCreateEntryPageInASkeleton(
            tester,
            currentLocale,
            createEntryUsecase,
            createEntryBloc,
            fieldListEntity.id!,
          );
          expect(
            find.descendant(
              of: find.byType(CreateEntryPageView),
              matching: scaffoldFinder,
            ),
            findsOne,
          );
          AppBar appBar = tester.widget<AppBar>(appBarFinder);
          expect(appBar.centerTitle, isTrue);
          Column appBarTitleColumn = appBar.title as Column;
          Text fieldListNameText = tester.widget(
            find.text(fieldListEntity.name),
          );
          Text createEntryText = tester.widget(
            find.text(expectedCreateEntryString),
          );
          expect(
            createEntryText.style!.color,
            AppTheme.theme.primaryColorLight,
          );
          checkWidgetsOrder(appBarTitleColumn.children, [
            fieldListNameText,
            createEntryText,
          ]);
          Scaffold scaffold = tester.widget(scaffoldFinder);
          SafeArea safeArea = scaffold.body as SafeArea;
          Scrollbar scrollbar = safeArea.child as Scrollbar;
          expect(scrollbar.thumbVisibility, true);
          expect(scrollbar.thickness, 10);
          Padding padding = scrollbar.child as Padding;
          expect(padding.padding.horizontal, 40);
          expect(padding.padding.vertical, 40);
          SingleChildScrollView singleChildScrollView =
              padding.child as SingleChildScrollView;
          Column column = singleChildScrollView.child as Column;
          SizedBox questionSizedBox = tester.widget(
            find.byKey(Key('question')),
          );
          expect(questionSizedBox.height, 200);
          TextField questionTextField = tester.widget(
            find.descendant(
              of: find.byWidget(questionSizedBox),
              matching: find.descendant(
                of: formFinder,
                matching: find.descendant(
                  of: textFormFieldFinder,
                  matching: find.byType(TextField),
                ),
              ),
            ),
          );
          expect(questionTextField.maxLength, Entrys.maximumTextLength);
          expect(
            questionTextField.maxLengthEnforcement,
            MaxLengthEnforcement.enforced,
          );
          expect(questionTextField.expands, true);
          expect(questionTextField.maxLines, null);
          expect(questionTextField.textAlign, TextAlign.center);
          expect(questionTextField.keyboardType, TextInputType.multiline);
          expect(questionTextField.autocorrect, isFalse);
          expect(questionTextField.enableSuggestions, isFalse);
          expect(questionTextField.textInputAction, TextInputAction.newline);
          InputDecoration inputDecoration = questionTextField.decoration!;
          expect(inputDecoration.labelText, expectedQuestionString);
          expect(inputDecoration.filled, isTrue);
          expect(inputDecoration.alignLabelWithHint, isTrue);
          expect(inputDecoration.border, isA<OutlineInputBorder>());
          SizedBox questionAnswerSizedBox = tester.widget(
            find.byKey(Key('question_answer')),
          );
          expect(questionAnswerSizedBox.height, 20);
          SizedBox answerSizedBox = tester.widget(find.byKey(Key('answer')));
          expect(questionSizedBox.height, 200);
          TextField answerTextField = tester.widget(
            find.descendant(
              of: find.byWidget(answerSizedBox),
              matching: find.descendant(
                of: formFinder,
                matching: find.descendant(
                  of: textFormFieldFinder,
                  matching: find.byType(TextField),
                ),
              ),
            ),
          );
          expect(answerTextField.maxLength, Entrys.maximumTextLength);
          expect(
            answerTextField.maxLengthEnforcement,
            MaxLengthEnforcement.enforced,
          );
          expect(answerTextField.expands, true);
          expect(answerTextField.maxLines, null);
          expect(answerTextField.textAlign, TextAlign.center);
          expect(answerTextField.keyboardType, TextInputType.multiline);
          expect(answerTextField.autocorrect, isFalse);
          expect(answerTextField.enableSuggestions, isFalse);
          expect(answerTextField.textInputAction, TextInputAction.newline);
          inputDecoration = answerTextField.decoration!;
          expect(inputDecoration.labelText, expectedAnswerString);
          expect(inputDecoration.filled, isTrue);
          expect(inputDecoration.alignLabelWithHint, isTrue);
          expect(inputDecoration.border, isA<OutlineInputBorder>());
          SizedBox answerRankOrderSizedBox = tester.widget(
            find.byKey(Key('answer_rankorder')),
          );
          expect(answerRankOrderSizedBox.height, 20);
          Row rankOrderRow = tester.widget(find.byKey(Key('rank_order')));
          expect(rankOrderRow.mainAxisAlignment, MainAxisAlignment.spaceEvenly);
          expect(rankOrderRow.crossAxisAlignment, CrossAxisAlignment.center);
          Expanded rankExpanded = tester.widget(find.byKey(Key('rank')));
          expect(rankExpanded.flex, 3);
          Wrap wrap = rankExpanded.child as Wrap;
          expect(wrap.spacing, 10);
          expect(wrap.crossAxisAlignment, WrapCrossAlignment.center);
          ChoiceChip lowChoiceChip = tester.widget(
            find.widgetWithText(ChoiceChip, expectedLowString),
          );
          expect(lowChoiceChip.selected, isFalse);
          expect(lowChoiceChip.padding!.horizontal, 0);
          expect(lowChoiceChip.padding!.vertical, 0);
          ChoiceChip normalChoiceChip = tester.widget(
            find.widgetWithText(ChoiceChip, expectedNormalString),
          );
          expect(normalChoiceChip.selected, isTrue);
          expect(normalChoiceChip.padding!.horizontal, 0);
          expect(normalChoiceChip.padding!.vertical, 0);
          ChoiceChip importantChoiceChip = tester.widget(
            find.widgetWithText(ChoiceChip, expectedImportantString),
          );
          expect(importantChoiceChip.selected, false);
          expect(importantChoiceChip.padding!.horizontal, 0);
          expect(importantChoiceChip.padding!.vertical, 0);
          ChoiceChip vitalChoiceChip = tester.widget(
            find.widgetWithText(ChoiceChip, expectedVitalString),
          );
          expect(vitalChoiceChip.selected, false);
          expect(vitalChoiceChip.padding!.horizontal, 0);
          expect(vitalChoiceChip.padding!.vertical, 0);
          Expanded orderExpanded = tester.widget(find.byKey(Key('order')));
          expect(orderExpanded.flex, 1);
          TextField orderTextField = tester.widget(
            find.descendant(
              of: find.byWidget(orderExpanded),
              matching: find.descendant(
                of: formFinder,
                matching: find.descendant(
                  of: textFormFieldFinder,
                  matching: find.byType(TextField),
                ),
              ),
            ),
          );
          expect(
            orderTextField.maxLength,
            '${Entrys.ORDER_MAXIMUM_VALUE}'.length,
          );
          expect(
            orderTextField.maxLengthEnforcement,
            MaxLengthEnforcement.enforced,
          );
          expect(orderTextField.textAlign, TextAlign.center);
          expect(orderTextField.keyboardType, TextInputType.number);
          inputDecoration = orderTextField.decoration!;
          expect(inputDecoration.labelText, expectedOrderString);
          expect(inputDecoration.helperText, expectedOptionalString);
          expect(inputDecoration.helperStyle, TextStyle(fontSize: 10));
          expect(inputDecoration.filled, isTrue);
          expect(inputDecoration.isDense, isTrue);
          expect(inputDecoration.border, isA<OutlineInputBorder>());
          SizedBox rankOrderButtonSizedBox = tester.widget(
            find.byKey(Key('rankorder_button')),
          );
          expect(rankOrderButtonSizedBox.height, 20);
          Row buttonRow = tester.widget(find.byKey(Key('button')));
          FilledButton createButton = tester.widget(
            find.descendant(
              of: find.byWidget(buttonRow),
              matching: find.descendant(
                of: find.byType(Expanded),
                matching: find.byKey(Key('create')),
              ),
            ),
          );
          expect(
            find.descendant(
              of: find.byWidget(createButton),
              matching: find.text(expectedCreateString),
            ),
            findsOne,
          );
          Icon saveIcon = tester.widget(
            find.descendant(
              of: find.byWidget(createButton),
              matching: find.byType(Icon),
            ),
          );
          expect(saveIcon.icon, Icons.save);
          expect(
            checkWidgetsOrder(column.children, [
              questionSizedBox,
              questionAnswerSizedBox,
              answerSizedBox,
              answerRankOrderSizedBox,
              rankOrderRow,
              rankOrderButtonSizedBox,
              buttonRow,
            ]),
            isTrue,
          );
          expect(
            checkWidgetsOrder(wrap.children, [
              lowChoiceChip,
              normalChoiceChip,
              importantChoiceChip,
              vitalChoiceChip,
            ]),
            isTrue,
          );
          expect(
            checkWidgetsOrder(rankOrderRow.children, [
              rankExpanded,
              orderExpanded,
            ]),
            isTrue,
          );
        },
      );

      testWidgets(
        'Test the precense of the main widgets when status is loading',
        (WidgetTester tester) async {
          whenListen<CreateEntryState>(
            createEntryBloc,
            Stream.fromIterable([
              CreateEntryState(
                fieldList: fieldListEntity,
                question: 'question',
                answer: 'answer',
                status: CreateEntryStatus.loading,
              ),
            ]),
          );
          await _createCreateEntryPageInASkeleton(
            tester,
            currentLocale,
            createEntryUsecase,
            createEntryBloc,
            fieldListEntity.id!,
          );
          await tester.pump();
          expect(
            find.descendant(
              of: find.byType(CreateEntryPageView),
              matching: find.descendant(
                of: centerFinder,
                matching: circularProgressIndicatorFinder,
              ),
            ),
            findsOne,
          );
        },
      );

      testWidgets('Rank is low', (WidgetTester tester) async {
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
              rank: Rank.low,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        await tester.pumpAndSettle();
        ChoiceChip lowChoiceChip = tester.widget(
          find.widgetWithText(ChoiceChip, expectedLowString),
        );
        expect(lowChoiceChip.selected, isTrue);
        ChoiceChip normalChoiceChip = tester.widget(
          find.widgetWithText(ChoiceChip, expectedNormalString),
        );
        expect(normalChoiceChip.selected, isFalse);
        ChoiceChip importantChoiceChip = tester.widget(
          find.widgetWithText(ChoiceChip, expectedImportantString),
        );
        expect(importantChoiceChip.selected, isFalse);
        ChoiceChip vitalChoiceChip = tester.widget(
          find.widgetWithText(ChoiceChip, expectedVitalString),
        );
        expect(vitalChoiceChip.selected, isFalse);
      });

      testWidgets('Rank is important', (WidgetTester tester) async {
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
              rank: Rank.important,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        await tester.pumpAndSettle();
        ChoiceChip lowChoiceChip = tester.widget(
          find.widgetWithText(ChoiceChip, expectedLowString),
        );
        expect(lowChoiceChip.selected, isFalse);
        ChoiceChip normalChoiceChip = tester.widget(
          find.widgetWithText(ChoiceChip, expectedNormalString),
        );
        expect(normalChoiceChip.selected, isFalse);
        ChoiceChip importantChoiceChip = tester.widget(
          find.widgetWithText(ChoiceChip, expectedImportantString),
        );
        expect(importantChoiceChip.selected, isTrue);
        ChoiceChip vitalChoiceChip = tester.widget(
          find.widgetWithText(ChoiceChip, expectedVitalString),
        );
        expect(vitalChoiceChip.selected, isFalse);
      });

      testWidgets('Rank is vital', (WidgetTester tester) async {
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
              rank: Rank.vital,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        await tester.pumpAndSettle();
        ChoiceChip lowChoiceChip = tester.widget(
          find.widgetWithText(ChoiceChip, expectedLowString),
        );
        expect(lowChoiceChip.selected, isFalse);
        ChoiceChip normalChoiceChip = tester.widget(
          find.widgetWithText(ChoiceChip, expectedNormalString),
        );
        expect(normalChoiceChip.selected, isFalse);
        ChoiceChip importantChoiceChip = tester.widget(
          find.widgetWithText(ChoiceChip, expectedImportantString),
        );
        expect(importantChoiceChip.selected, isFalse);
        ChoiceChip vitalChoiceChip = tester.widget(
          find.widgetWithText(ChoiceChip, expectedVitalString),
        );
        expect(vitalChoiceChip.selected, isTrue);
      });

      testWidgets('Test question validation', (WidgetTester tester) async {
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        final Finder questionValidationErrorTextFinder = find.descendant(
          of: textFormFieldFinder.at(0),
          matching: find.text(expectedQuestionValidationErrorString),
        );
        final Finder answerValidationErrorTextFinder = find.text(
          expectedAnswerValidationErrorString,
        );
        final Finder orderValidationErrorTextFinder = find.text(
          expectedOrderValidationErrorString,
        );
        expect(questionValidationErrorTextFinder, findsNothing);
        await tester.enterText(textFormFieldFinder.at(0), 'r' * 200);
        await tester.enterText(textFormFieldFinder.at(0), '');
        await tester.pumpAndSettle();
        expect(questionValidationErrorTextFinder, findsOne);
        expect(answerValidationErrorTextFinder, findsNothing);
        expect(orderValidationErrorTextFinder, findsNothing);
        await tester.enterText(textFormFieldFinder.at(0), 'r' * 200);
        await tester.pumpAndSettle();
        expect(questionValidationErrorTextFinder, findsNothing);
        expect(answerValidationErrorTextFinder, findsNothing);
        expect(orderValidationErrorTextFinder, findsNothing);
        await tester.enterText(textFormFieldFinder.at(0), ' ');
        await tester.pumpAndSettle();
        expect(questionValidationErrorTextFinder, findsOne);
        expect(answerValidationErrorTextFinder, findsNothing);
        expect(orderValidationErrorTextFinder, findsNothing);
      });

      testWidgets('Test answer validation', (WidgetTester tester) async {
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        final Finder answerValidationErrorTextFinder = find.descendant(
          of: textFormFieldFinder.at(1),
          matching: find.text(expectedAnswerValidationErrorString),
        );
        final Finder questionValidationErrorTextFinder = find.descendant(
          of: textFormFieldFinder.at(0),
          matching: find.text(expectedQuestionValidationErrorString),
        );
        final Finder orderValidationErrorTextFinder = find.text(
          expectedOrderValidationErrorString,
        );
        expect(answerValidationErrorTextFinder, findsNothing);
        await tester.enterText(textFormFieldFinder.at(1), 'r' * 200);
        await tester.enterText(textFormFieldFinder.at(1), '');
        await tester.pumpAndSettle();
        expect(answerValidationErrorTextFinder, findsOne);
        expect(questionValidationErrorTextFinder, findsNothing);
        expect(orderValidationErrorTextFinder, findsNothing);
        await tester.enterText(textFormFieldFinder.at(1), 'r' * 200);
        await tester.pumpAndSettle();
        expect(answerValidationErrorTextFinder, findsNothing);
        expect(questionValidationErrorTextFinder, findsNothing);
        expect(orderValidationErrorTextFinder, findsNothing);
        await tester.enterText(textFormFieldFinder.at(1), ' ');
        await tester.pumpAndSettle();
        expect(answerValidationErrorTextFinder, findsOne);
        expect(questionValidationErrorTextFinder, findsNothing);
        expect(orderValidationErrorTextFinder, findsNothing);
      });

      testWidgets('Test order validation', (WidgetTester tester) async {
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        final Finder orderValidationErrorTextFinder = find.descendant(
          of: textFormFieldFinder.at(2),
          matching: find.text(expectedOrderValidationErrorString),
        );
        final Finder questionValidationErrorTextFinder = find.descendant(
          of: textFormFieldFinder.at(0),
          matching: find.text(expectedQuestionValidationErrorString),
        );
        final Finder answerValidationErrorTextFinder = find.text(
          expectedAnswerValidationErrorString,
        );
        expect(orderValidationErrorTextFinder, findsNothing);
        await tester.enterText(textFormFieldFinder.at(2), 'r' * 200);
        await tester.enterText(textFormFieldFinder.at(2), '99999');
        await tester.ensureVisible(textFormFieldFinder.at(1));
        await tester.tap(textFormFieldFinder.at(1));
        await tester.pumpAndSettle();
        expect(orderValidationErrorTextFinder, findsOne);
        expect(questionValidationErrorTextFinder, findsNothing);
        expect(answerValidationErrorTextFinder, findsNothing);
        await tester.enterText(textFormFieldFinder.at(2), '200');
        await tester.pumpAndSettle();
        expect(orderValidationErrorTextFinder, findsNothing);
        expect(questionValidationErrorTextFinder, findsNothing);
        expect(answerValidationErrorTextFinder, findsNothing);
        await tester.enterText(textFormFieldFinder.at(2), '');
        await tester.pumpAndSettle();
        expect(orderValidationErrorTextFinder, findsNothing);
        expect(questionValidationErrorTextFinder, findsNothing);
        expect(answerValidationErrorTextFinder, findsNothing);
        await tester.enterText(textFormFieldFinder.at(2), '-1');
        await tester.pumpAndSettle();
        expect(orderValidationErrorTextFinder, findsOne);
        expect(questionValidationErrorTextFinder, findsNothing);
        expect(answerValidationErrorTextFinder, findsNothing);
        await tester.enterText(textFormFieldFinder.at(2), 'wew');
        await tester.pumpAndSettle();
        expect(orderValidationErrorTextFinder, findsOne);
        expect(questionValidationErrorTextFinder, findsNothing);
        expect(answerValidationErrorTextFinder, findsNothing);
      });

      testWidgets('The button is disabled while there is any invalid field', (
        WidgetTester tester,
      ) async {
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        await tester.enterText(textFormFieldFinder.at(0), ' ');
        await tester.enterText(textFormFieldFinder.at(1), ' ');
        await tester.enterText(textFormFieldFinder.at(2), 'a');
        await tester.pumpAndSettle();
        FilledButton createButton = tester.widget(find.byKey(Key('create')));
        expect(createButton.enabled, isFalse);
        await tester.enterText(textFormFieldFinder.at(0), 'question');
        await tester.enterText(textFormFieldFinder.at(1), ' ');
        await tester.enterText(textFormFieldFinder.at(2), '1');
        await tester.pumpAndSettle();
        createButton = tester.widget(find.byKey(Key('create')));
        expect(createButton.enabled, isFalse);
        expect(createButton.enabled, isFalse);
        await tester.enterText(textFormFieldFinder.at(0), ' ');
        await tester.enterText(textFormFieldFinder.at(1), 'answer');
        await tester.enterText(textFormFieldFinder.at(2), '1');
        await tester.pumpAndSettle();
        createButton = tester.widget(find.byKey(Key('create')));
        expect(createButton.enabled, isFalse);
        await tester.enterText(textFormFieldFinder.at(0), 'question');
        await tester.enterText(textFormFieldFinder.at(1), 'answer');
        await tester.enterText(textFormFieldFinder.at(2), 'a');
        await tester.pumpAndSettle();
        createButton = tester.widget(find.byKey(Key('create')));
        expect(createButton.enabled, isFalse);
        await tester.enterText(textFormFieldFinder.at(0), 'question');
        await tester.enterText(textFormFieldFinder.at(1), 'answer');
        await tester.enterText(textFormFieldFinder.at(2), '');
        await tester.pumpAndSettle();
        createButton = tester.widget(find.byKey(Key('create')));
        expect(createButton.enabled, isTrue);
      });

      testWidgets(
        'Clicking a rank call CreateEntryBloc.add() with event of the selected rank',
        (WidgetTester tester) async {
          whenListen<CreateEntryState>(
            createEntryBloc,
            Stream.fromIterable([
              CreateEntryState(
                status: CreateEntryStatus.initial,
                fieldList: fieldListEntity,
              ),
            ]),
          );
          await _createCreateEntryPageInASkeleton(
            tester,
            currentLocale,
            createEntryUsecase,
            createEntryBloc,
            fieldListEntity.id!,
          );
          ChoiceChip lowChoiceChip = tester.widget(
            find.widgetWithText(ChoiceChip, expectedLowString),
          );
          await tester.tap(find.byWidget(lowChoiceChip));
          verify(
            () => createEntryBloc.add(CreateEntryRankChanged(Rank.low)),
          ).called(1);
          whenListen<CreateEntryState>(
            createEntryBloc,
            Stream.fromIterable([
              CreateEntryState(
                status: CreateEntryStatus.initial,
                fieldList: fieldListEntity,
              ),
            ]),
          );
          await _createCreateEntryPageInASkeleton(
            tester,
            currentLocale,
            createEntryUsecase,
            createEntryBloc,
            fieldListEntity.id!,
          );
          ChoiceChip normalChoiceChip = tester.widget(
            find.widgetWithText(ChoiceChip, expectedNormalString),
          );
          await tester.tap(find.byWidget(normalChoiceChip));
          verify(
            () => createEntryBloc.add(CreateEntryRankChanged(Rank.normal)),
          ).called(1);
          whenListen<CreateEntryState>(
            createEntryBloc,
            Stream.fromIterable([
              CreateEntryState(
                status: CreateEntryStatus.initial,
                fieldList: fieldListEntity,
              ),
            ]),
          );
          await _createCreateEntryPageInASkeleton(
            tester,
            currentLocale,
            createEntryUsecase,
            createEntryBloc,
            fieldListEntity.id!,
          );
          ChoiceChip importantChoiceChip = tester.widget(
            find.widgetWithText(ChoiceChip, expectedImportantString),
          );
          await tester.tap(find.byWidget(importantChoiceChip));
          verify(
            () => createEntryBloc.add(CreateEntryRankChanged(Rank.important)),
          ).called(1);
          whenListen<CreateEntryState>(
            createEntryBloc,
            Stream.fromIterable([
              CreateEntryState(
                status: CreateEntryStatus.initial,
                fieldList: fieldListEntity,
              ),
            ]),
          );
          await _createCreateEntryPageInASkeleton(
            tester,
            currentLocale,
            createEntryUsecase,
            createEntryBloc,
            fieldListEntity.id!,
          );
          ChoiceChip vitalChoiceChip = tester.widget(
            find.widgetWithText(ChoiceChip, expectedVitalString),
          );
          await tester.tap(find.byWidget(vitalChoiceChip));
          verify(
            () => createEntryBloc.add(CreateEntryRankChanged(Rank.vital)),
          ).called(1);
        },
      );

      testWidgets('Entring a valid question adds an event to the bloc', (
        WidgetTester tester,
      ) async {
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        await tester.enterText(textFormFieldFinder.at(0), 'question');
        verify(
          () => createEntryBloc.add(CreateEntryQuestionChanged('question')),
        ).called(1);
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        await tester.enterText(textFormFieldFinder.at(0), ' question ');
        verify(
          () => createEntryBloc.add(CreateEntryQuestionChanged('question')),
        ).called(1);
      });

      testWidgets('Entring a valid answer adds an event to the bloc', (
        WidgetTester tester,
      ) async {
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        await tester.enterText(textFormFieldFinder.at(1), 'answer');
        verify(
          () => createEntryBloc.add(CreateEntryAnswerChanged('answer')),
        ).called(1);
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        await tester.enterText(textFormFieldFinder.at(1), ' answer ');
        verify(
          () => createEntryBloc.add(CreateEntryAnswerChanged('answer')),
        ).called(1);
      });

      testWidgets('Entring a valid order adds an event to the bloc', (
        WidgetTester tester,
      ) async {
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        await tester.enterText(textFormFieldFinder.at(2), '10');
        verify(
          () => createEntryBloc.add(CreateEntryOrderChanged('10')),
        ).called(1);
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        await tester.enterText(textFormFieldFinder.at(2), ' 10 ');
        verify(
          () => createEntryBloc.add(CreateEntryOrderChanged('10')),
        ).called(1);
      });

      testWidgets('Clicking the button add an event to the bloc', (
        WidgetTester tester,
      ) async {
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              status: CreateEntryStatus.initial,
              fieldList: fieldListEntity,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        await tester.pump();
        await tester.enterText(textFormFieldFinder.at(0), 'question');
        await tester.enterText(textFormFieldFinder.at(1), 'answer');
        await tester.enterText(textFormFieldFinder.at(2), '');
        await tester.pumpAndSettle();
        const key = Key('create');
        await tester.ensureVisible(find.byKey(key));
        await tester.tap(find.byKey(key));
        verify(() => createEntryBloc.add(CreateEntrySubmitted())).called(1);
      });

      testWidgets('Show a snackBar with created when status is success', (
        WidgetTester tester,
      ) async {
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              fieldList: fieldListEntity,
              status: CreateEntryStatus.success,
              question: 'question',
              answer: 'answer',
              rank: Rank.normal,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        await tester.pump();
        SnackBar snackBar = tester.widget(snackBarFinder);
        expect((snackBar.content as Text).data, expectedCreatedString);
        const key = Key('create');
        FilledButton creationButton = tester.widget(find.byKey(key));
        expect(find.text(expectedQuestionValidationErrorString), findsNothing);
        expect(find.text(expectedAnswerValidationErrorString), findsNothing);
        expect(find.text(expectedOrderValidationErrorString), findsNothing);
        expect(creationButton.enabled, isFalse);
      });

      testWidgets('Show a snackBar with failure when status is failure', (
        WidgetTester tester,
      ) async {
        whenListen<CreateEntryState>(
          createEntryBloc,
          Stream.fromIterable([
            CreateEntryState(
              fieldList: fieldListEntity,
              status: CreateEntryStatus.failure,
              question: 'question',
              answer: 'answer',
              rank: Rank.normal,
            ),
          ]),
        );
        await _createCreateEntryPageInASkeleton(
          tester,
          currentLocale,
          createEntryUsecase,
          createEntryBloc,
          fieldListEntity.id!,
        );
        await tester.pump();
        SnackBar snackBar = tester.widget(snackBarFinder);
        expect((snackBar.content as Text).data, expectedFailureString);
        expect(snackBar.backgroundColor, AppTheme.theme.colorScheme.error);
      });

      testWidgets(
        'Show a snackBar with dublication failure when status is dublicationFailure',
        (WidgetTester tester) async {
          whenListen<CreateEntryState>(
            createEntryBloc,
            Stream.fromIterable([
              CreateEntryState(
                fieldList: fieldListEntity,
                status: CreateEntryStatus.duplicationFailure,
                question: 'question',
                answer: 'answer',
                rank: Rank.normal,
              ),
            ]),
          );
          await _createCreateEntryPageInASkeleton(
            tester,
            currentLocale,
            createEntryUsecase,
            createEntryBloc,
            fieldListEntity.id!,
          );
          await tester.pump();
          SnackBar snackBar = tester.widget(snackBarFinder);
          expect(
            (snackBar.content as Text).data,
            expectedDublicationFailureString,
          );
          expect(snackBar.backgroundColor, AppTheme.theme.colorScheme.error);
        },
      );
    });
  });
}
