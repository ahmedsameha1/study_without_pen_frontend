import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/create_field_list_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/create_field_list_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/pages/create_field_list_page.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart'
    as nonso;

class MockGoRouter extends Mock implements GoRouter {}

class MockCreateFieldListUsecase extends Mock
    implements CreateFieldListUsecase {}

//class MockCreateFieldListBloc extends MockBloc<CreateFieldListEvent, CreateFieldListState> implements CreateFieldListBloc{}

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

void main() {
  String fieldId = "woeghweo";
  String fieldListName = "field list name";
  CheckType checkType = CheckType.NON_STRICT_IGNORE_CASE;
  bool readAnswer = false;
  int color = Colors.white.toARGB32();
  GoRouter goRouter = MockGoRouter();

  late CreateFieldListUsecase createFieldListUsecase;

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
      });
    });
  });
}
