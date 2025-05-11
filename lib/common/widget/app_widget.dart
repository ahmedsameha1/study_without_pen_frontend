import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/common/theme.dart';
import 'package:study_without_pen_by_flutter/features/field/data/repositories/field_repository.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/usecases/create_field_usecase.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations.dart';
import 'package:study_without_pen_by_flutter/l10n/app_localizations_en.dart';

import '../router_config.dart';

class App extends StatelessWidget {
  const App(this.firebaseAuth, this.fieldRepository, {super.key});
  final FirebaseAuth firebaseAuth;
  final FieldRepository fieldRepository;
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<FirebaseAuth>.value(value: firebaseAuth),
        RepositoryProvider<CreateFieldUseCase>(
          create: (context) => CreateFieldUseCase(fieldRepository),
        ),
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
