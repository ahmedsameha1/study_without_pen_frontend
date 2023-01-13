import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_runner.dart';

void main() async {
  await (AppRunner(
          const ProviderScope(child: Text("")),
          runApp,
          WidgetsFlutterBinding.ensureInitialized,
          Firebase.initializeApp,
          FirebaseOptions(apiKey: '', appId: '', messagingSenderId: '', projectId: ''))
      .run());
}
