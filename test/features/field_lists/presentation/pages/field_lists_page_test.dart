import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockingjay/mockingjay.dart';
import 'package:study_without_pen_by_flutter/common/router_config.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_list_entity.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_lists_page_data.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/watch_field_lists_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_bloc.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_event.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/bloc/field_lists_state.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/pages/create_field_list_page.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/pages/field_lists_page.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart'
    as nonso;
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

import '../../../common/common_finders.dart';

class MockGoRouter extends Mock implements GoRouter {}

class MockWatchFieldUseCase extends Mock implements WatchFieldUsecase {}

class MockWatchFieldListsUseCase extends Mock
    implements WatchFieldListsUsecase {}

class MockFieldListsBloc extends MockBloc<FieldListsEvent, FieldListsState>
    implements FieldListsBloc {}

Future<void> _createFieldListPageInASkeleton(
    WidgetTester tester,
    Locale locale,
    GoRouter goRouter,
    WatchFieldListsUsecase watchFieldListsUsecase,
    String fieldId) async {
  await tester.pumpWidget(
    RepositoryProvider.value(
      value: watchFieldListsUsecase,
      child: MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            nonso.AppLocalizations.delegate
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: locale,
          home: InheritedGoRouter(
              goRouter: goRouter, child: FieldListsPage(fieldId))),
    ),
  );
}

