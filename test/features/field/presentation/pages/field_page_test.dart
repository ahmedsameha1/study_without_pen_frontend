import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:drift/native.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/features/field/domain/models/field_entity.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/usecases/create_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/usecases/watch_fields_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/cubit/fields_cubit.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/cubit/fields_state.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/create_field_page.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/field_page.dart';
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
  late WatchFieldsUsecase watchFieldsUsecase;
  late StreamController<List<FieldEntity>> streamController;
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
  int color2 = Colors.green.toARGB32();
  int usageCount3 = 30;
  int color3 = Colors.blue.toARGB32();

  setUp(() {
    authBloc = MockAuthBloc();
    when(() => authBloc.state).thenReturn(nonso.AuthState(
      applicationAuthState: nonso.ApplicationAuthState.signedIn,
    ));
    when(() => authBloc.signOut()).thenAnswer((_) => Completer<void>().future);
  });

  group("Engish Locale", () {
    Locale currentLocale = const Locale("en");
    String expectedNoFieldsString = "Currently, there are no fields!";
    String expectedErrorString = "An error occurred while loading the fields!";

    setUp(() {
      user = MockUser();
      authBloc = MockAuthBloc();
      createFieldUseCase = MockCreateFieldUseCase();
      watchFieldsUsecase = MockWatchFieldsUsecase();
      streamController = StreamController<List<FieldEntity>>();
      when(() => user.uid).thenReturn(userAccountId);
      when(() => authBloc.state).thenReturn(nonso.AuthState(
          applicationAuthState: nonso.ApplicationAuthState.signedIn,
          user: user));
      when(() => authBloc.signOut())
          .thenAnswer((_) => Completer<void>().future);
    });

    testWidgets(
        "Test the presence of the main widgets when there is at least one field",
        (WidgetTester tester) async {
      when(() => watchFieldsUsecase.call(userAccountId))
          .thenAnswer((_) => Stream.value([
                FieldEntity(fieldId1, userAccountId, fieldName1, creationAt1,
                    lastModificationAt1, usageCount1, color1),
                FieldEntity(fieldId2, userAccountId, fieldName2, creationAt2,
                    lastModificationAt2, usageCount2, color2),
                FieldEntity(fieldId3, userAccountId, fieldName3, creationAt3,
                    lastModificationAt3, usageCount3, color3),
              ]));
      await goToFieldPage(
          createWidgetInASkeleton(authBloc, createFieldUseCase,
              watchFieldsUsecase, currentLocale, getRouterConfig),
          tester);
      final fieldPageFinder = find.byType(FieldPage);
      expect(fieldPageFinder, findsOneWidget);
      Scaffold scaffold = tester.widget(
          find.descendant(of: fieldPageFinder, matching: scaffoldFinder));
      final appBarFinder =
          find.descendant(of: scaffoldFinder, matching: find.byType(AppBar));
      expect(appBarFinder, findsOneWidget);
      AppBar appBar = tester.widget<AppBar>(appBarFinder);
      Text title = appBar.title as Text;
      expect(title.data, AppLocalizationsEn().materialAppTitle);
      final logoutIconButtonFinder = find.descendant(
          of: find.byWidget(appBar), matching: find.byType(IconButton));
      final logoutIconButton =
          tester.widget<IconButton>(logoutIconButtonFinder);
      expect(appBar.actions, [logoutIconButton]);
      final logoutIconFinder = find.descendant(
          of: find.byWidget(logoutIconButton), matching: find.byType(Icon));
      final logoutIcon = tester.widget<Icon>(logoutIconFinder);
      expect(logoutIcon.icon, Icons.logout);
      FloatingActionButton floatingActionButton = tester.widget(find.descendant(
          of: scaffoldFinder, matching: find.byType(FloatingActionButton)));
      Icon addIcon = floatingActionButton.child as Icon;
      expect(addIcon.icon, Icons.add);
      BlocBuilder<FieldsCubit, FieldsState> blocBuilder =
          tester.widget(find.byType(BlocBuilder<FieldsCubit, FieldsState>));
      expect(scaffold.body, blocBuilder);
      expect(
          find.descendant(
              of: find.byWidget(blocBuilder),
              matching: find.descendant(
                  of: centerFinder,
                  matching: find.byType(CircularProgressIndicator))),
          findsOne);
      await tester.runAsync(() async {
        await tester.pump();
        Scrollbar scrollbar = tester.widget(
          find.descendant(
              of: find.byWidget(blocBuilder), matching: find.byType(Scrollbar)),
        );
        expect(scrollbar.thumbVisibility, isTrue);
        expect(scrollbar.trackVisibility, isTrue);
        expect(scrollbar.interactive, isTrue);
        expect(scrollbar.thickness, 10);
        expect(scrollbar.radius, const Radius.circular(8.0));
        MasonryGridView masonryGridView = tester.widget(
          find.descendant(
              of: find.byWidget(scrollbar),
              matching: find.byType(MasonryGridView)),
        );
        expect(masonryGridView.padding, const EdgeInsets.all(10.0));
        expect(
            find.descendant(
                of: find.byWidget(masonryGridView), matching: cardFinder),
            findsNWidgets(3));
        Card firstCard = tester.widget<Card>(find.descendant(
            of: find.byType(MasonryGridView),
            matching: find.byType(Card).at(0)));
        expect((firstCard.child as Text).data, fieldName1);
        Card secondCard = tester.widget<Card>(find.descendant(
            of: find.byType(MasonryGridView),
            matching: find.byType(Card).at(1)));
        expect((secondCard.child as Text).data, fieldName2);
        Card thirdCard = tester.widget<Card>(find.descendant(
            of: find.byType(MasonryGridView),
            matching: find.byType(Card).at(2)));
        expect((thirdCard.child as Text).data, fieldName3);
      });
    });

    testWidgets(
        "Test the presence of the main widgets when there are no fields",
        (WidgetTester tester) async {
      when(() => watchFieldsUsecase.call(userAccountId))
          .thenAnswer((_) => Stream.value([]));
      await goToFieldPage(
          createWidgetInASkeleton(authBloc, createFieldUseCase,
              watchFieldsUsecase, currentLocale, getRouterConfig),
          tester);
      final fieldPageFinder = find.byType(FieldPage);
      expect(fieldPageFinder, findsOneWidget);
      Scaffold scaffold = tester.widget(
          find.descendant(of: fieldPageFinder, matching: scaffoldFinder));
      final appBarFinder =
          find.descendant(of: scaffoldFinder, matching: find.byType(AppBar));
      expect(appBarFinder, findsOneWidget);
      AppBar appBar = tester.widget<AppBar>(appBarFinder);
      Text title = appBar.title as Text;
      expect(title.data, AppLocalizationsEn().materialAppTitle);
      final logoutIconButtonFinder = find.descendant(
          of: find.byWidget(appBar), matching: find.byType(IconButton));
      final logoutIconButton =
          tester.widget<IconButton>(logoutIconButtonFinder);
      expect(appBar.actions, [logoutIconButton]);
      final logoutIconFinder = find.descendant(
          of: find.byWidget(logoutIconButton), matching: find.byType(Icon));
      final logoutIcon = tester.widget<Icon>(logoutIconFinder);
      expect(logoutIcon.icon, Icons.logout);
      FloatingActionButton floatingActionButton = tester.widget(find.descendant(
          of: scaffoldFinder, matching: find.byType(FloatingActionButton)));
      Icon addIcon = floatingActionButton.child as Icon;
      expect(addIcon.icon, Icons.add);
      BlocBuilder<FieldsCubit, FieldsState> blocBuilder =
          tester.widget(find.byType(BlocBuilder<FieldsCubit, FieldsState>));
      expect(scaffold.body, blocBuilder);
      expect(
          find.descendant(
              of: find.byWidget(blocBuilder),
              matching: find.descendant(
                  of: centerFinder,
                  matching: find.byType(CircularProgressIndicator))),
          findsOne);
      await tester.runAsync(() async {
        await tester.pump();
        expect(
            find.descendant(
                of: find.byWidget(blocBuilder),
                matching: find.descendant(
                    of: centerFinder, matching: find.byType(Text))),
            findsOne);
        Text noFieldsText = tester.widget<Text>(
            find.descendant(of: centerFinder, matching: find.byType(Text)));
        expect(noFieldsText.data, expectedNoFieldsString);
      });
    });

    testWidgets(
        "Test the presence of the main widgets when watchFieldUsecase.call returns an error",
        (WidgetTester tester) async {
      when(() => watchFieldsUsecase.call(userAccountId))
          .thenThrow(SqliteException(1, 'sqlexception'));
      await goToFieldPage(
          createWidgetInASkeleton(authBloc, createFieldUseCase,
              watchFieldsUsecase, currentLocale, getRouterConfig),
          tester);
      final fieldPageFinder = find.byType(FieldPage);
      expect(fieldPageFinder, findsOneWidget);
      Scaffold scaffold = tester.widget(
          find.descendant(of: fieldPageFinder, matching: scaffoldFinder));
      final appBarFinder =
          find.descendant(of: scaffoldFinder, matching: find.byType(AppBar));
      expect(appBarFinder, findsOneWidget);
      AppBar appBar = tester.widget<AppBar>(appBarFinder);
      Text title = appBar.title as Text;
      expect(title.data, AppLocalizationsEn().materialAppTitle);
      final logoutIconButtonFinder = find.descendant(
          of: find.byWidget(appBar), matching: find.byType(IconButton));
      final logoutIconButton =
          tester.widget<IconButton>(logoutIconButtonFinder);
      expect(appBar.actions, [logoutIconButton]);
      final logoutIconFinder = find.descendant(
          of: find.byWidget(logoutIconButton), matching: find.byType(Icon));
      final logoutIcon = tester.widget<Icon>(logoutIconFinder);
      expect(logoutIcon.icon, Icons.logout);
      FloatingActionButton floatingActionButton = tester.widget(find.descendant(
          of: scaffoldFinder, matching: find.byType(FloatingActionButton)));
      Icon addIcon = floatingActionButton.child as Icon;
      expect(addIcon.icon, Icons.add);
      BlocBuilder<FieldsCubit, FieldsState> blocBuilder =
          tester.widget(find.byType(BlocBuilder<FieldsCubit, FieldsState>));
      expect(scaffold.body, blocBuilder);
      await tester.pump();
      expect(
          find.descendant(
              of: find.byWidget(blocBuilder),
              matching: find.descendant(
                  of: centerFinder, matching: find.byType(Text))),
          findsOne);
      Text errorText = tester.widget<Text>(
          find.descendant(of: centerFinder, matching: find.byType(Text)));
      expect(errorText.data, expectedErrorString);
    });

    testWidgets(
        "Test the presence of the main widgets when there is an error while listening to the stream",
        (WidgetTester tester) async {
      streamController.addError('an error');
      when(() => watchFieldsUsecase.call(userAccountId))
          .thenAnswer((_) => streamController.stream);
      await goToFieldPage(
          createWidgetInASkeleton(authBloc, createFieldUseCase,
              watchFieldsUsecase, currentLocale, getRouterConfig),
          tester);
      final fieldPageFinder = find.byType(FieldPage);
      expect(fieldPageFinder, findsOneWidget);
      Scaffold scaffold = tester.widget(
          find.descendant(of: fieldPageFinder, matching: scaffoldFinder));
      final appBarFinder =
          find.descendant(of: scaffoldFinder, matching: find.byType(AppBar));
      expect(appBarFinder, findsOneWidget);
      AppBar appBar = tester.widget<AppBar>(appBarFinder);
      Text title = appBar.title as Text;
      expect(title.data, AppLocalizationsEn().materialAppTitle);
      final logoutIconButtonFinder = find.descendant(
          of: find.byWidget(appBar), matching: find.byType(IconButton));
      final logoutIconButton =
          tester.widget<IconButton>(logoutIconButtonFinder);
      expect(appBar.actions, [logoutIconButton]);
      final logoutIconFinder = find.descendant(
          of: find.byWidget(logoutIconButton), matching: find.byType(Icon));
      final logoutIcon = tester.widget<Icon>(logoutIconFinder);
      expect(logoutIcon.icon, Icons.logout);
      FloatingActionButton floatingActionButton = tester.widget(find.descendant(
          of: scaffoldFinder, matching: find.byType(FloatingActionButton)));
      Icon addIcon = floatingActionButton.child as Icon;
      expect(addIcon.icon, Icons.add);
      BlocBuilder<FieldsCubit, FieldsState> blocBuilder =
          tester.widget(find.byType(BlocBuilder<FieldsCubit, FieldsState>));
      expect(scaffold.body, blocBuilder);
      expect(
          find.descendant(
              of: find.byWidget(blocBuilder),
              matching: find.descendant(
                  of: centerFinder,
                  matching: find.byType(CircularProgressIndicator))),
          findsOne);
      await tester.runAsync(() async {
        await tester.pump();
        expect(
            find.descendant(
                of: find.byWidget(blocBuilder),
                matching: find.descendant(
                    of: centerFinder, matching: find.byType(Text))),
            findsOne);
        Text noFieldsText = tester.widget<Text>(
            find.descendant(of: centerFinder, matching: find.byType(Text)));
        expect(noFieldsText.data, expectedErrorString);
      });
    });

    testWidgets("Test that clicking the logoutIconButton calls signOut()",
        (WidgetTester tester) async {
      await goToFieldPage(
          createWidgetInASkeleton(authBloc, createFieldUseCase,
              watchFieldsUsecase, currentLocale, getRouterConfig),
          tester);
      final logoutIconButtonFinder = find.byIcon(Icons.logout);
      await tester.tap(logoutIconButtonFinder);
      verify(() => authBloc.signOut()).called(1);
    });

    testWidgets("Test that clicking the logoutIconButton calls signOut()",
        (WidgetTester tester) async {
      await goToFieldPage(
          createWidgetInASkeleton(authBloc, createFieldUseCase,
              watchFieldsUsecase, currentLocale, getRouterConfig),
          tester);
      final logoutIconButtonFinder = find.byIcon(Icons.logout);
      await tester.tap(logoutIconButtonFinder);
      verify(() => authBloc.signOut()).called(1);
    });

    testWidgets(
        """Test that clicking the floating action button opens the create 
        field page""", (WidgetTester tester) async {
      await goToFieldPage(
          createWidgetInASkeleton(authBloc, createFieldUseCase,
              watchFieldsUsecase, currentLocale, getRouterConfig),
          tester);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(CreateFieldPage), findsOneWidget);
    });
  });
}
