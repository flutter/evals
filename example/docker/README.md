# Flutter Eval Docker Image

Base image for running Flutter evals in an isolated Docker sandbox.

## What's included

| Tool | Source |
|---|---|
| `flutter` / `dart` | `ghcr.io/cirruslabs/flutter:stable` |
| `build_runner`, `freezed`, `json_serializable` | globally activated via pub |
| Common pub packages | pre-cached in `/root/.pub-cache` |
| Fixture apps | baked into `/fixtures/` from the repo's `fixtures/` dir |

## Build

The build context must be the **repo root** (not `docker/`) because the
Dockerfile copies `fixtures/` into the image.

```bash
# From the repo root:
docker compose -f docker/docker-compose.yml build

# Or equivalently:
docker build -f docker/Dockerfile -t dart-evals-flutter .
```

## Smoke-test

```bash
docker run --rm dart-evals-flutter flutter --version
docker run --rm dart-evals-flutter dart --version
```

## Architecture

```
Host machine
├── Genkit agent process
│   └── genkit_mcp host → Dart MCP server (subprocess on host)
│                         (runs dart analyze / flutter test on HOST checkout)
└── DockerSandboxManager
    └── Docker container (this image)
        └── /workspace/app  ← agent's file edits + test runs via exec()
```

The **Dart MCP server runs on the host**, not inside the container.
The container is the agent's isolated workspace: the agent writes files into
`/workspace/app` via `SandboxEnvironment.writeFile()` and runs
`flutter test` / `dart analyze` / `dart pub get` via `SandboxEnvironment.exec()`.

## Using with DockerSandboxManager

```dart
import 'package:devals_sandbox/sandbox.dart';

final manager = DockerSandboxManager();

// Point to this directory's docker-compose.yml:
await manager.taskInit(
  'flutter_feature',
  configFile: '/path/to/dart-evals/docker/docker-compose.yml',
);

final envs = await manager.sampleInit(
  'flutter_feature',
  configFile: '/path/to/dart-evals/docker/docker-compose.yml',
  sampleId: 'sample-1',
  // Provision the Flutter app source into the container:
  files: {'/workspace/app': '/local/path/to/flutter_app'},
);

final env = envs.values.first;

// Run commands inside the container:
final result = await env.exec(['flutter', 'test'],  cwd: '/workspace/app');
print(result.stdout);

await manager.sampleCleanup(envs);
await manager.taskCleanup();
```
