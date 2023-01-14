import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:study_without_pen_by_flutter/state/auth_state.dart';
import 'package:study_without_pen_by_flutter/state/auth_state_notifier.dart';
import 'package:study_without_pen_by_flutter/state/providers.dart';
import 'package:study_without_pen_by_flutter/widget/main_widget.dart';

import '../state/auth_state_notifier_test.mocks.dart';
import 'main_widget_test.mocks.dart';

@GenerateMocks([BuildContext, GoRouterState])
void main() {
  late AuthStateNotifier authStateNotifier;
  late StreamController<User?> streamController;
  late FirebaseAuth firebaseAuth;
  setUp(() {
    streamController = StreamController();
    firebaseAuth = MockFirebaseAuth();
    when(firebaseAuth.userChanges()).thenAnswer((_) => streamController.stream);
  });
  test("rootPathBuilder() returns MainScreen", () {
    expect(
        MainWidget.rootPathBuilder(MockBuildContext(), MockGoRouterState())
            .runtimeType,
        Text);
  });

  testWidgets("Test the precese of the main widgets",
      (WidgetTester tester) async {
    authStateNotifier = AuthStateNotifier(
        firebaseAuth,
        const AuthState(
            applicationLoginState: ApplicationLoginState.loggedOut));
    await tester.pumpWidget(ProviderScope(overrides: [
      authStateNotifierProvider.overrideWithValue(authStateNotifier)
    ], child: const MainWidget()));
    final materialAppFinder = find.byType(MaterialApp);
    expect(materialAppFinder, findsOneWidget);
    expect(
        find.descendant(
            of: materialAppFinder, matching: find.byType(Text)),
        findsOneWidget);
    final MaterialApp materialAppWidget = tester.widget(materialAppFinder);
    expect(materialAppWidget.title, MainWidget.title);
  });
}
