import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
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
    Widget widget) async {
  await tester.pumpWidget(RepositoryProvider.value(
    value: watchFieldUsecase,
    child: MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          nonso.AppLocalizations.delegate
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: InheritedGoRouter(goRouter: goRouter, child: widget)),
  ));
}

void main() {
  FieldEntity mockFieldEntity = FieldEntity('oweoweyhfwo', 'wgohwoegh',
      'field name', DateTime(2020, 1, 1), DateTime(2020, 1, 1), 0, 0xff520404);
  late WatchFieldUsecase watchFieldUsecase;
  late GoRouter goRouter = MockGoRouter();
  setUp(() {
    //when(() => goRouter.push(any())).thenAnswer((_) => Future.value(null));
    watchFieldUsecase = MockWatchFieldUseCase();
    when(() => watchFieldUsecase.call(mockFieldEntity.id!))
        .thenAnswer((_) => Stream.value(mockFieldEntity));
  });
  group("English locale", () {
    Locale currentLocale = const Locale("en");
    group('FieldListsPage', () {
      testWidgets("Test the presence of FieldListsPageView widget",
          (WidgetTester tester) async {
        await _createFieldListPageInASkeleton(tester, currentLocale, goRouter,
            watchFieldUsecase, FieldListsPage(mockFieldEntity.id!));
        expect(
            find.descendant(
                of: find.byType(FieldListsPage),
                matching: find.byType(FieldListsPageView)),
            findsOne);
      });

      testWidgets('Test calling watchFieldUsecase.call() on initialization',
          (WidgetTester tester) async {
        await _createFieldListPageInASkeleton(tester, currentLocale, goRouter,
            watchFieldUsecase, FieldListsPage(mockFieldEntity.id!));
        verify(() => watchFieldUsecase.call(mockFieldEntity.id!)).called(1);
      });
    });

    group('FieldListsPageView', () {
      testWidgets(
        "Test the presence of the main widgets when there is at least one fieldlist",
        (WidgetTester tester) async {
          when(() => watchFieldUsecase.call(mockFieldEntity.id!))
              .thenAnswer((_) => Stream.value(mockFieldEntity));
          await _createFieldListPageInASkeleton(tester, currentLocale, goRouter,
              watchFieldUsecase, FieldListsPage(mockFieldEntity.id!));
          expect(find.byType(FieldListsPage), findsOne);
          expect(
              find.descendant(
                  of: find.byType(FieldListsPage),
                  matching: find.descendant(
                      of: centerFinder,
                      matching: circularProgressIndicatorFinder)),
              findsOne);
          await tester.pump();
          expect(
              find.descendant(
                  of: find.byType(FieldListsPage), matching: scaffoldFinder),
              findsOne);
          expect(appBarFinder, findsOne);
          AppBar appBar = tester.widget<AppBar>(appBarFinder);
          expect((appBar.title as Text).data, mockFieldEntity.name);
        },
      );
    });
  });
}
