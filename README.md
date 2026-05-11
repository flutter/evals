# dart-evals

A Dart framework for evaluating LLM agents across models, scenarios, and sandboxed environments. Built on [Genkit](https://pub.dev/packages/genkit).

## Example

A complete entry point running 3 evals × 2 models × 2 scenarios with Podman sandboxing and response caching:

```dart
void main() async {
  final genkit = Genkit(
    plugins: [googleAI(apiKey: Platform.environment['GEMINI_API_KEY'])],
  );

  final agent = MiniSweAgent(genkit: genkit, model: '', tools: []);

  final evalSet = EvalSet(
    agent: agent,
    models: [
      Model('googleai', 'gemini-2.5-flash'),
      Model('googleai', 'gemini-2.5-pro'),
    ],
    scenarios: [
      Scenario(name: 'baseline', tags: ['flutter', 'dart']),
      Scenario(name: 'dart_fix_focus', tags: ['dart']),
    ],
    cacheDir: '.devals-cache',
    sandbox: PodmanSandboxManager(
      dockerfilePath: 'docker/Dockerfile',
      buildContext: '.',
      memLimit: '4g',
      cpuLimit: '2.0',
      defaultSetupScript: '''
        cp -r /fixtures/app /workspace/app
        cd /workspace/app && flutter pub get
      ''',
    ),
    evals: [
      // Eval class API inspired by Commands from pkg:args
      FlutterBugFixEval(), 
      FixRemoteBugEval(), 
      McpPubDevSearchEval(input: '...', target: '...')
    ],
  );

  await runEvals(evalSet);
}
```

### Framework features

- **Matrix runner** — Run sets of evals across any combination of models, scenarios, and eval samples.
- **Eval lifecycle management** — Override only what you need — the framework handles the rest.
- **Scenarios** — Test the same evals under different configurations — different tool sets, skill files, or tags for filtering.
- **Built-in evaluators** that handle scoring, or implement your own.
- **Built-in agents** — A basic single-turn agent, as well as a mini-swe inspired multi-turn agentic loop.
- **Output and logging** — Structured JSON results, per-eval JSONL trajectories, and real-time color-coded terminal output.

#### Matrix runner

Run every combination of **models × scenarios × evals** in a single call. `EvalSet` stamps the correct model into an immutable agent template per cell, creates fresh sandbox sessions, and collects results into a flat list.

```dart
final results = await runEvals(EvalSet(
  agent: agent,
  models: [
    Model('googleai', 'gemini-2.5-flash'),
    Model('googleai', 'gemini-2.5-pro'),
  ],
  scenarios: [
    Scenario(name: 'baseline'),
    Scenario(name: 'with_tools', tools: [dartAnalyzer()]),
  ],
  evals: [FlutterBugFixEval(), FixRemoteBugEval()],
));
// → 2 models × 2 scenarios × 2 evals = 8 results
```

#### Eval lifecycle

Each `Eval` follows a managed lifecycle: **setUp → run → score → cleanUp**. Override only what you need — the framework handles the rest.

```dart
class FlutterBugFixEval extends Eval {
  @override String get name => 'flutter_bug_fix';

  @override
  String get input =>
      'Users report the shopping cart total displays \$0.00 '
      'even after adding items. Find and fix the bug.';

  @override
  String get target =>
      'Fix is to create new state objects instead of '
      'mutating the list in-place.';

  @override
  List<Evaluator> get evaluators => [
    ExecEvaluator.flutterTest(),
    ExecEvaluator.dartAnalyze(),
  ];

  @override
  Future<EvalState> setUp(EvalState state) async {
    final sandbox = state.context.sandbox!;
    await sandbox.exec(['bash', '-c', 'cp -r /fixtures/app /workspace/app']);
    await sandbox.exec(['flutter', 'pub', 'get'], cwd: '/workspace/app');
    return state;
  }

  @override
  Future<EvalState> run(EvalState state) async {
    final result = await state.agent.run(
      task: input,
      systemMessage: systemMessage,
      additionalTools: SandboxTools.all(state.context.sandbox!),
    );
    state.output = result;
    return state;
  }
}
```

#### Scenarios

Test the same evals under different configurations — different tool sets, skill files, or tags for filtering:

```dart
const scenarios = [
  Scenario(name: 'baseline', tags: ['flutter', 'dart']),
  Scenario(name: 'with_dart_fix', tools: [dartFixTool()]),
  Scenario(name: 'with_skills', skillPaths: ['/path/to/skill.md']),
];
```

#### Built-in evaluators

| Evaluator | What it does |
|---|---|
| `ExecEvaluator` | Runs a command in the sandbox (e.g. `flutter test`, `dart analyze`) and scores by exit code |
| `IncludesEvaluator` | Checks whether the model output contains a target string (case-insensitive) |
| `McpToolUsageEvaluator` | Verifies the model called specific MCP tools during the conversation |

```dart
// Factory constructors for common commands
ExecEvaluator.flutterTest()
ExecEvaluator.dartAnalyze()
ExecEvaluator.dartTest()

// Custom command
ExecEvaluator(['pytest', '-x'], workingDir: '/workspace')

// String matching
IncludesEvaluator('fl_chart')

// Tool usage verification
McpToolUsageEvaluator(requiredTools: ['pub_dev_search'])
```

#### Agents

Two built-in agent implementations, both immutable and `copyWith`-able:

- **`BasicAgent`** — single-turn: one `generate()` call, returns immediately.
- **`MiniSweAgent`** — multi-turn agentic loop with tool calling, step budgets, output truncation, and automatic conversation management.

```dart
// Single-turn
final basic = BasicAgent(
  genkit: genkit,
  model: 'googleai/gemini-2.5-flash',
  tools: [],
);

// Multi-turn agentic loop
final swe = MiniSweAgent(
  genkit: genkit,
  model: 'googleai/gemini-2.5-flash',
  tools: [],
  config: AgentConfig(maxSteps: 30, commandTimeout: Duration(seconds: 120)),
);
```

### Response caching

Cache model responses to disk during development. Saves tokens and time when iterating on evaluators, scorers, or framework plumbing — without re-calling AI APIs.

```dart
final evalSet = EvalSet(
  agent: agent,
  models: [Model('googleai', 'gemini-2.5-flash')],
  evals: [MyEval()],
  cacheDir: '.devals-cache', // ← opt-in
);
```

Cache events are logged inline with agent output:

```
    ⚡ cached  tokens=0  key=a1b2c3d4e5f6     ← hit
    ⏳ cache miss  key=f6e5d4c3b2a1            ← miss (API called)
```

Invalidate by deleting the directory: `rm -rf .devals-cache/`

### Structured output

Every run produces:

- **`eval.json`** — full results with scores, model outputs, metadata, and timing
- **`*_trajectory.jsonl`** — per-eval JSONL conversation trajectories (system → user → model → tool → …)
- **`run.log`** — plaintext log (ANSI stripped) for archival

### Real-time logging

Structured, color-coded terminal output with progress bars, agent step traces, tool call/response logging, and cache event indicators. Configurable via `LogLevel`:

```dart
await runEvals(evalSet, logLevel: LogLevel.normal);
// LogLevel.quiet   — errors only
// LogLevel.normal  — progress + scores + cache events
// LogLevel.verbose — + agent messages and tool I/O
// LogLevel.debug   — everything
```

### Error isolation

Each matrix cell runs in a `runZonedGuarded` zone, so unhandled async errors (e.g. MCP transport failures) are captured and logged without crashing the runner. Failed cells produce error results; the remaining matrix continues.

---

## Sandbox package

The `devals_sandbox` package (`packages/sandbox`) provides container-based isolation for agent execution, independent of the eval framework. Use it standalone or let `EvalSet` manage the lifecycle automatically.

### Architecture

| Abstraction | Role |
|---|---|
| `SandboxManager` | Creates and configures sandbox sessions (Docker, Podman, or local) |
| `SandboxSession` | A running sandbox instance — owns a `SandboxEnvironment` and handles disposal |
| `SandboxEnvironment` | Exec commands, read/write files, list directories inside the sandbox |
| `ExecResult` | Captures exit code, stdout, and stderr from a command |

### Sandbox tools

Pre-built Genkit tools that give the model direct access to a `SandboxEnvironment`:

```dart
// Give the agent bash, read_file, and write_file tools
final result = await state.agent.run(
  task: input,
  additionalTools: SandboxTools.all(state.context.sandbox!),
);

// Or pick individual tools
SandboxTools.bash(sandbox)
SandboxTools.readFile(sandbox)
SandboxTools.writeFile(sandbox)
```

### Container runtimes

Isolate each eval cell in its own container with configurable resource limits, setup scripts, and automatic lifecycle management. Both Docker and Podman are supported:

```dart
// Podman
final sandbox = PodmanSandboxManager(
  dockerfilePath: 'docker/Dockerfile',
  buildContext: '.',
  memLimit: '4g',
  cpuLimit: '2.0',
  defaultSetupScript: '''
    cp -r /fixtures/app /workspace/app
    cd /workspace/app && flutter pub get
  ''',
);

// Docker Compose
final sandbox = DockerSandboxManager();
```

### SandboxEnvironment API

Every sandbox environment (container or local) exposes a uniform API:

```dart
// Run a command
final result = await sandbox.exec(
  ['dart', 'analyze', '--fatal-warnings'],
  cwd: '/workspace/app',
  timeout: Duration(minutes: 2),
);
print(result.exitCode); // 0
print(result.stdout);   // "No issues found!"

// File operations
await sandbox.writeFile('/workspace/app/lib/main.dart', contents);
final source = await sandbox.readFile('/workspace/app/lib/main.dart');
final exists = await sandbox.fileExists('/workspace/app/pubspec.yaml');
final entries = await sandbox.listDirectory('/workspace/app/lib');
await sandbox.deleteFile('/workspace/app/tmp', recursive: true);
```

### Local sandbox

For fast iteration without containers, `LocalSandboxManager` runs commands directly on the host in a temp directory:

```dart
final sandbox = LocalSandboxManager();
final session = await sandbox.createSession('my-eval');
// session.environment exposes the same SandboxEnvironment API
```

---

## Packages

| Package | Description |
|---|---|
| `packages/evals` | Core framework — `Eval`, `EvalSet`, agents, evaluators, logging, caching |
| `packages/sandbox` | Container sandboxing — `SandboxManager`, Docker/Podman/local backends |
| `packages/shared` | Shared models — `EvalResult`, `Score`, `Model`, `EvalSetResult` |


Ideas:
Multi-provider matrices. Today's Model has a provider field. If all models in a set must share the same provider, that's a constraint we should document. Alternatively, we could build one connector per provider and dispatch per-cell — more complex but more flexible. Which do you prefer for v1?