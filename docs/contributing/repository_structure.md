# Repository Structure

Overview of the evals repository layout.

```
evals/
├── dataset/                    # Evaluation data and configuration
├── docs/                       # Documentation
├── packages/
│   ├── devals_cli/             # Dart CLI for managing dataset (devals)
│   ├── dataset_config_dart/    # Dart library: YAML → EvalSet JSON
│   ├── dash_evals/             # Python evaluation runner
│   ├── dataset_config_python/  # Python configuration models
│   └── eval_explorer/          # Dart/Flutter results viewer (Serverpod)
├── tool/                       # Utility scripts
├── pubspec.yaml                # Dart workspace configuration
└── firebase.json               # Firebase configuration
```

---

## dataset/

Contains all evaluation data, configurations, and resources. See the [Configuration Overview](../reference/configuration_reference.md) for detailed file formats.

| Path | Description |
|------|-------------|
| `tasks/` | Task subdirectories with `task.yaml` files and inline samples |
| `jobs/` | Job files for different run configurations |
| `context_files/` | Context markdown files for prompt injection |
| `sandboxes/` | Container configuration (Containerfile, compose.yaml) |
| `workspaces/` | Reusable project templates (flutter_app, dart_package) |

---

## packages/

### dataset_config_dart/

Dart package that converts dataset YAML into EvalSet JSON for the Python runner. Provides a layered API:

```
dataset_config_dart/
├── lib/
│   ├── dataset_config_dart.dart  # Library barrel file
│   └── src/
│       ├── config_resolver.dart  # Facade: single-call convenience API
│       ├── parsed_task.dart      # Intermediate parsing type
│       ├── parsers/              # YamlParser, JsonParser
│       ├── resolvers/            # EvalSetResolver
│       ├── writers/              # EvalSetWriter
│       └── utils/                # YAML helpers
├── bin/                          # CLI entry points
└── test/                         # Dart test suite
```

---

### dash_evals/

Python package for running LLM evaluations using [Inspect AI](https://inspect.aisi.org.uk/).

```
dash_evals/
├── src/dash_evals/
│   ├── main.py              # CLI entry point (--json or --task mode)
│   ├── runner/
│   │   ├── json_runner.py   # Run from EvalSet JSON manifest
│   │   ├── args_runner.py   # Run from direct CLI arguments
│   │   ├── tasks/           # Task implementations (@task functions)
│   │   ├── scorers/         # Scoring logic
│   │   ├── solvers/         # Solver chains
│   │   └── sandboxes/       # Sandbox environments
│   ├── models/              # Data models
│   └── utils/               # Logging and helpers
├── tests/                   # Pytest test suite
└── pyproject.toml           # Package configuration
```

---

### devals_cli/ (devals)

Dart CLI for creating and managing evaluation tasks and jobs. See the [CLI documentation](../reference/cli.md) for full command reference.

```
devals_cli/
├── bin/devals.dart           # CLI entry point
├── lib/src/
│   ├── commands/            # Command implementations
│   ├── console/             # Console UI and prompts
│   ├── dataset/             # Dataset file utilities and discovery
│   └── yaml/                # YAML generation and parsing
└── test/                    # Dart test suite
```


### eval_explorer/

Dart/Flutter application for exploring evaluation results. Built with [Serverpod](https://serverpod.dev/).

```
eval_explorer/
├── eval_explorer_client/    # Dart client package
├── eval_explorer_flutter/   # Flutter web/mobile app
├── eval_explorer_server/    # Serverpod backend
└── eval_explorer_shared/    # Shared models
```
