import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/auth_state.dart';
import '../state/providers.dart';
import 'email.dart';
import 'locked.dart';
import 'password.dart';
import 'register.dart';

class MainScreen extends ConsumerWidget {
  static const String signInUpString = "Sign in/up";
  static const String path = "/";
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStateNotifier = ref.read(authStateNotifierProvider);
    final authState = ref.watch(authStateProvider);
    final body;
    AppBar? appBar;
    switch (authState.applicationLoginState) {
      case ApplicationLoginState.loggedOut:
        body = TextButton(
            onPressed: authStateNotifier.startLoginFlow,
            child: const Text(signInUpString));
        break;
      case ApplicationLoginState.emailAddress:
        body =
            Email(authStateNotifier.verifyEmail, authStateNotifier.toLoggedOut);
        break;
      case ApplicationLoginState.password:
        body = Password(
            authState.email!,
            authStateNotifier.signInWithEmailAndPassword,
            authStateNotifier.toLoggedOut);
        break;
      case ApplicationLoginState.register:
        body = Register(authState.email!, authStateNotifier.registerAccount,
            authStateNotifier.toLoggedOut);
        break;
      case ApplicationLoginState.locked:
        body = Locked(
            authStateNotifier.updateUser,
            authStateNotifier.sendEmailToVerifyEmailAddress,
            authStateNotifier.signOut);
        break;
      case ApplicationLoginState.loggedIn:
        body = const Center(child: Text("Loaded"));
        appBar = AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: authStateNotifier.signOut,
            )
          ],
        );
        break;
    }
    return Scaffold(
      appBar: appBar,
      body: body,
    );
  }
}
