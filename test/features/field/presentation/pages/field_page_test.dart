import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nonso/nonso.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/field_page.dart';

import '../../../common/common_finders.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../common/widget_testing_helper.dart';

class MockAuthBloc extends MockBloc<AuthEvent, AuthState> implements AuthBloc {}

void main() {
  late Widget widgetInSkeleton;
  late Widget widgetProviderLocalization;
  late AuthBloc authBloc;

  setUp(() {
    authBloc = MockAuthBloc();
    when(() => authBloc.state).thenReturn(AuthState(
      applicationAuthState: ApplicationAuthState.signedIn,
    ));
    when(() => authBloc.signOut()).thenAnswer((_) => Completer<void>().future);
    widgetInSkeleton =
        createWidgetInASkeleton(AuthScreen(FieldPage()), authBloc);
  });

  group("Engish Locale", () {
    Locale currentLocale = const Locale("en");

    setUp(() {
      widgetProviderLocalization = Localizations(
        locale: currentLocale,
        delegates: AppLocalizations.localizationsDelegates,
        child: widgetInSkeleton,
      );
    });

    testWidgets("Test the presence of the main widgets",
        (WidgetTester tester) async {
      await tester.pumpWidget(widgetProviderLocalization);
      final fieldPageFinder = find.byType(FieldPage);
      expect(fieldPageFinder, findsOneWidget);
      expect(find.descendant(of: fieldPageFinder, matching: scaffoldFinder),
          findsOneWidget);
      final appBarFinder =
          find.descendant(of: scaffoldFinder, matching: find.byType(AppBar));
      expect(appBarFinder, findsOneWidget);
      AppBar appBar = tester.widget<AppBar>(appBarFinder);
      BlocBuilder blocBuilder = tester.widget(find.byKey(Key("authBlocBuilder")));
      expect(appBar.actions, [blocBuilder]);
      final logoutIconButtonFinder = find.descendant(
          of: find.byWidget(blocBuilder), matching: find.byType(IconButton));
      final logoutIconButton =
          tester.widget<IconButton>(logoutIconButtonFinder);
      final logoutIconFinder = find.descendant(
          of: find.byWidget(logoutIconButton), matching: find.byType(Icon));
      final logoutIcon = tester.widget<Icon>(logoutIconFinder);
      expect(logoutIcon.icon, Icons.logout);
    });

    testWidgets("Test that clicking the logoutIconButton calls signOut()", (WidgetTester tester) async {
      await tester.pumpWidget(widgetProviderLocalization);
      final logoutIconButtonFinder = find.byIcon(Icons.logout);
      await tester.tap(logoutIconButtonFinder);
      verify(() => authBloc.signOut()).called(1);
    });
  });
}
