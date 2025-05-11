import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/features/field/domain/usecases/create_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/create_field_page.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/field_page.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations_en.dart';
import 'package:uuid/uuid.dart';

import '../../../common/common_finders.dart';

import '../../../common/widget_testing_helper.dart';

class MockAuthBloc extends MockBloc<nonso.AuthEvent, nonso.AuthState>
    implements nonso.AuthBloc {}

Future<void> goToFieldPage(Widget widgetInskeleton, WidgetTester tester) async {
  await tester.pumpWidget(widgetInskeleton);
}

void main() {
  late CreateFieldUseCase createFieldUseCase;
  late Uuid uuid;
  String userId = "fwefohwe";
  User user;
  late nonso.AuthBloc authBloc;

  setUp(() {
    authBloc = MockAuthBloc();
    when(() => authBloc.state).thenReturn(nonso.AuthState(
      applicationAuthState: nonso.ApplicationAuthState.signedIn,
    ));
    when(() => authBloc.signOut()).thenAnswer((_) => Completer<void>().future);
  });

  group("Engish Locale", () {
    Locale currentLocale = const Locale("en");

    setUp(() {
      user = MockUser();
      authBloc = MockAuthBloc();
      createFieldUseCase = MockCreateFieldUseCase();
      uuid = MockUuid();
      when(() => user.uid).thenReturn(userId);
      when(() => authBloc.state).thenReturn(nonso.AuthState(
          applicationAuthState: nonso.ApplicationAuthState.signedIn,
          user: user));
      when(() => authBloc.signOut())
          .thenAnswer((_) => Completer<void>().future);
    });

    testWidgets("Test the presence of the main widgets",
        (WidgetTester tester) async {
      await goToFieldPage(
          createWidgetInASkeleton(authBloc, createFieldUseCase, uuid,
              currentLocale, getRouterConfig),
          tester);
      final fieldPageFinder = find.byType(FieldPage);
      expect(fieldPageFinder, findsOneWidget);
      expect(find.descendant(of: fieldPageFinder, matching: scaffoldFinder),
          findsOneWidget);
      final appBarFinder =
          find.descendant(of: scaffoldFinder, matching: find.byType(AppBar));
      expect(appBarFinder, findsOneWidget);
      AppBar appBar = tester.widget<AppBar>(appBarFinder);
      Text title = appBar.title as Text;
      expect(title.data, AppLocalizationsEn().materialAppTitle);
      BlocBuilder blocBuilder =
          tester.widget(find.byKey(Key("authBlocBuilder")));
      expect(appBar.actions, [blocBuilder]);
      final logoutIconButtonFinder = find.descendant(
          of: find.byWidget(blocBuilder), matching: find.byType(IconButton));
      final logoutIconButton =
          tester.widget<IconButton>(logoutIconButtonFinder);
      final logoutIconFinder = find.descendant(
          of: find.byWidget(logoutIconButton), matching: find.byType(Icon));
      final logoutIcon = tester.widget<Icon>(logoutIconFinder);
      expect(logoutIcon.icon, Icons.logout);
      FloatingActionButton floatingActionButton = tester.widget(find.descendant(
          of: scaffoldFinder, matching: find.byType(FloatingActionButton)));
      Icon addIcon = floatingActionButton.child as Icon;
      expect(addIcon.icon, Icons.add);
    });

    testWidgets("Test that clicking the logoutIconButton calls signOut()",
        (WidgetTester tester) async {
      await goToFieldPage(
          createWidgetInASkeleton(authBloc, createFieldUseCase, uuid,
              currentLocale, getRouterConfig),
          tester);
      final logoutIconButtonFinder = find.byIcon(Icons.logout);
      await tester.tap(logoutIconButtonFinder);
      verify(() => authBloc.signOut()).called(1);
    });

    testWidgets(
        """Test that clicking the floating action button opens the create 
        field page""", (WidgetTester tester) async {
      await goToFieldPage(
          createWidgetInASkeleton(authBloc, createFieldUseCase, uuid,
              currentLocale, getRouterConfig),
          tester);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      expect(find.byType(CreateFieldPage), findsOneWidget);
    });
  });
}
