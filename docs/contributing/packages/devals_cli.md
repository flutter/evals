# devals_cli (devals)

Dart CLI for managing evals — initialize datasets, create samples, run evaluations, and view results. Located in `packages/devals_cli/`.

For setup instructions, see the [Quick Start](../../guides/quick_start.md) or [Contributing Guide](../guide.md).

---

## Commands

| Command | Description |
|---------|-------------|
| `devals init` | Initialize a new dataset in the current directory (creates `devals.yaml`, a starter task, and a starter job) |
| `devals doctor` | Check that prerequisites are installed (Dart, Python, dash_evals, Podman, Flutter, Serverpod, API keys) |
| `devals create sample` | Interactively add a new sample to an existing task |
| `devals create task` | Interactively create a new task file in `tasks/<name>/task.yaml` |
| `devals create job` | Interactively create a new job file |
| `devals create pipeline` | Guided flow to create a task and job together |
| `devals run <job_name>` | Resolve config and run evaluations via the Python dash_evals |
| `devals publish <path>` | Upload Inspect AI log files to Google Cloud Storage |
| `devals view [log_path]` | Launch the Inspect AI viewer to browse evaluation results |

---

## Usage

```bash
# Scaffold a new dataset
devals init

# Check your environment
devals doctor

# Create a new eval (task + job in one step)
devals create pipeline

# Run evaluations
devals run local_dev

# Preview without executing
devals run local_dev --dry-run

# Upload logs to GCS
devals publish logs/2026-01-07_17-11-47/

# View results
devals view
```

---

## How `devals run` Works

1. The CLI resolves the job YAML into `EvalSet` objects using the [dataset_config_dart](./dataset_config_dart.md) package (entirely in Dart)
2. `EvalSetWriter` writes the resolved config to a JSON file
3. The CLI invokes `run-evals --manifest <path>` to hand off to the Python [dash_evals](./dash_evals.md)

With `--dry-run`, the CLI resolves and validates the config without calling the Python runner.

---

## Source Layout

```
bin/
└── devals.dart              # Entry point
lib/
├── devals.dart              # Library barrel file
└── src/
    ├── runner.dart          # DevalRunner (CommandRunner)
    ├── cli_exception.dart   # CLI-specific exceptions
    ├── commands/            # Command implementations
    │   ├── init_command.dart
    │   ├── doctor_command.dart
    │   ├── create_command.dart
    │   ├── create_sample_command.dart
    │   ├── create_task_command.dart
    │   ├── create_job_command.dart
    │   ├── create_pipeline_command.dart
    │   ├── run_command.dart
    │   ├── publish_command.dart
    │   └── view_command.dart
    ├── config/              # Environment and .env helpers
    ├── dataset/             # Dataset reading, writing, templates
    └── gcs/                 # Google Cloud Storage client
```

---

## Testing

```bash
cd packages/devals_cli
dart test
```
