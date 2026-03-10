import 'package:eval_explorer_client/eval_explorer_client.dart';
import 'package:eval_explorer_flutter/core/core.dart';
import 'package:go_router/go_router.dart';
import 'package:eval_explorer_flutter/screens/screens.dart';
import 'package:provider/provider.dart';

class Routes {
  const Routes._();

  static final login = GoRoute(
    path: '/login',
    name: 'login',
    builder: (context, state) => SignInScreen(
      client: context.read<Client>(),
    ),
  );
  static final home = GoRoute(
    path: '/',
    name: 'home',
    builder: (context, state) => HomeScreen(
      client: context.read<Client>(),
      profile: context.read<AuthBloc>().state.profile!,
    ),
  );

  static final initialRoute = login;
}
