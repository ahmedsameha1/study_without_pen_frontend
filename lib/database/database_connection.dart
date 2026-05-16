import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

LazyDatabase openConnection() => LazyDatabase(() async {
  const databaseFileName = 'data';
  final applicationDocumentDirectory = await getApplicationDocumentsDirectory();
  var file = File(
    join(
      applicationDocumentDirectory.parent.path,
      'databases',
      databaseFileName,
    ),
  );
  if (!file.existsSync()) {
    file = File(join(applicationDocumentDirectory.path, databaseFileName));
  }
  return NativeDatabase(file);
});
