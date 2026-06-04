import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/common/router_config.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/delete_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_fields_with_field_lists_count_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/fields_bloc.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/fields_state.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/fields_page.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations_en.dart';

import '../../../common/common_finders.dart';
import '../../../common/widget_testing_helper.dart';

class MockAuthBloc extends Mock implements nonso.AuthBloc {}

class MockFieldsBloc extends Mock implements FieldsBloc {}

class MockWatchFieldsWithFieldListsCountUsecase extends Mock
    implements WatchFieldsWithFieldListsCountUsecase {}

class MockDeleteFieldUsecase extends Mock implements DeleteFieldUsecase {}

class MockGoRouter extends Mock implements GoRouter {}

Future<void> _createFieldsPageInASkeleton(
  WidgetTester tester,
  Locale locale,
  GoRouter goRouter,
  nonso.AuthBloc authBloc,
  WatchFieldsWithFieldListsCountUsecase watchFieldsWithFieldListsCountUsecase,
  DeleteFieldUsecase deleteFieldUsecase,
  String fieldId,
) async {
  await tester.pumpWidget(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authBloc),
        RepositoryProvider.value(value: watchFieldsWithFieldListsCountUsecase),
        RepositoryProvider.value(value: deleteFieldUsecase),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          nonso.AppLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: InheritedGoRouter(goRouter: goRouter, child: const FieldsPage()),
      ),
    ),
  );
}

Future<void> _createFieldsPageViewInASkeleton(
  WidgetTester tester,
  Locale locale,
  GoRouter goRouter,
  nonso.AuthBloc authBloc,
  WatchFieldsWithFieldListsCountUsecase watchFieldsWithFieldListsCountUsecase,
  DeleteFieldUsecase deleteFieldUsecase,
  FieldsBloc fieldsBloc,
) async {
  await tester.pumpWidget(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authBloc),
        RepositoryProvider.value(value: watchFieldsWithFieldListsCountUsecase),
        RepositoryProvider.value(value: deleteFieldUsecase),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          nonso.AppLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: InheritedGoRouter(
          goRouter: goRouter,
          child: BlocProvider.value(
            value: fieldsBloc,
            child: const FieldsPageView(),
          ),
        ),
      ),
    ),
  );
}

