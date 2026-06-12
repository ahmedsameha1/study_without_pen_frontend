import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonso/nonso.dart' as nonso;

import 'common/widgets/app.dart';
import 'database/app_database.dart';
import 'database/database_connection.dart';
import 'database/entrys_dao.dart';
import 'database/field_list_notes_dao.dart';
import 'database/field_lists_dao.dart';
import 'database/fields_dao.dart';
import 'features/entries/data/repositories/entries_repository.dart';
import 'features/entries/data/repositories/entries_repository_local.dart';
import 'features/entries/domain/usecases/create_entry_usecase.dart';
import 'features/entries/domain/usecases/watch_entries_usecase.dart';
import 'features/field_list_notes/data/repositories/field_list_notes_repository.dart';
import 'features/field_list_notes/data/repositories/field_list_notes_repository_local.dart';
import 'features/field_list_notes/domain/usecases/watch_field_list_notes_usecase.dart';
import 'features/field_lists/data/repositories/field_lists_repository.dart';
import 'features/field_lists/data/repositories/field_lists_repository_local.dart';
import 'features/field_lists/domain/usecases/create_field_list_usecase.dart';
import 'features/field_lists/domain/usecases/watch_field_lists_with_entries_count_usecase.dart';
import 'features/fields/data/repositories/fields_repository.dart';
import 'features/fields/data/repositories/fields_repository_local.dart';
import 'features/fields/domain/usecases/create_field_usecase.dart';
import 'features/fields/domain/usecases/delete_field_usecase.dart';
import 'features/fields/domain/usecases/watch_field_usecase.dart';
import 'features/fields/domain/usecases/watch_fields_with_field_lists_count_usecase.dart';
import 'features/userless_data_migration/domain/usecases/give_user_to_the_userless_data_after_first_signin_usecase.dart';
import 'firebase_options.dart';

late AppDatabase appDatabase;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FlutterError.onError = (errorDetails) =>
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  appDatabase = AppDatabase(openConnection());
  await appDatabase.runMigrationsEarly();
  FieldsDao fieldsDao = FieldsDao(appDatabase);
  FieldListsDao fieldListsDao = FieldListsDao(appDatabase);
  EntrysDao entrysDao = EntrysDao(appDatabase);
  FieldListNotesDao fieldListNotesDao = FieldListNotesDao(appDatabase);
  FieldsRepository fieldsRepository = FieldsRepositoryLocal(fieldsDao);
  FieldListsRepository fieldListsRepository = FieldListsRepositoryLocal(
    fieldListsDao,
  );
  EntriesRepository entriesRepository = EntriesRepositoryLocal(entrysDao);
  FieldListNotesRepository fieldListNotesRepository =
      FieldListNotesRepositoryLocal(fieldListNotesDao);
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<nonso.AuthBloc>(
          create: (context) => nonso.AuthBloc(FirebaseAuth.instance),
        ),
        RepositoryProvider<CreateFieldUsecase>(
          create: (context) => CreateFieldUsecase(fieldsRepository),
        ),
        RepositoryProvider<WatchFieldsWithFieldListsCountUsecase>(
          create: (context) =>
              WatchFieldsWithFieldListsCountUsecase(fieldsRepository),
        ),
        RepositoryProvider<WatchFieldUsecase>(
          create: (context) => WatchFieldUsecase(fieldsRepository),
        ),
        RepositoryProvider<WatchFieldListsWithEntriesCountUsecase>(
          create: (context) => WatchFieldListsWithEntriesCountUsecase(
            fieldsRepository,
            fieldListsRepository,
          ),
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
        RepositoryProvider<GiveUserToTheUserlessDataAfterFirstSignInUsecase>(
          create: (context) => GiveUserToTheUserlessDataAfterFirstSignInUsecase(
            fieldsRepository,
          ),
        ),
        RepositoryProvider<WatchFieldListNotesUsecase>(
          create: (context) => WatchFieldListNotesUsecase(
            fieldListsRepository,
            fieldListNotesRepository,
          ),
        ),
        RepositoryProvider<DeleteFieldUsecase>(
          create: (context) => DeleteFieldUsecase(fieldsRepository),
        ),
      ],
      child: const App(),
    ),
  );
}
