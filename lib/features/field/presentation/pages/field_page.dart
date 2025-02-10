import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nonso/nonso.dart';

class FieldPage extends StatelessWidget {
  const FieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          BlocBuilder<AuthBloc, AuthState>(
            builder:(context, state) => 
             IconButton(
                key: Key("logoutIconButton"),
                onPressed: () => context.read<AuthBloc>().signOut(),
                icon: Icon(Icons.logout)),
          )
        ],
      ),
      //backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
