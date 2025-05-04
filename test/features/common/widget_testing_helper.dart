import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/create_field_page.dart';
import 'package:study_without_pen_by_flutter/features/field/presentation/pages/field_page.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/common/router_config.dart';

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

Widget createWidgetInASkeleton(Widget widget, nonso.AuthBloc bloc) {
  return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => bloc)],
      child: MaterialApp.router(
          localizationsDelegates: [
            AppLocalizations.delegate,
            nonso.AppLocalizations.delegate
          ],
          supportedLocales: AppLocalizations.supportedLocales,
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

Widget createWidgetInASkeletonB(Widget widget) {
  return MaterialApp.router(
    localizationsDelegates: [
      AppLocalizations.delegate,
      nonso.AppLocalizations.delegate
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    theme: AppThemeForTests.theme,
    routerConfig: GoRouter(routes: [
      GoRoute(
        path: "/",
        builder: (context, state) => ParentPage("/child"),
        routes: [GoRoute(path: "child", builder: (context, state) => widget)],
      )
    ]),
  );
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
  return nonso.AuthScreen(FieldPage());
}

Widget createFieldPathBuilder(
    BuildContext buildContext, GoRouterState goRouterState) {
  return CreateFieldPage(
    usecaseValidationTest: true,
  );
}
