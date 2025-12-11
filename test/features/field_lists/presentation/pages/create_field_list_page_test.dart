import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:study_without_pen_by_flutter/common/router_config.dart';
import 'package:study_without_pen_by_flutter/common/widgets/ok_cancel.dart';
import 'package:study_without_pen_by_flutter/common/widgets/pick_color.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/create_field_list_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_state.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/pages/create_field_list_page.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart'
    as nonso;

import '../../../common/common_finders.dart';
import '../../../common/widget_testing_helper.dart';

class FakeCreateFieldListNameChanged extends Fake
    implements CreateFieldListNameChanged {}

class MockGoRouter extends Mock implements GoRouter {}

class MockCreateFieldListUsecase extends Mock
    implements CreateFieldListUsecase {}

class MockCreateFieldListBloc
    extends MockBloc<CreateFieldListEvent, CreateFieldListState>
    implements CreateFieldListBloc {}

Future<void> _createCreateFieldListPageInASkeleton(
  WidgetTester tester,
  Locale locale,
  GoRouter goRouter,
  CreateFieldListUsecase createFieldListUsecase,
  String fieldId,
) async {
  await tester.pumpWidget(
    RepositoryProvider.value(
      value: createFieldListUsecase,
      child: MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          nonso.AppLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: InheritedGoRouter(
          goRouter: goRouter,
          child: CreateFieldListPage(fieldId: fieldId),
        ),
      ),
    ),
  );
}

Future<void> _createCreateFieldListPageViewInASkeleton(
  WidgetTester tester,
  Locale locale,
  GoRouter goRouter,
  CreateFieldListUsecase createFieldListUsecase,
  CreateFieldListBloc createFieldListBloc,
) async {
  return tester.pumpWidget(
    RepositoryProvider.value(
      value: createFieldListUsecase,
      child: MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          nonso.AppLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: InheritedGoRouter(
          goRouter: goRouter,
          child: BlocProvider.value(
            value: createFieldListBloc,
            child: const CreateFieldListPageView(),
          ),
        ),
      ),
    ),
  );
}

