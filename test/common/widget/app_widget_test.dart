import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:study_without_pen_by_flutter/common/theme.dart';
import 'package:study_without_pen_by_flutter/common/widget/app_widget.dart';
import 'package:mockito/mockito.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations_en.dart';

import 'app_widget_test.mocks.dart';

@GenerateMocks([FirebaseAuth])
void main() {
  late FirebaseAuth firebaseAuth;
  const User? nullUser = null;

  group("English Locale", () {
    Locale currentLocale = Locale("en");

    setUp(() {
      firebaseAuth = MockFirebaseAuth();
      late StreamController<User?> streamController;
      streamController = StreamController();
      when(firebaseAuth.userChanges())
          .thenAnswer((_) => streamController.stream);
      streamController.sink.add(nullUser);
    });

    testWidgets("The the presence of the main widgets",
        (WidgetTester tester) async {
      String expectedTitle = AppLocalizationsEn().materialAppTitle;
      await tester.pumpWidget(Localizations(
        child: App(firebaseAuth),
        locale: currentLocale,
        delegates: AppLocalizations.localizationsDelegates,
      ));
      final multiBlocProviderFinder = find.byType(MultiBlocProvider);
      expect(multiBlocProviderFinder, findsOneWidget);
      final materialAppFinder = find.byType(MaterialApp);
      expect(materialAppFinder, findsOneWidget);
      MaterialApp materialApp = tester.widget(materialAppFinder) as MaterialApp;
      expect(materialApp.localizationsDelegates,
          [AppLocalizations.delegate, nonso.AppLocalizations.delegate]);
      expect(materialApp.supportedLocales, AppLocalizations.supportedLocales);
      expect(materialApp.theme, AppTheme.theme);
      expect(materialApp.themeMode, ThemeMode.system);
      expect(materialApp.title, expectedTitle);
      expect(materialApp.debugShowCheckedModeBanner, false);
      expect(
          find.descendant(
              of: find.byWidget(materialApp),
              matching: find.byType(nonso.AuthScreen)),
          findsOneWidget);
    });
  });
}