void main() {
  late WatchFieldsWithFieldListsCountUsecase
  watchFieldsWithFieldListsCountUsecase;
  late DeleteFieldUsecase deleteFieldUsecase;
  late GoRouter goRouter = MockGoRouter();

  String userAccountId = "fwefohwe";
  User user;
  late nonso.AuthBloc authBloc;
  String fieldId1 = "fieldId1";
  String fieldId2 = "fieldId2";
  String fieldId3 = "fieldId3";
  String fieldName1 = "field name 1";
  String fieldName2 = "field name 2";
  String fieldName3 = "field name 3";
  DateTime creationAt1 = DateTime(2020, 1, 1);
  DateTime creationAt2 = DateTime(2021, 1, 1);
  DateTime creationAt3 = DateTime(2022, 1, 1);
  DateTime lastModificationAt1 = DateTime(2020, 6, 6);
  DateTime lastModificationAt2 = creationAt2;
  DateTime lastModificationAt3 = DateTime(2022, 6, 6);
  int usageCount1 = 10;
  int color1 = Colors.red.toARGB32();
  int usageCount2 = 20;
  int color2 = 0xff520404;
  int usageCount3 = 30;
  int color3 = 0xffffffff;
  FieldEntity fieldEntity = FieldEntity(
    fieldId1,
    userAccountId,
    fieldName1,
    creationAt1,
    lastModificationAt1,
    usageCount1,
    color1,
  );
  List<(FieldEntity, int)> fieldsPageData = [(fieldEntity, 3)];

  group('Engish Locale', () {
    Locale currentLocale = const Locale("en");
    String expectedNoFieldsString = "Currently, there are no fields!";
    String expectedErrorString = "An error occurred while loading the fields!";
    String expectedSignOutString = 'Sign out';
    String expectedAboutString = 'About';
    String expectedListsString = 'Lists';

    group('FieldListsPage', () {
      setUp(() {
        user = MockUser();
        authBloc = MockAuthBloc();
        when(() => authBloc.state).thenReturn(
          nonso.AuthState(
            applicationAuthState: nonso.ApplicationAuthState.signedIn,
            user: user,
          ),
        );
        when(
          () => authBloc.signOut(),
        ).thenAnswer((_) => Completer<void>().future);
        when(() => user.uid).thenReturn(userAccountId);
        watchFieldsWithFieldListsCountUsecase =
            MockWatchFieldsWithFieldListsCountUsecase();
        when(
          () => watchFieldsWithFieldListsCountUsecase.call(userAccountId),
        ).thenAnswer((_) => Stream.value(fieldsPageData));
        deleteFieldUsecase = MockDeleteFieldUsecase();
        when(
          () => deleteFieldUsecase.call(fieldEntity.id!),
        ).thenAnswer((_) => Future.value(1));
      });

      testWidgets("Test the presence of FieldsPageView widget", (
        WidgetTester tester,
      ) async {
        await _createFieldsPageInASkeleton(
          tester,
          currentLocale,
          goRouter,
          authBloc,
          watchFieldsWithFieldListsCountUsecase,
          deleteFieldUsecase,
          fieldEntity.id!,
        );
        expect(
          find.descendant(
            of: find.byType(FieldsPage),
            matching: find.byType(FieldsPageView),
          ),
          findsOne,
        );
      });

      testWidgets(
        '''Test calling watchFieldsWithFieldListsCountUsecase.call() on initialization''',
        (WidgetTester tester) async {
          await _createFieldsPageInASkeleton(
            tester,
            currentLocale,
            goRouter,
            authBloc,
            watchFieldsWithFieldListsCountUsecase,
            deleteFieldUsecase,
            fieldEntity.id!,
          );
          verify(
            () => watchFieldsWithFieldListsCountUsecase.call(userAccountId),
          ).called(1);
        },
      );
    });

    group('FieldsPageView', () {
      late FieldsBloc fieldsBloc;
      setUp(() {
        fieldsBloc = MockFieldsBloc();
        when(
          () => fieldsBloc.state,
        ).thenReturn(const FieldsState(FieldsStatus.loading));
      });

      testWidgets(
        'Test the presence of the main widgets when there is at least one field',
        (WidgetTester tester) async {
          whenListen<FieldsState>(
            fieldsBloc,
            Stream.value(
              FieldsState(FieldsStatus.success, [
                (
                  FieldEntity(
                    fieldId1,
                    userAccountId,
                    fieldName1,
                    creationAt1,
                    lastModificationAt1,
                    usageCount1,
                    color1,
                  ),
                  3,
                ),
                (
                  FieldEntity(
                    fieldId2,
                    userAccountId,
                    fieldName2,
                    creationAt2,
                    lastModificationAt2,
                    usageCount2,
                    color2,
                  ),
                  2,
                ),
                (
                  FieldEntity(
                    fieldId3,
                    userAccountId,
                    fieldName3,
                    creationAt3,
                    lastModificationAt3,
                    usageCount3,
                    color3,
                  ),
                  1,
                ),
              ]),
            ),
          );
          await _createFieldsPageViewInASkeleton(
            tester,
            currentLocale,
            goRouter,
            authBloc,
            watchFieldsWithFieldListsCountUsecase,
            deleteFieldUsecase,
            fieldsBloc,
          );
          Scaffold scaffold = tester.widget(
            find.descendant(
              of: find.byType(FieldsPageView),
              matching: scaffoldFinder,
            ),
          );
          final appBarFinder = find.descendant(
            of: scaffoldFinder,
            matching: find.byType(AppBar),
          );
          expect(appBarFinder, findsOneWidget);
          AppBar appBar = tester.widget<AppBar>(appBarFinder);
          Text title = appBar.title as Text;
          expect(title.data, AppLocalizationsEn().materialAppTitle);
          FloatingActionButton floatingActionButton = tester.widget(
            find.descendant(
              of: scaffoldFinder,
              matching: find.byType(FloatingActionButton),
            ),
          );
          Icon addIcon = floatingActionButton.child as Icon;
          expect(addIcon.icon, Icons.add);
          expect(
            find.descendant(
              of: find.byWidget(scaffold),
              matching: find.descendant(
                of: centerFinder,
                matching: find.byType(CircularProgressIndicator),
              ),
            ),
            findsOne,
          );
          await tester.tap(
            find.descendant(
              of: find.byWidget(appBar),
              matching: find.byType(PopupMenuButton<Text>),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.text(expectedSignOutString), findsOne);
          expect(find.text(expectedAboutString), findsOne);
          await tester.runAsync(() async {
            await tester.pump();
            Scrollbar scrollbar = tester.widget(
              find.descendant(
                of: find.byWidget(scaffold),
                matching: find.byType(Scrollbar),
              ),
            );
            expect(scrollbar.thumbVisibility, isTrue);
            expect(scrollbar.trackVisibility, isTrue);
            expect(scrollbar.interactive, isTrue);
            expect(scrollbar.thickness, 10);
            expect(scrollbar.radius, const Radius.circular(8.0));
            MasonryGridView masonryGridView = tester.widget(
              find.descendant(
                of: find.byWidget(scrollbar),
                matching: find.byType(MasonryGridView),
              ),
            );
            expect(masonryGridView.padding, const EdgeInsets.all(10.0));
            expect(masonryGridView.crossAxisSpacing, 5);
            expect(masonryGridView.mainAxisSpacing, 5);
            expect(
              find.descendant(
                of: find.byWidget(masonryGridView),
                matching: cardFinder,
              ),
              findsNWidgets(3),
            );
            Card firstCard = tester.widget<Card>(
              find.descendant(
                of: find.byType(MasonryGridView),
                matching: cardFinder.at(0),
              ),
            );
            expect(firstCard.color, Color(color1));
            expect(firstCard.elevation, 2);
            Padding firstPadding = tester.widget(
              find.descendant(
                of: find.byWidget(firstCard),
                matching: find.byKey(Key('cardContentPadding')),
              ),
            );
            expect(firstPadding.padding, const EdgeInsets.all(10.0));
            ListTile firstListTile = tester.widget(
              find.descendant(
                of: find.byWidget(firstPadding),
                matching: listTileFinder,
              ),
            );
            Text firstTitleText = firstListTile.title as Text;
            expect(firstTitleText.data, fieldName1);
            expect(firstTitleText.style!.color, Colors.white);
            Text firstSubTitleText = firstListTile.subtitle as Text;
            expect(firstSubTitleText.data, '3 $expectedListsString');
            expect(firstSubTitleText.style!.color, Colors.white);
            Card secondCard = tester.widget<Card>(
              find.descendant(
                of: find.byType(MasonryGridView),
                matching: cardFinder.at(1),
              ),
            );
            expect(secondCard.color, Color(color2));
            expect(secondCard.elevation, 2);
            Padding secondPadding = tester.widget(
              find.descendant(
                of: find.byWidget(secondCard),
                matching: find.byKey(Key('cardContentPadding')),
              ),
            );
            expect(firstPadding.padding, const EdgeInsets.all(10.0));
            ListTile secondListTile = tester.widget(
              find.descendant(
                of: find.byWidget(secondPadding),
                matching: listTileFinder,
              ),
            );
            Text secondTitleText = secondListTile.title as Text;
            expect(secondTitleText.data, fieldName2);
            expect(secondTitleText.style!.color, Colors.white);
            Text secondSubTitleText = secondListTile.subtitle as Text;
            expect(secondSubTitleText.data, '2 $expectedListsString');
            expect(secondSubTitleText.style!.color, Colors.white);
            Card thirdCard = tester.widget<Card>(
              find.descendant(
                of: find.byType(MasonryGridView),
                matching: cardFinder.at(2),
              ),
            );
            expect(thirdCard.color, Color(color3));
            expect(thirdCard.elevation, 2);
            Padding thirdPadding = tester.widget(
              find.descendant(
                of: find.byWidget(thirdCard),
                matching: find.byKey(Key('cardContentPadding')),
              ),
            );
            expect(firstPadding.padding, const EdgeInsets.all(10.0));
            ListTile thirdListTile = tester.widget(
              find.descendant(
                of: find.byWidget(thirdPadding),
                matching: listTileFinder,
              ),
            );
            Text thirdTitleText = thirdListTile.title as Text;
            expect(thirdTitleText.data, fieldName3);
            expect(thirdTitleText.style!.color, Colors.black);
            Text thirdSubTitleText = thirdListTile.subtitle as Text;
            expect(thirdSubTitleText.data, '1 $expectedListsString');
            expect(thirdSubTitleText.style!.color, Colors.black);
          });
        },
      );

      testWidgets(
        'Test the presence of the main widgets when there are no fields',
        (WidgetTester tester) async {
          whenListen<FieldsState>(
            fieldsBloc,
            Stream.value(FieldsState(FieldsStatus.success, [])),
          );
          await _createFieldsPageViewInASkeleton(
            tester,
            currentLocale,
            goRouter,
            authBloc,
            watchFieldsWithFieldListsCountUsecase,
            deleteFieldUsecase,
            fieldsBloc,
          );
          Scaffold scaffold = tester.widget(
            find.descendant(
              of: find.byType(FieldsPageView),
              matching: scaffoldFinder,
            ),
          );
          final appBarFinder = find.descendant(
            of: scaffoldFinder,
            matching: find.byType(AppBar),
          );
          expect(appBarFinder, findsOneWidget);
          AppBar appBar = tester.widget<AppBar>(appBarFinder);
          Text title = appBar.title as Text;
          expect(title.data, AppLocalizationsEn().materialAppTitle);
          FloatingActionButton floatingActionButton = tester.widget(
            find.descendant(
              of: scaffoldFinder,
              matching: find.byType(FloatingActionButton),
            ),
          );
          Icon addIcon = floatingActionButton.child as Icon;
          expect(addIcon.icon, Icons.add);
          expect(
            find.descendant(
              of: find.byWidget(scaffold),
              matching: find.descendant(
                of: centerFinder,
                matching: find.byType(CircularProgressIndicator),
              ),
            ),
            findsOne,
          );
          await tester.tap(
            find.descendant(
              of: find.byWidget(appBar),
              matching: find.byType(PopupMenuButton<Text>),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.text(expectedSignOutString), findsOne);
          expect(find.text(expectedAboutString), findsOne);
          await tester.runAsync(() async {
            await tester.pump();
            expect(
              find.descendant(
                of: find.byWidget(scaffold),
                matching: find.descendant(
                  of: centerFinder,
                  matching: find.text(expectedNoFieldsString),
                ),
              ),
              findsOne,
            );
          });
        },
      );

      testWidgets(
        'Test the presence of the main widgets when state status is failure',
        (WidgetTester tester) async {
          whenListen<FieldsState>(
            fieldsBloc,
            Stream.value(const FieldsState(FieldsStatus.failure)),
          );
          await _createFieldsPageViewInASkeleton(
            tester,
            currentLocale,
            goRouter,
            authBloc,
            watchFieldsWithFieldListsCountUsecase,
            deleteFieldUsecase,
            fieldsBloc,
          );
          Scaffold scaffold = tester.widget(
            find.descendant(
              of: find.byType(FieldsPageView),
              matching: scaffoldFinder,
            ),
          );
          final appBarFinder = find.descendant(
            of: scaffoldFinder,
            matching: find.byType(AppBar),
          );
          expect(appBarFinder, findsOneWidget);
          AppBar appBar = tester.widget<AppBar>(appBarFinder);
          Text title = appBar.title as Text;
          expect(title.data, AppLocalizationsEn().materialAppTitle);
          await tester.tap(
            find.descendant(
              of: find.byWidget(appBar),
              matching: find.byType(PopupMenuButton<Text>),
            ),
          );
          await tester.pumpAndSettle();
          expect(find.text(expectedSignOutString), findsOne);
          expect(find.text(expectedAboutString), findsOne);
          FloatingActionButton floatingActionButton = tester.widget(
            find.descendant(
              of: scaffoldFinder,
              matching: find.byType(FloatingActionButton),
            ),
          );
          Icon addIcon = floatingActionButton.child as Icon;
          expect(addIcon.icon, Icons.add);
          await tester.pump();
          expect(
            find.descendant(
              of: find.byWidget(scaffold),
              matching: find.descendant(
                of: centerFinder,
                matching: find.text(expectedErrorString),
              ),
            ),
            findsOne,
          );
        },
      );

      testWidgets('Test that clicking sign out calls signOut()', (
        WidgetTester tester,
      ) async {
        whenListen<FieldsState>(
          fieldsBloc,
          Stream.value(FieldsState(FieldsStatus.success, [])),
        );
        await _createFieldsPageViewInASkeleton(
          tester,
          currentLocale,
          goRouter,
          authBloc,
          watchFieldsWithFieldListsCountUsecase,
          deleteFieldUsecase,
          fieldsBloc,
        );
        await tester.tap(find.byType(PopupMenuButton<Text>));
        await tester.pumpAndSettle();
        final signOutTextFinder = find.text(expectedSignOutString);
        await tester.tap(signOutTextFinder);
        verify(() => authBloc.signOut()).called(1);
      });

      testWidgets('Test that clicking about calls shows a dialog', (
        WidgetTester tester,
      ) async {
        whenListen<FieldsState>(
          fieldsBloc,
          Stream.value(const FieldsState(FieldsStatus.success)),
        );
        await _createFieldsPageViewInASkeleton(
          tester,
          currentLocale,
          goRouter,
          authBloc,
          watchFieldsWithFieldListsCountUsecase,
          deleteFieldUsecase,
          fieldsBloc,
        );
        await tester.tap(find.byType(PopupMenuButton<Text>));
        await tester.pumpAndSettle();
        final aboutTextFinder = find.text(expectedAboutString);
        await tester.tap(aboutTextFinder);
        await tester.pumpAndSettle();
        expect(find.byType(AlertDialog), findsOne);
        expect(find.text('View licenses'), findsOne);
      });

      testWidgets(
        'Test that clicking the floating action button opens the create field page',
        (WidgetTester tester) async {
          whenListen<FieldsState>(
            fieldsBloc,
            Stream.value(const FieldsState(FieldsStatus.success)),
          );
          await _createFieldsPageViewInASkeleton(
            tester,
            currentLocale,
            goRouter,
            authBloc,
            watchFieldsWithFieldListsCountUsecase,
            deleteFieldUsecase,
            fieldsBloc,
          );
          await tester.tap(find.byType(FloatingActionButton));
          await tester.pumpAndSettle();
          verify(() => goRouter.go(createFieldPath)).called(1);
        },
      );

      testWidgets('Test that clicking the card opens the FieldListsPage', (
        WidgetTester tester,
      ) async {
        whenListen<FieldsState>(
          fieldsBloc,
          Stream.value(FieldsState(FieldsStatus.success, fieldsPageData)),
        );
        await _createFieldsPageViewInASkeleton(
          tester,
          currentLocale,
          goRouter,
          authBloc,
          watchFieldsWithFieldListsCountUsecase,
          deleteFieldUsecase,
          fieldsBloc,
        );
        await tester.runAsync(() async {
          await tester.pump();
          await tester.tap(find.byType(Card).at(0));
          await tester.pumpAndSettle();
          verify(
            () => goRouter.go('$fieldListsPath${fieldsPageData[0].$1.id!}'),
          ).called(1);
        });
      });
    });
  });
}
