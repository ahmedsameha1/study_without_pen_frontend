import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockingjay/mockingjay.dart';
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
    String fieldId) async {
  await tester.pumpWidget(
    RepositoryProvider.value(
      value: createFieldListUsecase,
      child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            nonso.AppLocalizations.delegate
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: locale,
          home: InheritedGoRouter(
              goRouter: goRouter,
              child: CreateFieldListPage(fieldId: fieldId))),
    ),
  );
}

Future<void> _createCreateFieldListPageViewInASkeleton(
    WidgetTester tester,
    Locale locale,
    MockNavigator navigator,
    CreateFieldListUsecase createFieldListUsecase,
    CreateFieldListBloc createFieldListBloc) async {
  return tester.pumpWidget(RepositoryProvider.value(
    value: createFieldListUsecase,
    child: MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          nonso.AppLocalizations.delegate
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: MockNavigatorProvider(
            navigator: navigator,
            child: BlocProvider.value(
              value: createFieldListBloc,
              child: const CreateFieldListPageView(),
            ))),
  ));
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

    group('CreateFieldListPage', () {
      setUp(() {
        createFieldListUsecase = MockCreateFieldListUsecase();
        when(
          () => createFieldListUsecase.call(
              fieldId, fieldListName, checkType, readAnswer, color),
        ).thenAnswer((_) => Future.value(1));
      });

      testWidgets('Test the precense of CreateFieldListPageView',
          (WidgetTester tester) async {
        await _createCreateFieldListPageInASkeleton(
            tester, currentLocale, goRouter, createFieldListUsecase, fieldId);
        expect(
            find.descendant(
                of: find.byType(CreateFieldListPage),
                matching: find.byType(CreateFieldListPageView)),
            findsOne);
      });
    });

    group('CreateFieldListPageView', () {
      late MockNavigator navigator;
      late CreateFieldListBloc createFieldListBloc;
      setUp(() {
        navigator = MockNavigator();
        when(() => navigator.canPop()).thenReturn(false);
        when(() => navigator.push<void>(any())).thenAnswer((_) async {});
        createFieldListBloc = MockCreateFieldListBloc();
        when(() => createFieldListBloc.state)
            .thenReturn(CreateFieldListState());
        createFieldListUsecase = MockCreateFieldListUsecase();
        when(() => createFieldListUsecase.call(
                fieldId, fieldListName, checkType, readAnswer, color))
            .thenAnswer((_) => Future.value(1));
      });

      testWidgets('test the presence of the main widgets',
          (WidgetTester tester) async {
        await _createCreateFieldListPageViewInASkeleton(tester, currentLocale,
            navigator, createFieldListUsecase, createFieldListBloc);
        expect(
            find.descendant(
                of: find.byType(CreateFieldListPageView),
                matching: scaffoldFinder),
            findsOne);
        final appBarFinder =
            find.descendant(of: scaffoldFinder, matching: find.byType(AppBar));
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
                of: find.byWidget(card), matching: singleChildScrollViewFinder),
            findsOneWidget);
        Padding padding = tester.widget(
          find.descendant(
              of: singleChildScrollViewFinder,
              matching: find.byKey(const Key("paddingAroundColumn"))),
        );
        expect(padding.padding.horizontal, 32);
        expect(padding.padding.vertical, 32);
        Form form = tester.widget(
            find.descendant(of: find.byWidget(padding), matching: formFinder));
        Column column = tester.widget(
          find.descendant(of: find.byWidget(form), matching: columnFinder),
        );
        expect(column.mainAxisAlignment, MainAxisAlignment.center);
        final TextField fieldListNameTextField = tester.widget(find.descendant(
            of: find.byWidget(column),
            matching: find.descendant(
                of: find.byType(TextFormField),
                matching: find.byType(TextField)))) as TextField;
        expect((fieldListNameTextField.decoration!.label as Text).data,
            expectedFieldListNameString);
        expect(fieldListNameTextField.keyboardType, TextInputType.text);
        expect(fieldListNameTextField.textInputAction, TextInputAction.next);
        expect(fieldListNameTextField.autofocus, isTrue);
        SizedBox sizedBoxBetweenTextFormFieldAndDropDownMenuFormField =
            tester.widget(find.descendant(
                of: find.byWidget(column),
                matching: find.byKey(Key(
                    "sizedBoxBetweenTextFormFieldAndDropdownMenuFormField"))));
        expect(
            sizedBoxBetweenTextFormFieldAndDropDownMenuFormField.height!, 25);
        final DropdownMenuFormField<CheckType> checkTypeDropdownMenuFormField =
            tester.widget(find.descendant(
                of: find.byWidget(column),
                matching: find.byType(DropdownMenuFormField<CheckType>)));
        final DropdownMenu<CheckType> checkTypeDropdownMenu = tester.widget(
            find.descendant(
                of: find.byWidget(checkTypeDropdownMenuFormField),
                matching: find.byType(DropdownMenu<CheckType>)));
        TextField checkTypeTextField = tester.widget(find.descendant(
            of: find.byWidget(checkTypeDropdownMenuFormField),
            matching: find.byType(TextField)));
        expect(checkTypeDropdownMenuFormField.initialValue,
            CheckType.NON_STRICT_IGNORE_CASE);
        expect((checkTypeDropdownMenu.label as Text).data, "Select check type");
        expect(checkTypeDropdownMenu.helperText, "How app checks your answers");
        expect(checkTypeTextField.maxLines, 2);
        Text checkType1Text =
            tester.widget(find.text("Do not check letter case or space").at(1));
        Text checkType2Text =
            tester.widget(find.text("Do not check letter case"));
        Text checkType3Text = tester.widget(find.text("Do not check space"));
        Text checkType4Text =
            tester.widget(find.text("Check both letter case and space"));
        expect(
            find.descendant(
                of: find.byWidget(checkTypeDropdownMenuFormField),
                matching: find.byWidget(checkType1Text)),
            findsOne);
        expect(
            find.descendant(
                of: find.byWidget(checkTypeDropdownMenuFormField),
                matching: find.byWidget(checkType2Text)),
            findsOne);
        expect(
            find.descendant(
                of: find.byWidget(checkTypeDropdownMenuFormField),
                matching: find.byWidget(checkType3Text)),
            findsOne);
        expect(
            find.descendant(
                of: find.byWidget(checkTypeDropdownMenuFormField),
                matching: find.byWidget(checkType4Text)),
            findsOne);
        SizedBox sizedBoxBetweenDropDownMenuFormFieldAndCheckboxListTile =
            tester.widget(find.descendant(
                of: find.byWidget(column),
                matching: find.byKey(Key(
                    "sizedBoxBetweenDropdownMenuFormFieldAndCheckboxListTile"))));
        expect(sizedBoxBetweenDropDownMenuFormFieldAndCheckboxListTile.height!,
            25);
        Checkbox readAnswerCheckBox = tester.widget(find.descendant(
            of: find.byWidget(column),
            matching: find.descendant(
                of: find.byType(CheckboxListTile),
                matching: find.byType(Checkbox))));
        expect(readAnswerCheckBox.value, isFalse);
        ListTile readAnswerLisTile = tester.widget(find.descendant(
            of: find.byWidget(column),
            matching: find.descendant(
                of: find.byType(CheckboxListTile),
                matching: find.byType(ListTile))));
        expect((readAnswerLisTile.title as Text).data, "Read answer");
        expect((readAnswerLisTile.subtitle as Text).data, "When you answer correctly!");
      });
    });
  });
}
