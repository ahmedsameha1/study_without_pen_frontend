import 'dart:async';
import 'package:clock/clock.dart';
import 'package:drift/native.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/common/widgets/ok_cancel.dart';
import 'package:study_without_pen_by_flutter/common/widgets/pick_color.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/watch_field_lists_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/create_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_fields_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/cubit/create_field_cubit.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/create_field_page.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/fields_page.dart';
import 'package:study_without_pen_by_flutter/common/router_config.dart'
    as this_app;

import '../../../common/common_finders.dart';
import '../../../common/widget_testing_helper.dart';
import 'fields_page_test.dart';

Future<void> goToCreateFieldPage(
  Widget widgetInskeleton,
  WidgetTester tester,
) async {
  await tester.pumpWidget(widgetInskeleton);
  await tester.tap(find.byType(FloatingActionButton));
  await tester.pumpAndSettle();
}

void main() {
  late CreateFieldUseCase createFieldUseCase;
  late WatchFieldsUsecase watchFieldsUsecase;
  late WatchFieldListsUsecase watchFieldListsUsecase;
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
    watchFieldsUsecase = MockWatchFieldsUsecase();
    createFieldUseCase = MockCreateFieldUseCase();
    watchFieldListsUsecase = MockWatchFieldListsUsecase();
    when(() => user.uid).thenReturn(userId);
    when(() => authBloc.state).thenReturn(
      nonso.AuthState(
        applicationAuthState: nonso.ApplicationAuthState.signedIn,
        user: user,
      ),
    );
    when(() => authBloc.signOut()).thenAnswer((_) => Completer<void>().future);
  });

  group("Engish Locale", () {
    Locale currentLocale = const Locale("en");

    testWidgets("Test the presence of the main widgets", (
      WidgetTester tester,
    ) async {
      await goToCreateFieldPage(
        createWidgetInASkeleton(
          authBloc,
          createFieldUseCase,
          watchFieldsUsecase,
          watchFieldListsUsecase,
          currentLocale,
          this_app.getRouterConfig,
        ),
        tester,
      );
      await tester.pumpAndSettle();
      final createFieldPageFinder = find.byType(CreateFieldPage);
      expect(createFieldPageFinder, findsOneWidget);
      expect(
        find.descendant(
          of: createFieldPageFinder,
          matching: find.byType(BlocProvider<CreateFieldCubit>),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(BlocProvider<CreateFieldCubit>),
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

    testWidgets("name text form field validation", (WidgetTester tester) async {
      await goToCreateFieldPage(
        createWidgetInASkeleton(
          authBloc,
          createFieldUseCase,
          watchFieldsUsecase,
          watchFieldListsUsecase,
          currentLocale,
          this_app.getRouterConfig,
        ),
        tester,
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

    testWidgets("Test clicking the cancel button exit the create field page", (
      WidgetTester tester,
    ) async {
      await goToCreateFieldPage(
        createWidgetInASkeleton(
          authBloc,
          createFieldUseCase,
          watchFieldsUsecase,
          watchFieldListsUsecase,
          currentLocale,
          this_app.getRouterConfig,
        ),
        tester,
      );
      await tester.pumpAndSettle();
      expect(find.byType(CreateFieldPage), findsOneWidget);
      await tester.tap(
        find.widgetWithText(ElevatedButton, expectedCancelString),
      );
      await tester.pumpAndSettle();
      expect(find.byType(CreateFieldPage), findsNothing);
    });

    group('Ok button', () {
      testWidgets("Test clicking the ok button: validation error", (
        WidgetTester tester,
      ) async {
        DateTime creationAt = DateTime(2020, 1, 1);
        final name = "";
        int color = 0xff520404;
        when(() => createFieldUseCase.call(userId, name, color)).thenThrow(
          AssertionError('Field name must be between 1 and 64 characters'),
        );
        withClock(Clock.fixed(creationAt), () async {
          await goToCreateFieldPage(
            createWidgetInASkeleton(
              authBloc,
              createFieldUseCase,
              watchFieldsUsecase,
              watchFieldListsUsecase,
              currentLocale,
              getRouterConfig,
            ), //bybassing form validation
            tester,
          );
          expect(find.byType(CreateFieldPage), findsOneWidget);
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
            expect((snackBar.content as Text).data, expectedInvalidNameString);
            expect(
              find.descendant(of: find.byType(Center), matching: cardFinder),
              findsOne,
            );
          });
        });
      });

      testWidgets("Test clicking the ok button: failure from the date repo", (
        WidgetTester tester,
      ) async {
        DateTime creationAt = DateTime(2020, 1, 1);
        final name = "field name";
        int color = 0xff520404;
        when(() => createFieldUseCase.call(userId, name, color)).thenThrow(
          SqliteException(
            extendedResultCode: 1,
            message: "Error from database",
          ),
        );
        withClock(Clock.fixed(creationAt), () async {
          await goToCreateFieldPage(
            createWidgetInASkeleton(
              authBloc,
              createFieldUseCase,
              watchFieldsUsecase,
              watchFieldListsUsecase,
              currentLocale,
              this_app.getRouterConfig,
            ),
            tester,
          );
          expect(find.byType(CreateFieldPage), findsOneWidget);
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
          () => createFieldUseCase.call(userId, name, color),
        ).thenAnswer((_) => Future.value(1));
        withClock(Clock.fixed(creationAt), () async {
          await goToCreateFieldPage(
            createWidgetInASkeleton(
              authBloc,
              createFieldUseCase,
              watchFieldsUsecase,
              watchFieldListsUsecase,
              currentLocale,
              this_app.getRouterConfig,
            ),
            tester,
          );
          expect(find.byType(CreateFieldPage), findsOneWidget);
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
