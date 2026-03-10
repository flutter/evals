import 'package:eval_explorer_client/eval_explorer_client.dart';
import 'package:eval_explorer_flutter/core/core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class App extends StatefulWidget {
  const App({
    super.key,
    required this.client,
    this.appRouter,
    this.authBloc,
  });

  final Client client;
  final AppRouter? appRouter;
  final AuthBloc? authBloc;

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  late final AuthBloc authBloc;
  late final AppRouter appRouter;

  @override
  void initState() {
    super.initState();
    authBloc =
        widget.authBloc ?? //
        AuthBloc(ServerpodAuthService(widget.client));
    appRouter =
        widget.appRouter ?? //
        AppRouter(authBloc: authBloc);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider.value(value: widget.client),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: authBloc),
        ],
        child: MaterialApp.router(
          title: 'Dash Evals',
          theme: ThemeData(primarySwatch: Colors.blue),
          routerConfig: appRouter.router,
        ),
      ),
    );
  }
}
