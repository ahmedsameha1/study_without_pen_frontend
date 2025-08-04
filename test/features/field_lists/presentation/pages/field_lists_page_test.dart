import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_state.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/pages/field_lists_page.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart'
    as nonso;
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

import '../../../common/common_finders.dart';

class MockGoRouter extends Mock implements GoRouter {}

class MockWatchFieldUseCase extends Mock implements WatchFieldUsecase {}

class MockFieldListsBloc extends MockBloc<FieldListsEvent, FieldListsState>
    implements FieldListsBloc {}

Future<void> _createFieldListPageInASkeleton(
    WidgetTester tester,
    Locale locale,
    GoRouter goRouter,
    WatchFieldUsecase watchFieldUsecase,
    String fieldId) async {
  await tester.pumpWidget(RepositoryProvider.value(
    value: watchFieldUsecase,
    child: MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          nonso.AppLocalizations.delegate
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: InheritedGoRouter(
            goRouter: goRouter, child: FieldListsPage(fieldId))),
  ));
}

Future<void> _createFieldListPageInASkeletonB(
    WidgetTester tester,
    MockNavigator navigator,
    Locale locale,
    WatchFieldUsecase watchFieldUsecase,
    FieldListsBloc fieldListsBloc) async {
  await tester.pumpWidget(RepositoryProvider.value(
      value: watchFieldUsecase,
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
                  value: fieldListsBloc, child: const FieldListsPageView())))));
}

void main() {
  FieldEntity mockFieldEntity = FieldEntity('oweoweyhfwo', 'wgohwoegh',
      'field name', DateTime(2020, 1, 1), DateTime(2020, 1, 1), 0, 0xff520404);
  late WatchFieldUsecase watchFieldUsecase;
  late GoRouter goRouter = MockGoRouter();

  group("English locale", () {
    Locale currentLocale = const Locale("en");

    group('FieldListsPage', () {
      setUp(() {
        watchFieldUsecase = MockWatchFieldUseCase();
        when(() => watchFieldUsecase.call(mockFieldEntity.id!))
            .thenAnswer((_) => Stream.value(mockFieldEntity));
      });
      testWidgets("Test the presence of FieldListsPageView widget",
          (WidgetTester tester) async {
        await _createFieldListPageInASkeleton(tester, currentLocale, goRouter,
            watchFieldUsecase, mockFieldEntity.id!);
        expect(
            find.descendant(
                of: find.byType(FieldListsPage),
                matching: find.byType(FieldListsPageView)),
            findsOne);
      });

      testWidgets('Test calling watchFieldUsecase.call() on initialization',
          (WidgetTester tester) async {
        await _createFieldListPageInASkeleton(tester, currentLocale, goRouter,
            watchFieldUsecase, mockFieldEntity.id!);
        verify(() => watchFieldUsecase.call(mockFieldEntity.id!)).called(1);
      });
    });

    group('FieldListsPageView', () {
      late MockNavigator navigator;
      late FieldListsBloc fieldListsBloc;
      String expectedErrorString = "An error occurred while loading the data!";

      setUp(() {
        navigator = MockNavigator();
        when(() => navigator.canPop()).thenReturn(false);
        when(() => navigator.push<void>(any())).thenAnswer((_) async {});
        fieldListsBloc = MockFieldListsBloc();
        when(() => fieldListsBloc.state)
            .thenReturn(FieldListsState(FieldListsStatus.loading));
        watchFieldUsecase = MockWatchFieldUseCase();
        when(() => watchFieldUsecase.call(mockFieldEntity.id!))
            .thenAnswer((_) => Stream.value(mockFieldEntity));
      });

      testWidgets(
        "Test the presence of the main widgets when there is at least one fieldlist",
        (WidgetTester tester) async {
          whenListen<FieldListsState>(
              fieldListsBloc,
              Stream.fromIterable([
                FieldListsState(FieldListsStatus.loading),
                FieldListsState(FieldListsStatus.success, mockFieldEntity.name)
              ]));
          await _createFieldListPageInASkeletonB(tester, navigator,
              currentLocale, watchFieldUsecase, fieldListsBloc);
          expect(
              find.descendant(
                  of: find.byType(FieldListsPageView),
                  matching: find.descendant(
                      of: centerFinder,
                      matching: circularProgressIndicatorFinder)),
              findsOne);
          await tester.pump();
          expect(
              find.descendant(
                  of: find.byType(FieldListsPageView),
                  matching: scaffoldFinder),
              findsOne);
          expect(appBarFinder, findsOne);
          AppBar appBar = tester.widget<AppBar>(appBarFinder);
          expect((appBar.title as Text).data, mockFieldEntity.name);
        },
      );

      testWidgets(
        "Test the presence of the main widgets when the status of the state is failure",
        (WidgetTester tester) async {
          whenListen<FieldListsState>(
              fieldListsBloc,
              Stream.fromIterable([
                FieldListsState(FieldListsStatus.loading),
                FieldListsState(FieldListsStatus.failure)
              ]));
          await _createFieldListPageInASkeletonB(tester, navigator,
              currentLocale, watchFieldUsecase, fieldListsBloc);
          expect(
              find.descendant(
                  of: find.byType(FieldListsPageView),
                  matching: find.descendant(
                      of: centerFinder,
                      matching: circularProgressIndicatorFinder)),
              findsOne);
          await tester.pump();
          expect(
              find.descendant(
                  of: find.byType(FieldListsPageView),
                  matching: find.descendant(
                      of: centerFinder,
                      matching: find.text(expectedErrorString))),
              findsOne);
        },
      );
    });
  });
}
