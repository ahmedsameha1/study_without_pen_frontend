import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/field_page.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations_en.dart';

import '../../../common/common_finders.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

import '../../../common/widget_testing_helper.dart';

class MockAuthBloc extends MockBloc<nonso.AuthEvent, nonso.AuthState>
    implements nonso.AuthBloc {}

void main() {
  late Widget widgetInSkeleton;
  late Widget widgetProviderLocalization;
  late nonso.AuthBloc authBloc;
  String expectedCreateNewFieldDialogTitle = "Create New Field";

  setUp(() {
    authBloc = MockAuthBloc();
    when(() => authBloc.state).thenReturn(nonso.AuthState(
      applicationAuthState: nonso.ApplicationAuthState.signedIn,
    ));
    when(() => authBloc.signOut()).thenAnswer((_) => Completer<void>().future);
    widgetInSkeleton =
        createWidgetInASkeleton(nonso.AuthScreen(FieldPage()), authBloc);
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
      await tester.pumpWidget(widgetProviderLocalization);
      final logoutIconButtonFinder = find.byIcon(Icons.logout);
      await tester.tap(logoutIconButtonFinder);
      verify(() => authBloc.signOut()).called(1);
    });

    testWidgets(
        """Test that clicking the floating action button opens the create 
        new field AlertDialog and testing the precense of the main widgets in
        that dialog""", (WidgetTester tester) async {
      await tester.pumpWidget(widgetProviderLocalization);
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      AlertDialog createNewFieldDialog =
          tester.widget(find.byType(AlertDialog));
      Text title = createNewFieldDialog.title as Text;
      expect(title.data, expectedCreateNewFieldDialogTitle);
      expect(title.textAlign, TextAlign.center);
      Column createNewFieldDialogContent =
          createNewFieldDialog.content as Column;
      expect(createNewFieldDialogContent.mainAxisSize, MainAxisSize.min);
      ColorIndicator colorIndicator =
          tester.widget(find.byType(ColorIndicator));
      expect(colorIndicator.color, Colors.red);
      await tester.tap(find.byWidget(colorIndicator));
      await tester.pumpAndSettle();
      ColorWheelPicker colorWheelPicker =
          tester.widget(find.byType(ColorWheelPicker));
      expect(find.byWidget(colorWheelPicker), findsOneWidget);
      final Offset colorWheelPickerCenter =
          tester.getCenter(find.byWidget(colorWheelPicker));
      await tester.timedDragFrom(
          colorWheelPickerCenter, const Offset(50, 20), Durations.short1);
      await tester.pumpAndSettle(Durations.short2);
      await tester.tap(find.text("OK"));
      await tester.pumpAndSettle();
      colorIndicator = tester.widget(find.byType(ColorIndicator));
      expect(colorIndicator.color, const Color(0xff520a04));
      expect(
          checkWidgetsOrder(
              createNewFieldDialogContent.children.toList(), [colorIndicator]),
          isTrue);
    });
  });
}
