import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/common/router_config.dart';

Widget createWidgetInASkeleton(Widget widget, nonso.AuthBloc bloc) {
  return MultiBlocProvider(
      providers: [BlocProvider(create: (context) => bloc)],
      child: MaterialApp.router(
          localizationsDelegates: [AppLocalizations.delegate, nonso.AppLocalizations.delegate],
          supportedLocales: AppLocalizations.supportedLocales,
          routerConfig: getRouterConfig()));
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
