import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonso/nonso.dart' as nonso;

import 'common/widgets/app.dart';
import 'database/app_database.dart';
import 'database/entrys_dao.dart';
import 'database/field_lists_dao.dart';
import 'database/fields_dao.dart';
import 'features/entries/data/repositories/entries_repository.dart';
import 'features/entries/data/repositories/entries_repository_local.dart';
import 'features/entries/domain/usecases/create_entry_usecase.dart';
import 'features/entries/domain/usecases/watch_entries_usecase.dart';
import 'features/field_lists/data/repositories/field_lists_repository.dart';
import 'features/field_lists/data/repositories/field_lists_repository_local.dart';
import 'features/field_lists/domain/usecases/create_field_list_usecase.dart';
import 'features/field_lists/domain/usecases/watch_field_lists_usecase.dart';
import 'features/fields/data/repositories/fields_repository.dart';
import 'features/fields/data/repositories/fields_repository_local.dart';
import 'features/fields/domain/usecases/create_field_usecase.dart';
import 'features/fields/domain/usecases/watch_field_usecase.dart';
import 'features/fields/domain/usecases/watch_fields_usecase.dart';
import 'firebase_options.dart';

late AppDatabase appDatabase;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (details) =>
      log(details.exceptionAsString(), stackTrace: details.stack);
  WidgetsBinding.instance.platformDispatcher.onError = (error, stack) {
    log(error.toString(), stackTrace: stack);
    return true;
  };
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  appDatabase = AppDatabase(AppDatabase.openConnection());
  FieldsDao fieldsDao = FieldsDao(appDatabase);
  FieldListsDao fieldListsDao = FieldListsDao(appDatabase);
  EntrysDao entrysDao = EntrysDao(appDatabase);
  FieldsRepository fieldsRepository = FieldsRepositoryLocal(fieldsDao);
  FieldListsRepository fieldListsRepository = FieldListsRepositoryLocal(
    fieldListsDao,
  );
  EntriesRepository entriesRepository = EntriesRepositoryLocal(entrysDao);
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<nonso.AuthBloc>(
          create: (context) => nonso.AuthBloc(FirebaseAuth.instance),
        ),
        RepositoryProvider<CreateFieldUseCase>(
          create: (context) => CreateFieldUseCase(fieldsRepository),
        ),
        RepositoryProvider<WatchFieldsUsecase>(
          create: (context) => WatchFieldsUsecase(fieldsRepository),
        ),
        RepositoryProvider<WatchFieldUsecase>(
          create: (context) => WatchFieldUsecase(fieldsRepository),
        ),
        RepositoryProvider<WatchFieldListsUsecase>(
          create: (context) =>
              WatchFieldListsUsecase(fieldsRepository, fieldListsRepository),
        ),
        RepositoryProvider<CreateFieldListUsecase>(
          create: (context) => CreateFieldListUsecase(fieldListsRepository),
        ),
        RepositoryProvider<CreateEntryUsecase>(
          create: (context) =>
              CreateEntryUsecase(fieldListsRepository, entriesRepository),
        ),
        RepositoryProvider<WatchEntriesUsecase>(
          create: (context) =>
              WatchEntriesUsecase(fieldListsRepository, entriesRepository),
        ),
      ],
      child: App(),
    ),
  );
}
