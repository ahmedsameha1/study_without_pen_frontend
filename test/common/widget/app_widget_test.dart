import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:study_without_pen_by_flutter/common/widget/app_widget.dart';
import 'package:mockito/mockito.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

import 'app_widget_test.mocks.dart';

/*
class FakeLocalizations extends Fake implements Localizations {
  final Localizations _localizations;

  FakeLocalizations(Locale locale)
      : _localizations = Localizations(
            locale: locale, delegates: AppLocalizations.localizationsDelegates);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return _localizations.toString();
  }

  @override
  Locale get locale => _localizations.locale;

  @override
  List<LocalizationsDelegate> get delegates => _localizations.delegates;

  
  
}
*/

class ProLoc extends StatelessWidget {
  final Widget child;
  const ProLoc(this.child);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        AppLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      locale: Locale("en"),
      home: child,
    );
  }
}

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
      AppLocalizations appLocalizations =
          await getLocalizations(tester, currentLocale);
      String expectedTitle = appLocalizations.materialAppTitle;
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
    //  expect(materialApp.title, expectedTitle);
      expect(find.byType(nonso.AuthScreen), findsOneWidget);
    });

/*
    testWidgets("The presence of SignInUp", (WidgetTester tester) async {
      await tester.pumpWidget(Localizations(
        child: App(firebaseAuth),
        locale: currentLocale,
        delegates: AppLocalizations.localizationsDelegates,
      ));
      final signInUpFinder = find.byType(SignInUp);
      expect(signInUpFinder, findsOneWidget);
    });

    testWidgets("The presence of SignInUp", (WidgetTester tester) async {
      await tester.pumpWidget(Localizations(
        child: App(firebaseAuth),
        locale: currentLocale,
        delegates: AppLocalizations.localizationsDelegates,
      ));
      final signInUpFinder = find.byType(SignInUp);
      expect(signInUpFinder, findsOneWidget);
    });
    */
  });
}

Future<AppLocalizations> getLocalizations(WidgetTester t, Locale locale) async {
  late AppLocalizations result;
  await t.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      home: Material(
        child: Builder(
          builder: (BuildContext context) {
            result = AppLocalizations.of(context)!;
            return Container();
          },
        ),
      ),
    ),
  );
  await t.pumpAndSettle();
  return result;
}
