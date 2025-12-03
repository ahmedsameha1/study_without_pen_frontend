import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:study_without_pen_by_flutter/common/theme.dart';
import 'package:study_without_pen_by_flutter/common/widgets/app.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations_en.dart';

class MockAppDatabase extends Mock implements AppDatabase {}

class MockFirebaseAuth extends Mock implements FirebaseAuth {}

void main() {
  late FirebaseAuth firebaseAuth;
  const User? nullUser = null;

  group("English Locale", () {
    Locale currentLocale = Locale("en");

    setUp(() {
      firebaseAuth = MockFirebaseAuth();
      late StreamController<User?> streamController;
      streamController = StreamController();
      when(() => firebaseAuth.userChanges())
          .thenAnswer((_) => streamController.stream);
      streamController.sink.add(nullUser);
    });

    testWidgets("The the presence of the main widgets",
        (WidgetTester tester) async {
      String expectedTitle = AppLocalizationsEn().materialAppTitle;
      await tester.pumpWidget(Localizations(
        locale: currentLocale,
        delegates: AppLocalizations.localizationsDelegates,
        child: RepositoryProvider<nonso.AuthBloc>(
          create: (context) => nonso.AuthBloc(firebaseAuth),
          child: App(),
        ),
      ));
      expect(find.byType(App), findsOneWidget);
      expect(
          find.descendant(
              of: find.byType(App),
              matching: find.byType(BlocProvider<nonso.AuthBloc>)),
          findsOneWidget);
      MaterialApp materialApp = tester.widget(find.descendant(
          of: find.byType(BlocProvider<nonso.AuthBloc>),
          matching: find.byType(MaterialApp)));
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
