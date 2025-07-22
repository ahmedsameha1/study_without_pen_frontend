import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/pages/field_lists_page.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart'
    as nonso;
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

import '../../../common/common_finders.dart';

class MockGoRouter extends Mock implements GoRouter {}

class MockWatchFieldUseCase extends Mock implements WatchFieldUsecase {}

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
  late WatchFieldUsecase watchFieldUsecase;
  late GoRouter goRouter = MockGoRouter();
  String fieldId = 'weoghwoeg';
  String fieldName = "field name";
  final usageCount = 0;
  int color = 0xff520404;
  DateTime creationAt = DateTime(2020, 1, 1);
  final userAccountId = "fwefhwo";
  setUp(() {
    //when(() => goRouter.push(any())).thenAnswer((_) => Future.value(null));
    watchFieldUsecase = MockWatchFieldUseCase();
  });
  group("English locale", () {
    Locale currentLocale = const Locale("en");
    testWidgets(
      "Test the presence of the main widgets when there is at least one fieldlist",
      (WidgetTester tester) async {
        when(() => watchFieldUsecase.call(fieldId)).thenAnswer((_) =>
            Stream.value(FieldEntity(fieldId, userAccountId, fieldName,
                creationAt, creationAt, usageCount, color)));
        await _createFieldListPageInASkeleton(tester, currentLocale, goRouter,
            watchFieldUsecase, FieldListsPage(fieldId));
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
        expect((appBar.title as Text).data, fieldName);
      },
    );
  });
}
