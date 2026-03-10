import 'dart:async';

import 'package:eval_explorer_client/eval_explorer_client.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

/// {@template AuthService}
/// Abstraction around actual authentication mechanisms.
/// {@endtemplate}
abstract class AuthService {
  /// Stream which emits new user models, or [null] if a user logs out.
  ///
  /// The subscribing function is called immediately with the current value.
  StreamSubscription<UserProfileModel?> listen(
    Function(UserProfileModel? profile) onUserChanged,
  );

  /// Terminates the active session. If there was an active session, this will
  /// lead to any callbacks registered via [listen] to receive a `null` value.
  Future<void> logOut();

  /// Closes the service, releasing any resources.
  void close();
}

class ServerpodAuthService implements AuthService {
  ServerpodAuthService(this._client) {
    _client.authSessionManager.authInfoListenable.addListener(
      _onServerpodAuthChanged,
    );
  }

  UserProfileModel? profile;
  final Client _client;
  final StreamController<UserProfileModel?> _controller =
      StreamController<UserProfileModel?>.broadcast();

  @override
  StreamSubscription<UserProfileModel?> listen(
    Function(UserProfileModel? profile) onUserChanged,
  ) {
    final sub = _controller.stream.listen(onUserChanged);
    // Emit the current value immediately.
    onUserChanged(profile);
    return sub;
  }

  Future<void> _onServerpodAuthChanged() async {
    if (_client.authSessionManager.isAuthenticated) {
      profile = await _client.modules.serverpod_auth_core.userProfileInfo.get();
    } else {
      profile = null;
    }
    _controller.add(profile);
  }

  @override
  Future<void> logOut() async {
    await _client.authSessionManager.signOutDevice();
  }

  @override
  void close() {
    _client.authSessionManager.authInfoListenable.removeListener(
      _onServerpodAuthChanged,
    );
    _controller.close();
  }
}
