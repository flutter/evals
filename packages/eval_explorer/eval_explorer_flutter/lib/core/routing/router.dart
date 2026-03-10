import 'dart:async';

import 'package:eval_explorer_flutter/core/auth/auth_bloc.dart';
import 'package:eval_explorer_flutter/core/routing/routes.dart';
import 'package:logging/logging.dart';
import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import 'redirection.dart';

final _log = Logger('AppRouter');

class AppRouter {
  AppRouter({required this.authBloc}) {
    redirection = GoRouterRedirector();

    router = GoRouter(
      routes: [
        Routes.login,
        Routes.home,
      ],
      initialLocation: Routes.initialRoute.path,
      redirect: (context, GoRouterState state) {
        lastRouteState = RouteState.fromGoRouterState(state);
        return _redirect(authBloc.state);
      },
    );

    authBloc.stream.listen((authState) {
      _log.finest('AuthState: $authState');
      final redirection = _redirect(authState);
      if (redirection != null) {
        lastRouteState = RouteState(
          uri: Uri.parse(redirection),
        );
        router.go(redirection);
      }
    });
  }

  final AuthBloc authBloc;

  /// [GoRouter] instance.
  late final GoRouter router;
  late final GoRouterRedirector redirection;

  /// Cache of the last known [RouteState].
  RouteState? lastRouteState;

  final _redirections = StreamController<String?>.broadcast();

  /// Emits redirection decisions
  @visibleForTesting
  Stream<String?> get allRedirects => _redirections.stream;

  String? _redirect(AuthState authState) {
    final redirect = redirection.redirect(
      routeState: lastRouteState ?? RouteState.initial(),
      authState: authState,
    );
    _redirections.add(redirect);
    return redirect;
  }
}
