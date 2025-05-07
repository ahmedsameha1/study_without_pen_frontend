import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/common/theme.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/create_field_usecase.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations_en.dart';
import 'package:uuid/uuid.dart';

import '../router_config.dart';

class App extends StatelessWidget {
  const App(this.firebaseAuth, {super.key});
  final FirebaseAuth firebaseAuth;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseAuth>.value(value: firebaseAuth),
        RepositoryProvider<CreateFieldUseCase>(
          create: (context) => CreateFieldUseCase(),
        ),
        RepositoryProvider<Uuid>(
          create: (context) => Uuid(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<nonso.AuthBloc>(
              create: (context) => nonso.AuthBloc(context.read<FirebaseAuth>()))
        ],
        child: MaterialApp.router(
          localizationsDelegates: [
            AppLocalizations.delegate,
            nonso.AppLocalizations.delegate
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          title: AppLocalizationsEn().materialAppTitle,
          routerConfig: getRouterConfig(),
          theme: AppTheme.theme,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
