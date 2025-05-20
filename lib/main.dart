import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:study_without_pen_by_flutter/common/widget/app.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/features/field/data/repositories/field_repository_local.dart';
import 'package:study_without_pen_by_flutter/features/field/domain/usecases/create_field_usecase.dart';

import 'firebase_options.dart';

late AppDatabase appDatabase;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError =
      (details) => log(details.exceptionAsString(), stackTrace: details.stack);
  WidgetsBinding.instance.platformDispatcher.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  appDatabase = AppDatabase(AppDatabase.openConnection());
  runApp(MultiRepositoryProvider(providers: [
    RepositoryProvider<FirebaseAuth>.value(value: FirebaseAuth.instance),
    RepositoryProvider<CreateFieldUseCase>(
      create: (context) =>
          CreateFieldUseCase(FieldRepositoryLocal(FieldsDao(appDatabase))),
    ),
  ], child: App()));
}