Future<void> _createFieldListPageViewInASkeleton(
    WidgetTester tester,
    MockNavigator navigator,
    Locale locale,
    WatchFieldListsUsecase watchFieldListsUsecase,
    FieldListsBloc fieldListsBloc) async {
  await tester.pumpWidget(RepositoryProvider.value(
      value: watchFieldListsUsecase,
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
  List<FieldListEntity> mockFieldListEntities = [
    FieldListEntity(
        id: 'wofhweohg',
        fieldId: mockFieldEntity.id!,
        name: "field list name 1",
        creationAt: DateTime(2020),
        lastModificationAt: DateTime(2020),
        color: Colors.red.toARGB32()),
    FieldListEntity(
        id: 'e3wngwgpwertpweortk',
        fieldId: mockFieldEntity.id!,
        name: 'field list name 2',
        creationAt: DateTime(2021),
        lastModificationAt: DateTime(2021),
        color: 0xff520404),
    FieldListEntity(
        id: 'weofwheofhweofjwelfmwofise',
        fieldId: mockFieldEntity.id!,
        name: 'field list name 3',
        creationAt: DateTime(2022),
        lastModificationAt: DateTime(2022),
        color: 0xffffffff)
  ];
  FieldListsPageData mockFieldListsPageData = FieldListsPageData(
      field: mockFieldEntity, fieldLists: mockFieldListEntities);
  late WatchFieldListsUsecase watchFieldListsUsecase;
  late GoRouter goRouter = MockGoRouter();

  group("English locale", () {
    Locale currentLocale = const Locale("en");

    group('FieldListsPage', () {
      setUp(() {
        watchFieldListsUsecase = MockWatchFieldListsUseCase();
        when(() => watchFieldListsUsecase.call(mockFieldEntity.id!))
            .thenAnswer((_) => Stream.value(mockFieldListsPageData));
      });
      testWidgets("Test the presence of FieldListsPageView widget",
          (WidgetTester tester) async {
        await _createFieldListPageInASkeleton(tester, currentLocale, goRouter,
            watchFieldListsUsecase, mockFieldEntity.id!);
        expect(
            find.descendant(
                of: find.byType(FieldListsPage),
                matching: find.byType(FieldListsPageView)),
            findsOne);
      });

      testWidgets('Test calling watchFieldUsecase.call() on initialization',
          (WidgetTester tester) async {
        await _createFieldListPageInASkeleton(tester, currentLocale, goRouter,
            watchFieldListsUsecase, mockFieldEntity.id!);
        verify(() => watchFieldListsUsecase.call(mockFieldEntity.id!))
            .called(1);
      });
    });

    group('FieldListsPageView', () {
      late MockNavigator navigator;
      late FieldListsBloc fieldListsBloc;
      String expectedNoFieldListsString = "Currently, there are no lists!";
      String expectedErrorString = "An error occurred while loading the data!";

      setUp(() {
        navigator = MockNavigator();
        when(() => navigator.canPop()).thenReturn(false);
        when(() => navigator.push<void>(any())).thenAnswer((_) async {});
        fieldListsBloc = MockFieldListsBloc();
        when(() => fieldListsBloc.state)
            .thenReturn(FieldListsState(status: FieldListsStatus.loading));
        watchFieldListsUsecase = MockWatchFieldListsUseCase();
        when(() => watchFieldListsUsecase.call(mockFieldEntity.id!))
            .thenAnswer((_) => Stream.value(mockFieldListsPageData));
      });

      testWidgets(
        "Test the presence of the main widgets when there is at least one fieldlist",
        (WidgetTester tester) async {
          whenListen<FieldListsState>(
              fieldListsBloc,
              Stream.fromIterable([
                FieldListsState(status: FieldListsStatus.loading),
                FieldListsState(
                    status: FieldListsStatus.success,
                    fieldListsPageData: mockFieldListsPageData),
              ]));
          await _createFieldListPageViewInASkeleton(tester, navigator,
              currentLocale, watchFieldListsUsecase, fieldListsBloc);
          expect(
              find.descendant(
                  of: find.byType(FieldListsPageView),
                  matching: find.descendant(
                      of: scaffoldFinder,
                      matching: find.descendant(
                          of: centerFinder,
                          matching: circularProgressIndicatorFinder))),
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
          FloatingActionButton floatingActionButton = tester.widget(
              find.descendant(
                  of: scaffoldFinder,
                  matching: find.byType(FloatingActionButton)));
          Icon addIcon = floatingActionButton.child as Icon;
          expect(addIcon.icon, Icons.add);
          Scrollbar scrollbar = tester.widget(find.descendant(
              of: scaffoldFinder, matching: find.byType(Scrollbar)));
          expect(scrollbar.thumbVisibility, isTrue);
          expect(scrollbar.trackVisibility, isTrue);
          expect(scrollbar.interactive, isTrue);
          expect(scrollbar.thickness, 10);
          expect(scrollbar.radius, const Radius.circular(8.0));
          MasonryGridView masonryGridView = tester.widget(find.descendant(
              of: find.byWidget(scrollbar),
              matching: find.byType(MasonryGridView)));
          expect(masonryGridView.padding, const EdgeInsets.all(10.0));
          expect(masonryGridView.crossAxisSpacing, 5);
          expect(masonryGridView.mainAxisSpacing, 5);
          expect(
              find.descendant(
                  of: find.byWidget(masonryGridView), matching: cardFinder),
              findsNWidgets(3));
          Card firstCard = tester.widget<Card>(find.descendant(
              of: find.byType(MasonryGridView),
              matching: find.byType(Card).at(0)));
          expect(firstCard.color, Color(mockFieldListEntities[0].color));
          expect(firstCard.elevation, 2);
          Padding firstPadding = tester.widget(
            find.descendant(
                of: find.byWidget(firstCard),
                matching: find.byKey(Key('cardContentPadding'))),
          );
          expect(firstPadding.padding, const EdgeInsets.all(10.0));
          Center firstCenter = tester.widget(
            find.descendant(
                of: find.byWidget(firstPadding), matching: centerFinder),
          );
          expect(
              (firstCenter.child as Text).data, mockFieldListEntities[0].name);
          Text firstText = firstCenter.child as Text;
          expect(firstText.style!.color, Colors.white);
          Card secondCard = tester.widget<Card>(find.descendant(
              of: find.byType(MasonryGridView),
              matching: find.byType(Card).at(1)));
          expect(secondCard.color, Color(mockFieldListEntities[1].color));
          expect(secondCard.elevation, 2);
          Padding secondPadding = tester.widget(
            find.descendant(
                of: find.byWidget(secondCard),
                matching: find.byKey(Key('cardContentPadding'))),
          );
          expect(secondPadding.padding, const EdgeInsets.all(10.0));
          Center secondCenter = tester.widget(
            find.descendant(
                of: find.byWidget(secondPadding), matching: centerFinder),
          );
          expect(
              (secondCenter.child as Text).data, mockFieldListEntities[1].name);
          Text secondText = secondCenter.child as Text;
          expect(secondText.style!.color, Colors.white);
          Card thirdCard = tester.widget<Card>(find.descendant(
              of: find.byType(MasonryGridView),
              matching: find.byType(Card).at(2)));
          expect(thirdCard.color, Color(mockFieldListEntities[2].color));
          expect(thirdCard.elevation, 2);
          Padding thirdPadding = tester.widget(
            find.descendant(
                of: find.byWidget(thirdCard),
                matching: find.byKey(Key('cardContentPadding'))),
          );
          expect(thirdPadding.padding, const EdgeInsets.all(10.0));
          Center thirdCenter = tester.widget(
            find.descendant(
                of: find.byWidget(thirdPadding), matching: centerFinder),
          );
          expect(
              (thirdCenter.child as Text).data, mockFieldListEntities[2].name);
          Text thirdText = thirdCenter.child as Text;
          expect(thirdText.style!.color, Colors.black);
        },
      );

      testWidgets(
          "Test the presence of the main widgets when there is no fieldlists",
          (WidgetTester tester) async {
        whenListen<FieldListsState>(
            fieldListsBloc,
            Stream.fromIterable([
              FieldListsState(status: FieldListsStatus.loading),
              FieldListsState(
                  status: FieldListsStatus.success,
                  fieldListsPageData: FieldListsPageData(
                      field: mockFieldListsPageData.field, fieldLists: [])),
            ]));
        await _createFieldListPageViewInASkeleton(tester, navigator,
            currentLocale, watchFieldListsUsecase, fieldListsBloc);
        expect(
            find.descendant(
                of: find.byType(FieldListsPageView),
                matching: find.descendant(
                    of: scaffoldFinder,
                    matching: find.descendant(
                        of: centerFinder,
                        matching: circularProgressIndicatorFinder))),
            findsOne);
        await tester.pump();
        expect(
            find.descendant(
                of: find.byType(FieldListsPageView), matching: scaffoldFinder),
            findsOne);
        expect(appBarFinder, findsOne);
        AppBar appBar = tester.widget<AppBar>(appBarFinder);
        expect((appBar.title as Text).data, mockFieldEntity.name);
        FloatingActionButton floatingActionButton = tester.widget(
            find.descendant(
                of: scaffoldFinder,
                matching: find.byType(FloatingActionButton)));
        Icon addIcon = floatingActionButton.child as Icon;
        expect(addIcon.icon, Icons.add);
        expect(
            find.descendant(
                of: find.byType(FieldListsPageView),
                matching: find.descendant(
                    of: scaffoldFinder,
                    matching: find.descendant(
                        of: centerFinder,
                        matching: find.text(expectedNoFieldListsString)))),
            findsOne);
      });

      testWidgets(
        "Test the presence of the main widgets when the status of the state is failure",
        (WidgetTester tester) async {
          whenListen<FieldListsState>(
              fieldListsBloc,
              Stream.fromIterable([
                FieldListsState(status: FieldListsStatus.loading),
                FieldListsState(status: FieldListsStatus.failure)
              ]));
          await _createFieldListPageViewInASkeleton(tester, navigator,
              currentLocale, watchFieldListsUsecase, fieldListsBloc);
          expect(
              find.descendant(
                  of: find.byType(FieldListsPageView),
                  matching: find.descendant(
                      of: scaffoldFinder,
                      matching: find.descendant(
                          of: centerFinder,
                          matching: circularProgressIndicatorFinder))),
              findsOne);
          await tester.pump();
          expect(
              find.descendant(
                  of: find.byType(FieldListsPageView),
                  matching: find.descendant(
                      of: scaffoldFinder,
                      matching: find.descendant(
                          of: centerFinder,
                          matching: find.text(expectedErrorString)))),
              findsOne);
          FloatingActionButton floatingActionButton = tester.widget(
              find.descendant(
                  of: scaffoldFinder,
                  matching: find.byType(FloatingActionButton)));
          Icon addIcon = floatingActionButton.child as Icon;
          expect(addIcon.icon, Icons.add);
        },
      );
      // Clicking the FLoattingActionButton that should open the CreateFieldListPage is not tested
      // Currently tested using integration tests
    });
  });
}
