import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/common/router_config.dart' as real;
import 'package:study_without_pen_by_flutter/features/field_lists/domain/models/field_lists_page_data.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/watch_field_lists_with_entries_count_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/presentation/pages/field_lists_page.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/create_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_fields_with_field_lists_count_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/create_field_page.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/fields_page.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations_en.dart';

import '../../../common/common_finders.dart';
import '../../../common/widget_testing_helper.dart';

class MockAuthBloc extends MockBloc<nonso.AuthEvent, nonso.AuthState>
    implements nonso.AuthBloc {}

Future<void> goToFieldPage(Widget widgetInskeleton, WidgetTester tester) async {
  await tester.pumpWidget(widgetInskeleton);
}

void main() {
  late CreateFieldUseCase createFieldUseCase;
  late WatchFieldsWithFieldListsCountUsecase watchFieldsUsecase;
  late WatchFieldListsWithEntriesCountUsecase
  watchFieldListsWithEntriesCountUsecase;
  late StreamController<List<(FieldEntity, int)>> streamController;
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

  setUp(() {
    authBloc = MockAuthBloc();
    when(() => authBloc.state).thenReturn(
      nonso.AuthState(
        applicationAuthState: nonso.ApplicationAuthState.signedIn,
      ),
    );
    when(() => authBloc.signOut()).thenAnswer((_) => Completer<void>().future);
  });

  group("Engish Locale", () {
    Locale currentLocale = const Locale("en");
    String expectedNoFieldsString = "Currently, there are no fields!";
    String expectedErrorString = "An error occurred while loading the fields!";
    String expectedSignOutString = 'Sign out';
    String expectedAboutString = 'About';
    String expectedListsString = 'Lists';

    setUp(() {
      user = MockUser();
      authBloc = MockAuthBloc();
      createFieldUseCase = MockCreateFieldUseCase();
      watchFieldsUsecase = MockWatchFieldsUsecase();
      watchFieldListsWithEntriesCountUsecase = MockWatchFieldListsUsecase();
      streamController = StreamController<List<(FieldEntity, int)>>();
      when(() => user.uid).thenReturn(userAccountId);
      when(() => authBloc.state).thenReturn(
        nonso.AuthState(
          applicationAuthState: nonso.ApplicationAuthState.signedIn,
          user: user,
        ),
      );
      when(
        () => authBloc.signOut(),
      ).thenAnswer((_) => Completer<void>().future);
    });

    testWidgets(
      "Test the presence of the main widgets when there is at least one field",
      (WidgetTester tester) async {
        when(() => watchFieldsUsecase.call(userAccountId)).thenAnswer(
          (_) => Stream.value([
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
        );
        await goToFieldPage(
          createWidgetInASkeleton(
            authBloc,
            createFieldUseCase,
            watchFieldsUsecase,
            watchFieldListsWithEntriesCountUsecase,
            currentLocale,
            getRouterConfig,
          ),
          tester,
        );
        final fieldsPageFinder = find.byType(FieldsPage);
        expect(fieldsPageFinder, findsOneWidget);
        Scaffold scaffold = tester.widget(
          find.descendant(of: fieldsPageFinder, matching: scaffoldFinder),
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
      "Test the presence of the main widgets when there are no fields",
      (WidgetTester tester) async {
        when(
          () => watchFieldsUsecase.call(userAccountId),
        ).thenAnswer((_) => Stream.value([]));
        await goToFieldPage(
          createWidgetInASkeleton(
            authBloc,
            createFieldUseCase,
            watchFieldsUsecase,
            watchFieldListsWithEntriesCountUsecase,
            currentLocale,
            getRouterConfig,
          ),
          tester,
        );
        final fieldPageFinder = find.byType(FieldsPage);
        expect(fieldPageFinder, findsOneWidget);
        Scaffold scaffold = tester.widget(
          find.descendant(of: fieldPageFinder, matching: scaffoldFinder),
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
      "Test the presence of the main widgets when watchFieldUsecase.call returns an error",
      (WidgetTester tester) async {
        when(() => watchFieldsUsecase.call(userAccountId)).thenThrow(
          SqliteException(extendedResultCode: 1, message: 'sqlexception'),
        );
        await goToFieldPage(
          createWidgetInASkeleton(
            authBloc,
            createFieldUseCase,
            watchFieldsUsecase,
            watchFieldListsWithEntriesCountUsecase,
            currentLocale,
            getRouterConfig,
          ),
          tester,
        );
        final fieldPageFinder = find.byType(FieldsPage);
        expect(fieldPageFinder, findsOneWidget);
        Scaffold scaffold = tester.widget(
          find.descendant(of: fieldPageFinder, matching: scaffoldFinder),
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

    testWidgets(
      "Test the presence of the main widgets when there is an error while listening to the stream",
      (WidgetTester tester) async {
        streamController.addError('an error');
        when(
          () => watchFieldsUsecase.call(userAccountId),
        ).thenAnswer((_) => streamController.stream);
        await goToFieldPage(
          createWidgetInASkeleton(
            authBloc,
            createFieldUseCase,
            watchFieldsUsecase,
            watchFieldListsWithEntriesCountUsecase,
            currentLocale,
            getRouterConfig,
          ),
          tester,
        );
        final fieldPageFinder = find.byType(FieldsPage);
        expect(fieldPageFinder, findsOneWidget);
        Scaffold scaffold = tester.widget(
          find.descendant(of: fieldPageFinder, matching: scaffoldFinder),
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
                matching: find.text(expectedErrorString),
              ),
            ),
            findsOne,
          );
        });
      },
    );

    testWidgets('Test that clicking sign out calls signOut()', (
      WidgetTester tester,
    ) async {
      await goToFieldPage(
        createWidgetInASkeleton(
          authBloc,
          createFieldUseCase,
          watchFieldsUsecase,
          watchFieldListsWithEntriesCountUsecase,
          currentLocale,
          getRouterConfig,
        ),
        tester,
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
      await goToFieldPage(
        createWidgetInASkeleton(
          authBloc,
          createFieldUseCase,
          watchFieldsUsecase,
          watchFieldListsWithEntriesCountUsecase,
          currentLocale,
          getRouterConfig,
        ),
        tester,
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
      """Test that clicking the floating action button opens the create 
        field page""",
      (WidgetTester tester) async {
        await goToFieldPage(
          createWidgetInASkeleton(
            authBloc,
            createFieldUseCase,
            watchFieldsUsecase,
            watchFieldListsWithEntriesCountUsecase,
            currentLocale,
            getRouterConfig,
          ),
          tester,
        );
        await tester.tap(find.byType(FloatingActionButton));
        await tester.pumpAndSettle();
        expect(find.byType(CreateFieldPage), findsOneWidget);
      },
    );

    testWidgets("Test that clicking the card opens the FieldListsPage", (
      WidgetTester tester,
    ) async {
      when(() => watchFieldsUsecase.call(userAccountId)).thenAnswer(
        (_) => Stream.value([
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
      );
      when(
        () => watchFieldListsWithEntriesCountUsecase.call(fieldId1),
      ).thenAnswer(
        (_) => Stream.value(
          FieldListsPageData(
            field: fieldEntity,
            fieldListsWithEntriesCount: [],
          ),
        ),
      );
      await goToFieldPage(
        createWidgetInASkeleton(
          authBloc,
          createFieldUseCase,
          watchFieldsUsecase,
          watchFieldListsWithEntriesCountUsecase,
          currentLocale,
          real.getRouterConfig,
        ),
        tester,
      );
      await tester.runAsync(() async {
        await tester.pump();
        await tester.tap(find.byType(Card).at(0));
        await tester.pumpAndSettle();
        expect(find.byType(FieldListsPage), findsOne);
      });
    });
  });
}
