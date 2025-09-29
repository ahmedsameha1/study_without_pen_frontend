import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonso/nonso.dart' as nonso;
import 'package:study_without_pen_by_flutter/common/widget/app.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/field_lists_dao.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/data/repositories/field_lists_repository_local.dart';
import 'package:study_without_pen_by_flutter/features/field_lists/domain/usecases/watch_field_lists_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository.dart';
import 'package:study_without_pen_by_flutter/features/fields/data/repositories/fields_repository_local.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/create_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_field_usecase.dart';
import 'package:study_without_pen_by_flutter/features/fields/domain/usecases/watch_fields_usecase.dart';

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
  FieldsDao fieldsDao = FieldsDao(appDatabase);
  FieldListsDao fieldListsDao = FieldListsDao(appDatabase);
  FieldsRepository fieldRepository = FieldsRepositoryLocal(fieldsDao);
  FieldListsRepository fieldListsRepository =
      FieldListsRepositoryLocal(fieldListsDao);
  runApp(MultiRepositoryProvider(providers: [
    RepositoryProvider<nonso.AuthBloc>(
        create: (context) => nonso.AuthBloc(FirebaseAuth.instance)),
    RepositoryProvider<CreateFieldUseCase>(
      create: (context) => CreateFieldUseCase(fieldRepository),
    ),
    RepositoryProvider<WatchFieldsUsecase>(
      create: (context) => WatchFieldsUsecase(fieldRepository),
    ),
    RepositoryProvider<WatchFieldUsecase>(
      create: (context) => WatchFieldUsecase(fieldRepository),
    ),
    RepositoryProvider<WatchFieldListsUsecase>(
      create: (context) => WatchFieldListsUsecase(fieldListsRepository),
    )
  ], child: App()));
}
