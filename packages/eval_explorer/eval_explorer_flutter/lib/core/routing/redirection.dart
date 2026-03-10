// ignore_for_file: avoid_redundant_argument_values
import 'package:eval_explorer_flutter/core/core.dart';
import 'package:logging/logging.dart';
import 'package:go_router/go_router.dart';

final _log = Logger('Redirection');

typedef Params = Map<String, String>;

/// {@template GoRouterRedirector}
/// Validates that the user's current location within the app is allowed by
/// their authentication state and other details like app health.
/// {@endtemplate}
class GoRouterRedirector {
  /// Singleton instance of the [GoRouterRedirector]. This class is always
  /// stateless, so there is no value in ever having separate instances.
  factory GoRouterRedirector() => const GoRouterRedirector._([
    AnonymousUsersToLogin(),
    AuthenticatedUsersAwayFromLogin(),
  ]);

  const GoRouterRedirector._(this._redirects);
  final List<Redirector> _redirects;

  /// Forced dead-end paths that, once routed to, cannot be routed away from by
  /// any other redirect rules; but instead, only by the undoing of the
  /// conditions that led to redirecting here in the first place.
  final doNotLeave = const <String>[
    // maintenance / upgrade routes, if they ever exist
  ];

  /// Compares the current [RouteState] against the [AppState] and returns a
  /// string to navigate to if required. Returns null if the current
  /// [RouteState] and [AppState] are compatible.
  String? redirect({
    required RouteState routeState,
    required AuthState authState,
  }) {
    _log.finest(
      'Considering redirect for "${routeState.path}" with user '
      '${authState.profile}',
    );
    if (doNotLeave.contains(routeState.path)) {
      _log.finest(
        'Not navigating away from ${routeState.path} for DO NOT LEAVE',
      );
      return null;
    }
    final current = Uri(
      path: routeState.path,
      queryParameters:
          routeState
              .uri
              .queryParameters
              .isNotEmpty //
          ? routeState.uri.queryParameters
          : null,
    );
    for (final redirect in _redirects) {
      if (redirect.predicate(routeState, authState)) {
        final newRouteState = redirect.getNewRouteState(routeState, authState);
        final uriString = newRouteState.uri.toString();

        if (uriString == current.toString()) {
          _log.warning(
            '$redirect attempted to redirect to itself at $uriString. '
            'This should have been caught earlier!',
          );
          continue;
        }

        _log.finer('$redirect redirecting from $current to $uriString');
        return uriString;
      } else {
        _log.finest(
          '$redirect declined to redirect away from ${routeState.path}',
        );
      }
    }
    _log.finer('Not redirecting away from ${routeState.path}');
    return null;
  }
}

/// {@template RouteState}
/// Simplified representation of the user's location within the app. Exists to
/// contain an individual routing solution from leaking its logic all across
/// the app's codebase.
/// {@endtemplate}
class RouteState {
  const RouteState({
    required this.uri,
    this.route,
  });

  final Uri uri;
  final GoRoute? route;

  String get path => uri.path;

  /// Converts a [GoRouterState] object into the values the rest of our app will
  /// care about.
  factory RouteState.fromGoRouterState(GoRouterState? state) =>
      state != null && state.fullPath != null
      ? //
        RouteState(
          uri: state.uri,
          route: state.topRoute,
        )
      : RouteState.initial();

  /// Builds a GoRouterState value from a given route.
  /// Useful for the initial route.
  factory RouteState.fromRoute(GoRoute route, {Params? pathParameters}) {
    String path = route.path;
    if (pathParameters != null) {
      for (final key in pathParameters.keys) {
        path = path.replaceAll(':$key', pathParameters[key]!);
      }
    }
    return RouteState(
      uri: Uri(path: path),
      route: route,
    );
  }

  /// Initial RouteState for the start of the app.
  factory RouteState.initial() => RouteState.fromRoute(Routes.initialRoute);
}

/// Individual utility within a [GoRouterRedirector] to enforce a single rule.
abstract class Redirector {
  /// Const constructor.
  const Redirector();

  /// Determines whether this redirection should take place.
  bool predicate(RouteState routeState, AuthState authState);

  /// Returns the desired [Uri] to send the user based on current app state.
  RouteState getNewRouteState(RouteState routeState, AuthState appState);

  @override
  String toString() => '$runtimeType()';
}

/// {@template AnonymousUsersToLogin}
/// Sends anonymous users to the login screen.
/// {@endtemplate}
class AnonymousUsersToLogin extends Redirector {
  /// {@macro AnonymousUsersToLogin}
  const AnonymousUsersToLogin();
  @override
  bool predicate(
    RouteState routeState,
    AuthState authState,
  ) => routeState.path != Routes.login.path && authState.profile == null;

  @override
  RouteState getNewRouteState(
    RouteState routeState,
    AuthState authState,
  ) => RouteState.fromRoute(Routes.login);
}

/// {@template AuthenticatedUsersAwayFromLogin}
/// Sends authenticated users away from the login screen.
/// {@endtemplate}
class AuthenticatedUsersAwayFromLogin extends Redirector {
  /// {@macro AuthenticatedUsersAwayFromLogin}
  const AuthenticatedUsersAwayFromLogin();
  @override
  bool predicate(
    RouteState routeState,
    AuthState authState,
  ) => routeState.path == Routes.login.path && authState.profile != null;

  @override
  RouteState getNewRouteState(
    RouteState routeState,
    AuthState authState,
  ) => RouteState.fromRoute(Routes.home);
}
