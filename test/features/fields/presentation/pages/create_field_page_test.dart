import 'dart:async';
import 'package:bloc_test/bloc_test.dart';
import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/common/state_status.dart';
import 'package:study_without_pen_by_flutter/common/widgets/ok_cancel.dart';
import 'package:study_without_pen_by_flutter/common/widgets/pick_color.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/create_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/create_field_bloc.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/bloc/create_field_state.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/create_field_page.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/fields_page.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';

import '../../../common/common_finders.dart';
import '../../../common/widget_testing_helper.dart';

class MockAuthBloc extends Mock implements nonso.AuthBloc {}

class MockCreateFieldBloc extends Mock implements CreateFieldBloc {}

class MockGoRouter extends Mock implements GoRouter {}

Future<void> goToCreateFieldPage(
  Widget widgetInskeleton,
  WidgetTester tester,
) async {
  await tester.pumpWidget(widgetInskeleton);
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
}

Future<void> _createCreateFieldPageViewInASkeleton(
  WidgetTester tester,
  Locale locale,
  CreateFieldUsecase createFieldUsecase,
  nonso.AuthBloc authBloc,
  CreateFieldBloc createFieldBloc,
  GoRouter goRouter,
) async {
  await tester.pumpWidget(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: createFieldUsecase),
        RepositoryProvider.value(value: authBloc),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          nonso.AppLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        locale: locale,
        home: InheritedGoRouter(
          goRouter: goRouter,
          child: BlocProvider.value(
            value: createFieldBloc,
            child: const CreateFieldPageView(false),
          ),
        ),
      ),
    ),
  );
}

