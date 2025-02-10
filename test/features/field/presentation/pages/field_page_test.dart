import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/field_page.dart';

import '../../../common/common_finders.dart';
import '../../../common/skeleton_for_widget_testing.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  late Widget widgetInSkeleton;
  late Widget widgetProviderLocalization;

  setUp(() {
    widgetInSkeleton = createWidgetInASkeleton(FieldPage());
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
      final logoutIconButtonFinder = find.descendant(
          of: find.byWidget(appBar), matching: find.byType(IconButton));
      expect(logoutIconButtonFinder, findsOneWidget);
      final logoutIconButton =
          tester.widget<IconButton>(logoutIconButtonFinder);
      expect(logoutIconButton.key, Key("logoutIconButton"));
      expect(appBar.actions, [logoutIconButton]);
      final logoutIconFinder = find.descendant(
          of: find.byWidget(logoutIconButton), matching: find.byType(Icon));
      expect(logoutIconFinder, findsOneWidget);
      final logoutIcon = tester.widget<Icon>(logoutIconFinder);
      expect(logoutIcon.icon, Icons.logout);
    });
  });
}
