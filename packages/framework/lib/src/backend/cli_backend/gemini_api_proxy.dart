import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:ai/ai.dart' as ai;

import '../../logging/eval_log.dart';
import '../model_provider.dart';

/// A local HTTP server that proxies Gemini API requests from a CLI agent to
/// the framework's [ModelProvider].
///
/// The CLI agent (e.g. Gemini CLI) is configured via the
/// `GEMINI_API_BASE_URL` (or equivalent) environment variable to send its
/// requests to this proxy instead of calling Google's servers directly.
///
/// The proxy:
/// 1. Receives `POST /v1beta/models/{model}:generateContent` requests.
/// 2. Routes them through the framework's [ModelProvider].
/// 3. Returns responses in Gemini REST API format.
/// 4. Captures all turns for trajectory export via [transcript].
///
/// ## Lifecycle
///
/// ```dart
/// final proxy = GeminiApiProxy(provider: GenkitModelProvider(genkit: genkit));
/// await proxy.start();
///
/// // Pass the proxy URL to the CLI agent inside the sandbox:
/// // GEMINI_API_BASE_URL=http://host.docker.internal:<proxy.port>
///
/// final result = await agent.runInSandbox(proxyPort: proxy.port, ...);
/// final messages = proxy.transcript; // full captured history
/// await proxy.stop();
/// ```
class GeminiApiProxy {
  /// The [ModelProvider] used to fulfill generation requests.
  final ModelProvider provider;

  HttpServer? _server;
  final _transcript = <ai.Message>[];

  GeminiApiProxy({required this.provider});

  /// The port the proxy is listening on after [start] is called.
  int get port {
    assert(_server != null, 'Call start() before accessing port.');
    return _server!.port;
  }

  /// The full message history captured from all generate calls.
  ///
  /// Updated after each request. Safe to read after [stop].
  List<ai.Message> get transcript => List.unmodifiable(_transcript);

  /// Starts the proxy on a random available port on all IPv4 interfaces.
  Future<void> start() async {
    _server = await HttpServer.bind(InternetAddress.anyIPv4, 0);
    EvalLog.debug('[Proxy] Listening on port ${_server!.port}');
    _serve();
  }

  /// Stops the proxy and releases the port.
  Future<void> stop() async {
    await _server?.close(force: true);
    _server = null;
    EvalLog.debug('[Proxy] Stopped');
  }

  void _serve() {
    _server!.listen(
      (request) =>
          _handleRequest(request).catchError((Object e, StackTrace st) {
            EvalLog.error('[Proxy] Request handler error', e, st);
            try {
              request.response
                ..statusCode = HttpStatus.internalServerError
                ..write(
                  jsonEncode({
                    'error': {'message': e.toString()},
                  }),
                )
                ..close();
            } catch (_) {}
          }),
      onError: (Object e) => EvalLog.error('[Proxy] Server error', e),
    );
  }

  Future<void> _handleRequest(HttpRequest request) async {
    final path = request.uri.path;
    final method = request.method;

    // Only handle POST to generateContent paths.
    if (method != 'POST' || !path.contains('generateContent')) {
      request.response
        ..statusCode = HttpStatus.notFound
        ..write(
          jsonEncode({
            'error': {'message': 'Not found: $path'},
          }),
        )
        ..close();
      return;
    }

    // Extract model from path:
    // "/v1beta/models/gemini-2.5-flash:generateContent" → "gemini-2.5-flash"
    final model = _modelFromPath(path);
    EvalLog.debug('[Proxy] → $method $path (model: $model)');

    final bodyStr = await utf8.decodeStream(request);
    final body = jsonDecode(bodyStr) as Map<String, dynamic>;

    // Capture user-turn messages before the generate call.
    _transcript.addAll(_userMessages(body));

    final responseBody = await provider.generateContent(
      model: model,
      requestBody: body,
    );

    // Capture model response.
    final modelMsg = _modelMessage(responseBody);
    if (modelMsg != null) _transcript.add(modelMsg);

    EvalLog.debug(
      '[Proxy] ← ${responseBody['candidates']?.length ?? 0} candidate(s)',
    );

    request.response
      ..statusCode = HttpStatus.ok
      ..headers.contentType = ContentType.json
      ..write(jsonEncode(responseBody))
      ..close();
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  String _modelFromPath(String path) {
    final idx = path.indexOf('/models/');
    if (idx == -1) return 'gemini-2.5-flash';
    final after = path.substring(idx + 8);
    final colon = after.indexOf(':');
    return colon == -1 ? after : after.substring(0, colon);
  }

  List<ai.Message> _userMessages(Map<String, dynamic> body) {
    final contents = body['contents'] as List? ?? [];
    return contents
        .where((c) => (c['role'] as String?) != 'model')
        .map<ai.Message>((c) {
          final parts = (c['parts'] as List? ?? [])
              .where((p) => p['text'] != null)
              .map<ai.Part>((p) => ai.TextPart(p['text'] as String))
              .toList();
          final role = (c['role'] as String?) == 'tool'
              ? ai.Role.tool
              : ai.Role.user;
          return ai.Message(role: role, content: parts);
        })
        .toList();
  }

  ai.Message? _modelMessage(Map<String, dynamic> responseBody) {
    final candidates = responseBody['candidates'] as List?;
    if (candidates == null || candidates.isEmpty) return null;
    final content = candidates.first['content'] as Map<String, dynamic>?;
    if (content == null) return null;
    final parts = (content['parts'] as List? ?? [])
        .where((p) => p['text'] != null)
        .map<ai.Part>((p) => ai.TextPart(p['text'] as String))
        .toList();
    if (parts.isEmpty) return null;
    return ai.Message(role: ai.Role.model, content: parts);
  }
}
