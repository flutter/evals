import 'dart:async';

import 'package:eval_explorer_flutter/core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class MockAuthBloc extends Mock implements AuthBloc {}

void main() {
  late MockAuthBloc authBloc;
  late AppRouter appRouter;
  late StreamController<AuthState> authStateController;

  setUp(() {
    authBloc = MockAuthBloc();
    authStateController = StreamController<AuthState>.broadcast();

    when(() => authBloc.state).thenReturn(AuthState.initial());
    when(() => authBloc.stream).thenAnswer((_) => authStateController.stream);
  });

  tearDown(() {
    authStateController.close();
  });

  group('When logging in then out, AppRouter should', () {
    test(
      'redirect to the home screen then login screen',
      () async {
        appRouter = AppRouter(authBloc: authBloc);

        // Expect redirect to home
        final expectation = expectLater(
          appRouter.allRedirects,
          emitsInOrder([
            Routes.home.path,
            Routes.login.path,
          ]),
        );

        // Simulate user logging in
        final profile = UserProfileModel(
          authUserId: UuidValue.fromString(Uuid().v4()),
        );
        final newState = AuthState(profile: profile);
        when(() => authBloc.state).thenReturn(newState);
        authStateController.add(newState);

        final loggedOutState = AuthState(profile: null);
        when(() => authBloc.state).thenReturn(loggedOutState);
        authStateController.add(loggedOutState);

        await expectation;
      },
      timeout: const Timeout(Duration(seconds: 1)),
    );
  });
}
