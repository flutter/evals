import 'package:eval_explorer_flutter/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

void main() {
  group('Redirection', () {
    test('should keep anonymous users on login screen', () {
      final redirection = GoRouterRedirector();
      final result = redirection.redirect(
        routeState: RouteState.initial(),
        authState: AuthState(profile: null),
      );
      expect(result, null);
    });

    test('should redirect logged in users to home screen', () {
      final redirection = GoRouterRedirector();
      final result = redirection.redirect(
        routeState: RouteState.initial(),
        authState: AuthState(
          profile: UserProfileModel(
            authUserId: UuidValue.fromString(Uuid().v4()),
          ),
        ),
      );
      expect(result, Routes.home.path);
    });

    test('should keep logged in users on home screen', () {
      final redirection = GoRouterRedirector();
      final result = redirection.redirect(
        routeState: RouteState.fromRoute(Routes.home),
        authState: AuthState(
          profile: UserProfileModel(
            authUserId: UuidValue.fromString(Uuid().v4()),
          ),
        ),
      );
      expect(result, null);
    });

    test('should return logging out users to the login page', () {
      final redirection = GoRouterRedirector();
      final result = redirection.redirect(
        routeState: RouteState.fromRoute(Routes.home),
        authState: AuthState(profile: null),
      );
      expect(result, Routes.login.path);
    });
  });
}
