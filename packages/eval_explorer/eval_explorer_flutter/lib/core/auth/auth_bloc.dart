import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

import 'auth_service.dart';

part '../auth_bloc.freezed.dart';

typedef _Emit = Emitter<AuthState>;

/// {@template AuthBloc}
/// Application wide authentication BLoC.
/// {@endtemplate}
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  /// {@macro AuthBloc}
  AuthBloc(this._authService) : super(AuthState.initial()) {
    on<AuthEvent>(
      (event, _Emit emit) => switch (event) {
        NewUserEvent() => _onNewUserEvent(event, emit),
        LoggedOutEvent() => _onLoggedOutEvent(event, emit),
      },
    );

    // Listen to authentication changes
    _authService.listen(_onAuthChanges);
  }
  final AuthService _authService;

  Future<void> _onAuthChanges(UserProfileModel? profile) async {
    if (profile != null) {
      add(NewUserEvent(profile));
    } else {
      add(LoggedOutEvent());
    }
  }

  void _onNewUserEvent(NewUserEvent event, _Emit emit) =>
      emit(AuthState(profile: event.profile));

  Future<void> _onLoggedOutEvent(LoggedOutEvent event, _Emit emit) async {
    emit(AuthState(profile: null));
  }

  @override
  Future<void> close() async {
    _authService.close();
    super.close();
  }
}

/// Actions that can be taken on the auth page.
@Freezed()
sealed class AuthEvent with _$AuthEvent {
  const factory AuthEvent.newUser(UserProfileModel profile) = NewUserEvent;
  const factory AuthEvent.loggedOut() = LoggedOutEvent;
}

/// {@template AuthState}
/// Complete representation of the auth page's state.
/// {@endtemplate
@Freezed()
sealed class AuthState with _$AuthState {
  /// {@macro AuthState}
  const factory AuthState({
    UserProfileModel? profile,
  }) = _AuthState;
  const AuthState._();

  /// Starter state fed to the [AuthBloc].
  factory AuthState.initial() => const AuthState();
}
