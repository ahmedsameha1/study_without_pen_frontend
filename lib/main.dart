import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(App());
}

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    final StatelessWidget realAppWidgetPlaceholder,
        hasErrorWidgetPlaceHolder,
        loadingWidgetPlaceholder;
    realAppWidgetPlaceholder =
        hasErrorWidgetPlaceHolder = loadingWidgetPlaceholder = Container();

    return FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            // This is a placeholder for an error widget
            return hasErrorWidgetPlaceHolder;
          }

          if (snapshot.connectionState == ConnectionState.done) {
            // This is a placeholder for the real app
            return realAppWidgetPlaceholder;
          }

          // This is a placeholder for loading widget while waiting for initialization
          return loadingWidgetPlaceholder;
        });
  }
}