void main() {
  String fieldId = "woeghweo";
  String fieldListName = "field list name";
  CheckType checkType = CheckType.NON_STRICT_IGNORE_CASE;
  bool readAnswer = false;
  int color = Colors.white.toARGB32();
  GoRouter goRouter = MockGoRouter();

  late CreateFieldListUsecase createFieldListUsecase;
  String expectedCreateFieldString = "Create Field List";
  String expectedFieldListNameString = "Field List Name";
  group("English locale", () {
    Locale currentLocale = const Locale("en");
    String expectedInvalidNameString =
        "Field list name must be between 1 and 64 characters";
    String doNotCheckLetterCaseString = 'Do not check letter case';

    group('CreateFieldListPage', () {
      setUp(() {
        registerFallbackValue(FakeCreateFieldListNameChanged());
        createFieldListUsecase = MockCreateFieldListUsecase();
        when(
          () => createFieldListUsecase.call(
            fieldId,
            fieldListName,
            checkType,
            readAnswer,
            color,
          ),
        ).thenAnswer((_) => Future.value(1));
      });

      testWidgets('Test the precense of CreateFieldListPageView', (
        WidgetTester tester,
      ) async {
        await _createCreateFieldListPageInASkeleton(
          tester,
          currentLocale,
          goRouter,
          createFieldListUsecase,
          fieldId,
        );
        expect(
          find.descendant(
            of: find.byType(CreateFieldListPage),
            matching: find.byType(CreateFieldListPageView),
          ),
          findsOne,
        );
      });
    });

    group('CreateFieldListPageView', () {
      late CreateFieldListBloc createFieldListBloc;
      setUp(() {
        createFieldListBloc = MockCreateFieldListBloc();
        when(
          () => createFieldListBloc.state,
        ).thenReturn(CreateFieldListState(fieldId: fieldId));
        createFieldListUsecase = MockCreateFieldListUsecase();
        when(
          () => createFieldListUsecase.call(
            fieldId,
            fieldListName,
            checkType,
            readAnswer,
            color,
          ),
        ).thenAnswer((_) => Future.value(1));
      });

      testWidgets('test the presence of the main widgets', (
        WidgetTester tester,
      ) async {
        await _createCreateFieldListPageViewInASkeleton(
          tester,
          currentLocale,
          goRouter,
          createFieldListUsecase,
          createFieldListBloc,
        );
        expect(
          find.descendant(
            of: find.byType(CreateFieldListPageView),
            matching: scaffoldFinder,
          ),
          findsOne,
        );
        final appBarFinder = find.descendant(
          of: scaffoldFinder,
          matching: find.byType(AppBar),
        );
        expect(appBarFinder, findsOneWidget);
        AppBar appBar = tester.widget<AppBar>(appBarFinder);
        Text title = appBar.title as Text;
        expect(title.data, expectedCreateFieldString);
        Scaffold scaffold = tester.widget(scaffoldFinder);
        SafeArea safeArea = scaffold.body as SafeArea;
        Center center = safeArea.child as Center;
        Card card = tester.widget(
          find.descendant(of: find.byWidget(center), matching: cardFinder),
        );
        expect(card.margin!.horizontal, 40);
        expect(card.margin!.vertical, 40);
        expect(
          find.descendant(
            of: find.byWidget(card),
            matching: singleChildScrollViewFinder,
          ),
          findsOneWidget,
        );
        Padding padding = tester.widget(
          find.descendant(
            of: singleChildScrollViewFinder,
            matching: find.byKey(const Key("paddingAroundColumn")),
          ),
        );
        expect(padding.padding.horizontal, 32);
        expect(padding.padding.vertical, 32);
        Form form = tester.widget(
          find.descendant(of: find.byWidget(padding), matching: formFinder),
        );
        Column column = tester.widget(
          find.descendant(
            of: find.byWidget(form),
            matching: find.byKey(const Key('column')),
          ),
        );
        expect(column.mainAxisAlignment, MainAxisAlignment.center);
        final TextField fieldListNameTextField =
            tester.widget(
                  find.descendant(
                    of: find.byWidget(column),
                    matching: find.descendant(
                      of: find.byType(TextFormField),
                      matching: find.byType(TextField),
                    ),
                  ),
                )
                as TextField;
        expect(
          (fieldListNameTextField.decoration!.label as Text).data,
          expectedFieldListNameString,
        );
        expect(fieldListNameTextField.keyboardType, TextInputType.text);
        expect(fieldListNameTextField.textInputAction, TextInputAction.next);
        expect(fieldListNameTextField.autofocus, isTrue);
        SizedBox sizedBoxBetweenTextFormFieldAndDropDownMenuFormField = tester
            .widget(
              find.descendant(
                of: find.byWidget(column),
                matching: find.byKey(
                  Key("sizedBoxBetweenTextFormFieldAndDropdownMenuFormField"),
                ),
              ),
            );
        expect(
          sizedBoxBetweenTextFormFieldAndDropDownMenuFormField.height!,
          25,
        );
        final DropdownMenuFormField<CheckType> checkTypeDropdownMenuFormField =
            tester.widget(
              find.descendant(
                of: find.byWidget(column),
                matching: find.byType(DropdownMenuFormField<CheckType>),
              ),
            );
        final DropdownMenu<CheckType> checkTypeDropdownMenu = tester.widget(
          find.descendant(
            of: find.byWidget(checkTypeDropdownMenuFormField),
            matching: find.byType(DropdownMenu<CheckType>),
          ),
        );
        TextField checkTypeTextField = tester.widget(
          find.descendant(
            of: find.byWidget(checkTypeDropdownMenuFormField),
            matching: find.byType(TextField),
          ),
        );
        expect(
          checkTypeDropdownMenuFormField.initialValue,
          CheckType.NON_STRICT_IGNORE_CASE,
        );
        expect((checkTypeDropdownMenu.label as Text).data, "Select check type");
        expect(checkTypeDropdownMenu.helperText, "How app checks your answers");
        expect(checkTypeTextField.maxLines, 2);
        Text checkType1Text = tester.widget(
          find.text("Do not check letter case or space").at(1),
        );
        Text checkType2Text = tester.widget(
          find.text(doNotCheckLetterCaseString),
        );
        Text checkType3Text = tester.widget(find.text("Do not check space"));
        Text checkType4Text = tester.widget(
          find.text("Check both letter case and space"),
        );
        expect(
          find.descendant(
            of: find.byWidget(checkTypeDropdownMenuFormField),
            matching: find.byWidget(checkType1Text),
          ),
          findsOne,
        );
        expect(
          find.descendant(
            of: find.byWidget(checkTypeDropdownMenuFormField),
            matching: find.byWidget(checkType2Text),
          ),
          findsOne,
        );
        expect(
          find.descendant(
            of: find.byWidget(checkTypeDropdownMenuFormField),
            matching: find.byWidget(checkType3Text),
          ),
          findsOne,
        );
        expect(
          find.descendant(
            of: find.byWidget(checkTypeDropdownMenuFormField),
            matching: find.byWidget(checkType4Text),
          ),
          findsOne,
        );
        SizedBox sizedBoxBetweenDropDownMenuFormFieldAndCheckboxListTile =
            tester.widget(
              find.descendant(
                of: find.byWidget(column),
                matching: find.byKey(
                  Key(
                    "sizedBoxBetweenDropdownMenuFormFieldAndCheckboxListTile",
                  ),
                ),
              ),
            );
        expect(
          sizedBoxBetweenDropDownMenuFormFieldAndCheckboxListTile.height!,
          25,
        );
        Checkbox readAnswerCheckBox = tester.widget(
          find.descendant(
            of: find.byWidget(column),
            matching: find.descendant(
              of: find.byType(CheckboxListTile),
              matching: find.byType(Checkbox),
            ),
          ),
        );
        expect(readAnswerCheckBox.value, isFalse);
        ListTile readAnswerLisTile = tester.widget(
          find.descendant(
            of: find.byWidget(column),
            matching: find.descendant(
              of: find.byType(CheckboxListTile),
              matching: find.byType(ListTile),
            ),
          ),
        );
        expect((readAnswerLisTile.title as Text).data, "Read answer");
        expect(
          (readAnswerLisTile.subtitle as Text).data,
          "When you answer correctly!",
        );
        SizedBox sizedBoxBetweenCheckboxListTileAndPickColor = tester.widget(
          find.descendant(
            of: find.byWidget(column),
            matching: find.byKey(
              Key("sizedBoxBetweenCheckboxListTileAndPickColor"),
            ),
          ),
        );
        expect(sizedBoxBetweenCheckboxListTileAndPickColor.height!, 25);
        SizedBox sizedBoxBetweenCheckboxListTileAndOkCancel = tester.widget(
          find.descendant(
            of: find.byWidget(column),
            matching: find.byKey(
              Key("sizedBoxBetweenCheckboxListTileAndOkCancel"),
            ),
          ),
        );
        expect(sizedBoxBetweenCheckboxListTileAndPickColor.height!, 25);
        expect(
          checkWidgetsOrder(column.children.toList(), [
            tester.widget(find.byType(TextFormField)),
            sizedBoxBetweenTextFormFieldAndDropDownMenuFormField,
            checkTypeDropdownMenuFormField,
            sizedBoxBetweenDropDownMenuFormFieldAndCheckboxListTile,
            tester.widget(find.byType(CheckboxListTile)),
            sizedBoxBetweenCheckboxListTileAndPickColor,
            tester.widget(find.byType(PickColor)),
            sizedBoxBetweenCheckboxListTileAndOkCancel,
            tester.widget(find.byType(OkCancel)),
          ]),
          isTrue,
        );
      });

      testWidgets('field list name text field validation', (
        WidgetTester tester,
      ) async {
        await _createCreateFieldListPageViewInASkeleton(
          tester,
          currentLocale,
          goRouter,
          createFieldListUsecase,
          createFieldListBloc,
        );
        ElevatedButton okButton = tester.widget(
          find.byKey(const Key('okButton')),
        );
        final Finder nameValidationErrorTextFinder = find.descendant(
          of: textFormFieldFinder,
          matching: find.text(expectedInvalidNameString),
        );
        expect(nameValidationErrorTextFinder, findsNothing);
        expect(okButton.enabled, isFalse);
        await tester.enterText(
          textFormFieldFinder,
          'r' * (FieldLists.MAXIMUM_LENGTH_OF_NAME + 1),
        );
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsOne);
        okButton = tester.widget(find.byKey(const Key('okButton')));
        expect(okButton.enabled, isFalse);
        await tester.enterText(
          textFormFieldFinder,
          '${'r' * FieldLists.MAXIMUM_LENGTH_OF_NAME} ',
        );
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsNothing);
        okButton = tester.widget(find.byKey(const Key('okButton')));
        expect(okButton.enabled, isTrue);
        await tester.enterText(textFormFieldFinder, fieldListName);
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsNothing);
        okButton = tester.widget(find.byKey(const Key('okButton')));
        expect(okButton.enabled, isTrue);
        await tester.enterText(textFormFieldFinder, ' ');
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsOne);
        okButton = tester.widget(find.byKey(const Key('okButton')));
        expect(okButton.enabled, isFalse);
        await tester.enterText(textFormFieldFinder, '');
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsOne);
        okButton = tester.widget(find.byKey(const Key('okButton')));
        expect(okButton.enabled, isFalse);
      });

      testWidgets('Entring a valid name adds an event to the bloc', (
        WidgetTester tester,
      ) async {
        await _createCreateFieldListPageViewInASkeleton(
          tester,
          currentLocale,
          goRouter,
          createFieldListUsecase,
          createFieldListBloc,
        );
        await tester.enterText(find.byType(TextFormField), fieldListName);
        verify(
          () => createFieldListBloc.add(
            CreateFieldListNameChanged(fieldListName),
          ),
        ).called(1);
      });

      testWidgets('Entring an invalid name adds an event to the bloc', (
        WidgetTester tester,
      ) async {
        await _createCreateFieldListPageViewInASkeleton(
          tester,
          currentLocale,
          goRouter,
          createFieldListUsecase,
          createFieldListBloc,
        );
        await tester.enterText(
          find.byType(TextFormField),
          (fieldListName * 64),
        );
        verifyNever(
          () => createFieldListBloc.add(
            any(that: isA<CreateFieldListNameChanged>()),
          ),
        );
      });

      testWidgets('clicking the CheckboxListTile adds an event to the bloc', (
        WidgetTester tester,
      ) async {
        await _createCreateFieldListPageViewInASkeleton(
          tester,
          currentLocale,
          goRouter,
          createFieldListUsecase,
          createFieldListBloc,
        );
        await tester.tap(find.byType(CheckboxListTile));
        verify(
          () => createFieldListBloc.add(
            const CreateFieldListReadAnswerChanged(true),
          ),
        ).called(1);
      });

      testWidgets('Selecting a CheckType adds an event to the bloc', (
        WidgetTester tester,
      ) async {
        await _createCreateFieldListPageViewInASkeleton(
          tester,
          currentLocale,
          goRouter,
          createFieldListUsecase,
          createFieldListBloc,
        );
        await tester.tap(find.byType(DropdownMenu<CheckType>));
        await tester.pumpAndSettle();
        await tester.tap(find.text(doNotCheckLetterCaseString).last);
        await tester.pumpAndSettle();
        verify(
          () => createFieldListBloc.add(
            const CreateFieldListCheckTypeChanged(CheckType.IGNORE_CASE),
          ),
        ).called(1);
      });

      //Could not to test picking a color calls the bloc add()
      //I will try to test it in the integration test

      testWidgets('Clicking ok adds an event to the bloc', (
        WidgetTester tester,
      ) async {
        whenListen<CreateFieldListState>(
          createFieldListBloc,
          Stream.fromIterable([
            CreateFieldListState(
              status: CreateFieldListStatus.initial,
              fieldId: fieldId,
            ),
            CreateFieldListState(
              status: CreateFieldListStatus.loading,
              fieldId: fieldId,
            ),
            CreateFieldListState(
              status: CreateFieldListStatus.success,
              fieldId: fieldId,
            ),
          ]),
        );
        await _createCreateFieldListPageViewInASkeleton(
          tester,
          currentLocale,
          goRouter,
          createFieldListUsecase,
          createFieldListBloc,
        );
        //To enable the ok button
        await tester.enterText(find.byType(TextFormField), fieldListName);
        await tester.pumpAndSettle();
        await tester.tap(find.byKey(const Key('okButton')));
        verify(
          () => createFieldListBloc.add(const CreateFieldListSubmitted()),
        ).called(1);
        verify(() => goRouter.go('$fieldListsPath$fieldId')).called(1);
      });

      testWidgets('Clicking cancel adds goes to FieldListsPage', (
        WidgetTester tester,
      ) async {
        await _createCreateFieldListPageViewInASkeleton(
          tester,
          currentLocale,
          goRouter,
          createFieldListUsecase,
          createFieldListBloc,
        );
        await tester.tap(find.byKey(const Key('cancelButton')));
        verify(() => goRouter.go('$fieldListsPath$fieldId')).called(1);
      });
    });
  });
}
