import 'package:eval_explorer_client/eval_explorer_client.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'config/app_config.dart';

Client? _client;

Future<Client> getClient() async {
  if (_client == null) {
    // When you are running the app on a physical device, you need to set the
    // server URL to the IP address of your computer. You can find the IP
    // address by running `ipconfig` on Windows or `ifconfig` on Mac/Linux.
    // You can set the variable when running or building your app like this:
    // E.g. `flutter run --dart-define=SERVER_URL=https://api.example.com/`
    const serverUrlFromEnv = String.fromEnvironment('SERVER_URL');
    // AppConfig loads the API server URL from the assets/config.json file.
    // When the app runs in a browser, this file is fetched from the server,
    // allowing the server to change the API URL at runtime.
    // This ensures the app always uses the correct API URL,
    // no matter which environment it is running in.
    final config = await AppConfig.loadConfig();
    final serverUrl = serverUrlFromEnv.isEmpty
        ? config.apiUrl ?? 'http://$localhost:8080/'
        : serverUrlFromEnv;
    _client = Client(serverUrl)
      ..connectivityMonitor = FlutterConnectivityMonitor()
      ..authSessionManager = FlutterAuthSessionManager();
    await _client!.auth.initialize();
  }

  return _client!;
}
