import 'package:framework/framework.dart';
import 'package:example/src/evaluators/trajectory_evaluator.dart';

/// Agentic eval: clone a remote repository and apply a code update.
///
/// Ported from `dash_evals/dataset/tasks/fix_remote_bug` sample
/// `dart_samples_isolate_update`. The agent must clone the dart-lang/samples
/// repository and update `long_running_isolate.dart` with a new stream-based
/// isolate example.
class FixRemoteBugEval extends Eval {
  @override
  String get name => 'fix_remote_bug';

  @override
  String get input => '''
A user filed this issue in the dart-lang/samples repository. Please update the samples/isolates/ project as directed in the issue.

Issue text: """
I have this example from @lrhn that could be used to update `long_running_isolate.dart`.

In Lasse's words: This is a fairly primitive version of remote-running a stream function, it doesn't forward pause/resume/cancel calls on the subscription, and it stops on the first error. It does show how to send multiple events back from the other isolate.

```dart
import "dart:isolate";

Stream<T> runStream<T>(Stream<T> Function() remoteStream) =>
    Stream.multi((controller) async {
      // New port for event messages.
      var port = RawReceivePort();
      port.handler = (message) {
        var list = message as List;
        if (list.length == 1) {
          controller.add(list[0] as T);
        } else {
          controller.addError(list[1] as Object, list[2] as StackTrace);
        }
      };
      // Run in other isolate, receive stream events on `port`.
      try {
        await Isolate.run(_remoteStream(remoteStream, port.sendPort));
        // Returns when stream done.
      } catch (e, s) {
        controller.addError(e, s);
      } finally {
        port.close();
        controller.close();
      }
    });

// Creates an argument to `Isolate.run` from a `Stream Function()` and a port.
Future<void> Function() _remoteStream(
    Stream Function() createStream, SendPort port) {
  Future<void> runStreamSendEvents() async {
    try {
      await for (var event in createStream()) {
        // Send events on port.
        port.send([event]);
      }
    } catch (e, s) {
      // Send events on port.
      port.send([e, s]);
    }
  }

  return runStreamSendEvents;
}

// Example use:

void main() async {
  await for (var v in runStream(() => someInts(5))) {
    print(v);
  }
}

Stream<int> someInts(int n) async* {
  for (var i = 0; i < n; i++) {
    yield i;
  }
}
```
"""
''';

  @override
  String get target =>
      'The repository should be updated with the new example (locally).';

  @override
  String get systemMessage => '''
You are an expert Dart developer debugging a production issue.

Your task is to:

1. Explore the codebase to understand the structure
2. Identify the root cause of the bug
3. Fix the bug by editing the necessary file(s)
4. Verify your fix passes any tests and static analysis
5. If there are any errors or warnings at all, fix them
6. When done, provide a brief explanation of what you fixed.
''';

  @override
  List<Evaluator> get evaluators => [
    ExecEvaluator.dartAnalyze(),
    const TrajectoryEvaluator(),
  ];

  /// Clones the remote repository into the sandbox.
  @override
  Future<EvalState> setUp(EvalState state) async {
    final sandbox = state.context.sandbox;
    if (sandbox == null) {
      throw StateError(
        '$name requires a sandbox. Configure a SandboxManager in your EvalSet.',
      );
    }

    await sandbox.exec(
      ['git', 'clone', 'https://github.com/dart-lang/samples.git', '/workspace/app'],
      timeout: const Duration(minutes: 3),
    );

    return state;
  }

  @override
  Future<EvalState> run(EvalState state) async {
    // state.tools already has sandbox tools — auto-injected by the framework.
    final result = await state.agent.run(
      task: input,
      systemMessage: systemMessage,
      additionalTools: state.tools,
    );

    state.store['trajectory'] = result.toJson();
    state.store['steps'] = result.steps;
    state.store['agent_status'] = result.status.name;
    state.store['agent_error'] = result.error;
    state.store['total_tokens'] = result.usage?.totalTokens;

    state.output = result;

    return state;
  }
}
