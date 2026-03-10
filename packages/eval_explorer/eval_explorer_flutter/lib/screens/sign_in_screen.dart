import 'package:eval_explorer_client/eval_explorer_client.dart' show Client;
import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key, required this.client});

  final Client client;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: SignInWidget(
          client: client,
          disableEmailSignInWidget: true,
          disableAppleSignInWidget: true,
        ),
      ),
    );
  }
}
