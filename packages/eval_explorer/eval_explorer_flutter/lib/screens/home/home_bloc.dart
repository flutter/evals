import 'package:eval_explorer_client/eval_explorer_client.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

part 'home_bloc.freezed.dart';

typedef _Emit = Emitter<HomeState>;

/// {@template HomeBloc}
/// Application state manager for the [HomeScreen] widget.
/// {@endtemplate}
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  /// {@macro HomeBloc}
  HomeBloc(this._client, {required this.profile})
    : super(HomeState.initial(profile: profile)) {
    on<HomeEvent>(
      (event, _Emit emit) => switch (event) {
        InitializeHome() => _onInitializeHome(event, emit),
      },
    );
  }
  // ignore: unused_field
  final Client _client;
  final UserProfileModel profile;

  Future<void> _onInitializeHome(InitializeHome event, _Emit emit) async {}
}

/// Actions that can be taken on the Home page.
@Freezed()
sealed class HomeEvent with _$HomeEvent {
  /// Placeholder event.
  const factory HomeEvent.init() = InitializeHome;
}

/// {@template HomeState}
/// Complete representation of the Home page's state.
/// {@endtemplate
@Freezed()
sealed class HomeState with _$HomeState {
  /// {@macro HomeState}
  const factory HomeState({
    required UserProfileModel profile,
  }) = _HomeState;
  const HomeState._();

  /// Starter state fed to the [HomeBloc].
  factory HomeState.initial({required UserProfileModel profile}) =>
      HomeState(profile: profile);
}
