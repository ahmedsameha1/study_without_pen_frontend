import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_without_pen_by_flutter/firebase_options.dart';

import 'app_runner.dart';
import 'widget/main_widget.dart';

void main() async {
  await (AppRunner(
          const ProviderScope(child: MainWidget()),
          runApp,
          WidgetsFlutterBinding.ensureInitialized,
          Firebase.initializeApp,
          DefaultFirebaseOptions.currentPlatform)
      .run());
}