void main() {
  late CreateFieldUsecase createFieldUsecase;
  String userId = "fwefohwe";
  User user;
  late nonso.AuthBloc authBloc;
  String expectedCreateFieldString = "Create Field";
  String expectedFieldNameString = "Field Name";
  String expectedOkString = "Ok";
  String expectedCancelString = "Cancel";
  String expectedInvalidNameString =
      "Field name must be between 1 and 64 characters";
  String expectedFieldHasBeenCreatedString = "Created";
  String expectedErrorOccuredWhileFieldPersistenceString =
      "Error while creation";

  setUp(() {
    user = MockUser();
    authBloc = MockAuthBloc();
    createFieldUsecase = MockCreateFieldUseCase();
    when(() => user.uid).thenReturn(userId);
    when(() => authBloc.state).thenReturn(
      nonso.AuthState(
        applicationAuthState: nonso.ApplicationAuthState.signedIn,
        user: user,
      ),
    );
    when(() => authBloc.stream).thenAnswer(
      (_) => Stream.value(
        nonso.AuthState(
          applicationAuthState: nonso.ApplicationAuthState.signedIn,
          user: user,
        ),
      ),
    );
    when(() => authBloc.signOut()).thenAnswer((_) => Completer<void>().future);
  });

  group("Engish Locale", () {
    Locale currentLocale = const Locale("en");

    group('CreateFieldPage', () {
      testWidgets("Test the presence of CreateFieldPageView widget", (
        WidgetTester tester,
      ) async {
        when(
          () => createFieldUsecase.call(userId, 'name', 0xffffffff),
        ).thenAnswer((_) => Future.value(1));
        await tester.pumpWidget(
          MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(value: createFieldUsecase),
              RepositoryProvider.value(value: authBloc),
            ],
            child: MaterialApp(
              localizationsDelegates: const [
                AppLocalizations.delegate,
                nonso.AppLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              locale: currentLocale,
              home: const CreateFieldPage(),
            ),
          ),
        );
        expect(
          find.descendant(
            of: find.byType(CreateFieldPage),
            matching: find.byType(CreateFieldPageView),
          ),
          findsOne,
        );
      });
    });

    group('CreateFieldPageView', () {
      late CreateFieldBloc createFieldBloc;
      late GoRouter goRouter = MockGoRouter();
      setUp(() {
        createFieldUsecase = MockCreateFieldUseCase();
        when(
          () => createFieldUsecase.call(userId, 'name', 0xffffffff),
        ).thenAnswer((_) => Future.value(1));
        createFieldBloc = MockCreateFieldBloc();
        when(() => createFieldBloc.state).thenReturn(
          CreateFieldState(
            status: CreateFieldStatus.initial,
            userAccountId: userId,
          ),
        );
        when(() => createFieldBloc.stream).thenAnswer(
          (_) => Stream.value(
            CreateFieldState(
              status: CreateFieldStatus.initial,
              userAccountId: userId,
            ),
          ),
        );
      });

      testWidgets("Test the presence of the main widgets", (
        WidgetTester tester,
      ) async {
        await _createCreateFieldPageViewInASkeleton(
          tester,
          currentLocale,
          createFieldUsecase,
          authBloc,
          createFieldBloc,
          goRouter,
        );
        expect(find.byType(CreateFieldPageView), findsOne);
        expect(
          find.descendant(
            of: find.byType(CreateFieldPageView),
            matching: scaffoldFinder,
          ),
          findsOneWidget,
        );
        final appBarFinder = find.descendant(
          of: scaffoldFinder,
          matching: find.byType(AppBar),
        );
        expect(appBarFinder, findsOneWidget);
        AppBar appBar = tester.widget<AppBar>(appBarFinder);
        Text title = appBar.title as Text;
        expect(title.data, expectedCreateFieldString);
        expect(
          find.descendant(
            of: scaffoldFinder,
            matching: find.byKey(Key("center")),
          ),
          findsOneWidget,
        );
        Scaffold scaffold = tester.widget(scaffoldFinder);
        SafeArea safeArea = scaffold.body as SafeArea;
        Center center = safeArea.child as Center;
        Card card = tester.widget(
          find.descendant(of: find.byWidget(center), matching: cardFinder),
        );
        expect(card.margin!.horizontal, 40);
        expect(card.margin!.vertical, 40);
        expect(
          find.descendant(
            of: find.byWidget(card),
            matching: singleChildScrollViewFinder,
          ),
          findsOneWidget,
        );
        Padding padding = tester.widget(
          find.descendant(
            of: singleChildScrollViewFinder,
            matching: find.byKey(const Key("paddingAroundColumn")),
          ),
        );
        expect(padding.padding.horizontal, 32);
        expect(padding.padding.vertical, 32);
        Column column = tester.widget(
          find.descendant(
            of: find.byWidget(padding),
            matching: columnFinder.at(0),
          ),
        );
        expect(column.mainAxisAlignment, MainAxisAlignment.center);
        expect(
          find.descendant(of: columnFinder, matching: formFinder),
          findsOneWidget,
        );
        Form form = tester.widget(find.byType(Form));
        final TextField fieldNameTextField =
            tester.widget(
                  find.descendant(
                    of: find.byWidget(form),
                    matching: find.byType(TextField),
                  ),
                )
                as TextField;
        expect(
          (fieldNameTextField.decoration!.label as Text).data,
          expectedFieldNameString,
        );
        expect(fieldNameTextField.keyboardType, TextInputType.text);
        expect(fieldNameTextField.textInputAction, TextInputAction.next);
        expect(fieldNameTextField.autofocus, isTrue);
        SizedBox sizedBoxBetweenFormAndStack = tester.widget(
          find.byKey(Key("sizedBoxBetweenFormAndStack")),
        );
        expect(sizedBoxBetweenFormAndStack.height!, 25);
        SizedBox sizedBoxBetweenStackAndOkCancel = tester.widget(
          find.byKey(Key("sizedBoxBetweenStackAndButtons")),
        );
        expect(sizedBoxBetweenStackAndOkCancel.height, 25);
        expect(
          checkWidgetsOrder(column.children.toList(), [
            form,
            sizedBoxBetweenFormAndStack,
            tester.widget(find.byType(PickColor)),
            sizedBoxBetweenStackAndOkCancel,
            tester.widget(find.byType(OkCancel)),
          ]),
          isTrue,
        );
      });

      testWidgets("name text form field validation", (
        WidgetTester tester,
      ) async {
        await _createCreateFieldPageViewInASkeleton(
          tester,
          currentLocale,
          createFieldUsecase,
          authBloc,
          createFieldBloc,
          goRouter,
        );
        await tester.pumpAndSettle();
        ElevatedButton okElevatedButton = tester.widget(
          find.widgetWithText(ElevatedButton, expectedOkString),
        );
        final nameValidationErrorTextFinder = find.descendant(
          of: textFormFieldFinder,
          matching: find.text(expectedInvalidNameString),
        );
        expect(nameValidationErrorTextFinder, findsNothing);
        expect(okElevatedButton.enabled, isFalse);
        await tester.enterText(
          textFormFieldFinder,
          "r" * (Fields.MAXIMUM_LENGTH_OF_NAME + 1),
        );
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsOneWidget);
        okElevatedButton = tester.widget(
          find.widgetWithText(ElevatedButton, expectedOkString),
        );
        expect(okElevatedButton.enabled, isFalse);
        await tester.enterText(
          textFormFieldFinder,
          "r" * (Fields.MAXIMUM_LENGTH_OF_NAME) + " ",
        );
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsNothing);
        okElevatedButton = tester.widget(
          find.widgetWithText(ElevatedButton, expectedOkString),
        );
        expect(okElevatedButton.enabled, isTrue);
        await tester.enterText(textFormFieldFinder, "field name");
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsNothing);
        okElevatedButton = tester.widget(
          find.widgetWithText(ElevatedButton, expectedOkString),
        );
        expect(okElevatedButton.enabled, isTrue);
        await tester.enterText(textFormFieldFinder, " ");
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsOneWidget);
        okElevatedButton = tester.widget(
          find.widgetWithText(ElevatedButton, expectedOkString),
        );
        expect(okElevatedButton.enabled, isFalse);
        await tester.enterText(textFormFieldFinder, "");
        await tester.pumpAndSettle();
        expect(nameValidationErrorTextFinder, findsOneWidget);
        okElevatedButton = tester.widget(
          find.widgetWithText(ElevatedButton, expectedOkString),
        );
        expect(okElevatedButton.enabled, isFalse);
      });

      testWidgets(
        "Test clicking the cancel button exit the create field page",
        (WidgetTester tester) async {
          await _createCreateFieldPageViewInASkeleton(
            tester,
            currentLocale,
            createFieldUsecase,
            authBloc,
            createFieldBloc,
            goRouter,
          );
          await tester.tap(
            find.widgetWithText(ElevatedButton, expectedCancelString),
          );
          await tester.pumpAndSettle();
          expect(find.byType(CreateFieldPage), findsNothing);
        },
      );

      group('Ok button', () {
        testWidgets("Test clicking the ok button: validation error", (
          WidgetTester tester,
        ) async {
          DateTime creationAt = DateTime(2020, 1, 1);
          final name = "";
          int color = 0xff520404;
          when(() => createFieldUsecase.call(userId, name, color)).thenThrow(
            AssertionError('Field name must be between 1 and 64 characters'),
          );
          withClock(Clock.fixed(creationAt), () async {
            await _createCreateFieldPageViewInASkeleton(
              tester,
              currentLocale,
              createFieldUsecase,
              authBloc,
              createFieldBloc,
              goRouter,
            );
            await tester.enterText(textFormFieldFinder, name);
            await tester.ensureVisible(
              find.widgetWithText(ElevatedButton, expectedOkString),
            );
            await tester.tap(
              find.widgetWithText(ElevatedButton, expectedOkString),
            );
            await tester.runAsync(() async {
              await Future.delayed(Duration(seconds: 1));
              await tester.pump();
              expect(
                find.descendant(
                  of: find.byType(Center),
                  matching: circularProgressIndicatorFinder,
                ),
                findsOne,
              );
              await tester.pumpAndSettle();
              expect(find.byType(SnackBar), findsOne);
              SnackBar snackBar = tester.widget(snackBarFinder);
              expect(
                (snackBar.content as Text).data,
                expectedInvalidNameString,
              );
              expect(
                find.descendant(of: find.byType(Center), matching: cardFinder),
                findsOne,
              );
            });
          });
        });
      });

      testWidgets("Test clicking the ok button: failure from the date repo", (
        WidgetTester tester,
      ) async {
        DateTime creationAt = DateTime(2020, 1, 1);
        final name = "field name";
        int color = 0xff520404;
        when(() => createFieldUsecase.call(userId, name, color)).thenThrow(
          SqliteException(
            extendedResultCode: 1,
            message: "Error from database",
          ),
        );
        withClock(Clock.fixed(creationAt), () async {
          await _createCreateFieldPageViewInASkeleton(
            tester,
            currentLocale,
            createFieldUsecase,
            authBloc,
            createFieldBloc,
            goRouter,
          );
          await tester.enterText(textFormFieldFinder, name);
          await tester.ensureVisible(
            find.widgetWithText(ElevatedButton, expectedOkString),
          );
          await tester.tap(
            find.widgetWithText(ElevatedButton, expectedOkString),
          );
          await tester.runAsync(() async {
            await Future.delayed(Duration(seconds: 1));
            await tester.pump();
            expect(
              find.descendant(
                of: find.byType(Center),
                matching: circularProgressIndicatorFinder,
              ),
              findsOne,
            );
            await tester.pumpAndSettle();
            expect(find.byType(SnackBar), findsOne);
            SnackBar snackBar = tester.widget(snackBarFinder);
            expect(
              (snackBar.content as Text).data,
              expectedErrorOccuredWhileFieldPersistenceString,
            );
            expect(
              find.descendant(of: find.byType(Center), matching: cardFinder),
              findsOne,
            );
          });
        });
      });

      testWidgets("Test clicking the ok button: success", (
        WidgetTester tester,
      ) async {
        DateTime creationAt = DateTime(2020, 1, 1);
        final name = "field name";
        int color = 0xff520404;
        when(
          () => createFieldUsecase.call(userId, name, color),
        ).thenAnswer((_) => Future.value(1));
        withClock(Clock.fixed(creationAt), () async {
          await _createCreateFieldPageViewInASkeleton(
            tester,
            currentLocale,
            createFieldUsecase,
            authBloc,
            createFieldBloc,
            goRouter,
          );
          await tester.enterText(textFormFieldFinder, name);
          await tester.ensureVisible(
            find.widgetWithText(ElevatedButton, expectedOkString),
          );
          await tester.tap(
            find.widgetWithText(ElevatedButton, expectedOkString),
          );
          await tester.runAsync(() async {
            await Future.delayed(Duration(seconds: 1));
            await tester.pump();
            expect(
              find.descendant(
                of: find.byType(Center),
                matching: circularProgressIndicatorFinder,
              ),
              findsOne,
            );
            await tester.pumpAndSettle();
            expect(find.byType(SnackBar), findsOne);
            SnackBar snackBar = tester.widget(snackBarFinder);
            expect(
              (snackBar.content as Text).data,
              expectedFieldHasBeenCreatedString,
            );
            expect(find.byType(CreateFieldPage), findsNothing);
            expect(find.byType(FieldsPage), findsOne);
          });
        });
      });
    });
  });
}
