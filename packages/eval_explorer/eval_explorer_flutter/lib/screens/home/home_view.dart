import 'dart:async';

import 'package:eval_explorer_client/eval_explorer_client.dart';
import 'package:eval_explorer_flutter/core/core.dart';
import 'package:flutter/material.dart';
import 'package:eval_explorer_flutter/screens/home/home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart'
    show UserProfileModel;

/// {@template HomeScreen}
/// Initial Home screen.
/// {@endtemplate}
class HomeScreen extends StatefulWidget {
  /// {@macro HomeScreen}
  const HomeScreen({super.key, required this.client, required this.profile});

  final Client client;
  final UserProfileModel profile;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeBloc bloc = HomeBloc(widget.client, profile: widget.profile);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: bloc,
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('Home')),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              TextButton(
                onPressed: () => {},
                child: Text(
                  'Home :: '
                  '${state.profile.userName ?? state.profile.email ?? state.profile.authUserId}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              TextButton(
                onPressed: () => context.read<AuthBloc>().add(LoggedOutEvent()),
                child: Text(
                  'Logout',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    unawaited(bloc.close());
  }
}
