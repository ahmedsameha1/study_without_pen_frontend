import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/common/router_config.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/watch_field_lists_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/create_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_fields_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/create_field_page.dart';
import 'package:study_without_pen_by_flutter/features/fields/presentation/pages/fields_page.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:study_without_pen_by_flutter/main.dart' as app;

class MockUser extends Mock implements User {}

class MockCreateFieldUseCase extends Mock implements CreateFieldUseCase {}

class MockWatchFieldsUsecase extends Mock implements WatchFieldsUsecase {}

class MockWatchFieldUsecase extends Mock implements WatchFieldUsecase {}

class MockWatchFieldListsUsecase extends Mock
    implements WatchFieldListsUsecase {}

class AppThemeForTests {
  static const seedColor = Color(0xFFEC407A);
  static final lightColorScheme = ColorScheme.fromSeed(
      seedColor: seedColor,
      dynamicSchemeVariant: DynamicSchemeVariant.content,
      brightness: Brightness.light);
  static ThemeData get theme {
    ColorScheme colorScheme = lightColorScheme;
    final baseTheme = ThemeData(
      brightness: Brightness.light,
      colorScheme: colorScheme,
      appBarTheme: AppBarTheme().copyWith(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData().copyWith(
          shape: CircleBorder(), backgroundColor: colorScheme.primary),
    );
    return baseTheme;
  }
}

Widget createWidgetInASkeleton(
    nonso.AuthBloc bloc,
    CreateFieldUseCase createFieldUseCase,
    WatchFieldsUsecase watchFieldsUsecase,
    WatchFieldListsUsecase watchFieldListsUsecase,
    Locale locale,
    GoRouter Function() getRouterConfig) {
  return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: bloc),
        RepositoryProvider.value(value: createFieldUseCase),
        RepositoryProvider.value(value: watchFieldsUsecase),
        RepositoryProvider.value(value: watchFieldListsUsecase),
      ],
      child: MaterialApp.router(
          localizationsDelegates: [
            AppLocalizations.delegate,
            nonso.AppLocalizations.delegate
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          locale: locale,
          routerConfig: getRouterConfig()));
}

class ParentPage extends StatelessWidget {
  final String childPath;
  const ParentPage(this.childPath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TextButton(
          onPressed: () => GoRouter.of(context).go(childPath),
          child: Text("child")),
    );
  }
}

bool checkWidgetsOrder(List<Widget> widgets, List<Widget> shouldList) {
  for (int i = 0; i < shouldList.length - 1; i++) {
    final index_1 = widgets.indexOf(shouldList[i]);
    final index_2 = widgets.indexOf(shouldList[i + 1]);
    if (index_1 == -1 || index_2 == -1 || index_1 >= index_2) {
      return false;
    }
  }
  return true;
}

GoRouter getRouterConfig() {
  return GoRouter(routes: [
    GoRoute(
        path: rootPath,
        builder: rootPathBuilder,
        routes: [GoRoute(path: createField, builder: createFieldPathBuilder)])
  ]);
}

Widget rootPathBuilder(BuildContext buildContext, GoRouterState goRouterState) {
  return nonso.AuthScreen(FieldsPage());
}

Widget createFieldPathBuilder(
    BuildContext buildContext, GoRouterState goRouterState) {
  return CreateFieldPage(
    usecaseValidationTest: true,
  );
}

Future<void> runAppWhileHandlingFlutterError(WidgetTester tester) async {
  final originalOnError = FlutterError.onError!;
  await app.main();
  final overridenOnError = FlutterError.onError!;
  FlutterError.onError = (FlutterErrorDetails details) {
    if (originalOnError != overridenOnError) {
      overridenOnError(details);
    }
    originalOnError(details);
  };
}
