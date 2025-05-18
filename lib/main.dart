import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:study_without_pen_by_flutter/common/widget/app_widget.dart';
import 'package:study_without_pen_by_flutter/database/app_database.dart';
import 'package:study_without_pen_by_flutter/database/fields_dao.dart';
import 'package:study_without_pen_by_flutter/features/field/data/repositories/field_repository_local.dart';

import 'firebase_options.dart';

late AppDatabase appDatabase;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  appDatabase = AppDatabase(AppDatabase.openConnection());
  runApp(App(FirebaseAuth.instance, FieldRepositoryLocal(FieldsDao(appDatabase))));
}
