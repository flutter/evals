import 'package:eval_explorer_flutter/core/app/app.dart';
import 'package:eval_explorer_flutter/serverpod_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  usePathUrlStrategy();
  runApp(App(client: await getClient()));
}
