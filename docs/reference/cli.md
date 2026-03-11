# CLI usage

The `devals` CLI is a Dart command-line tool for managing the evals dataset. It provides interactive commands for creating samples, tasks, and jobs, as well as running evaluations and viewing results.

```bash
cd packages/devals_cli
dart pub get
dart run bin/devals.dart --help
```

> [!TIP]
> Run `devals create pipeline` for an interactive walkthrough that creates your first sample, task, and job.

Key commands:

| Command | Description |
|---------|-------------|
| `devals init` | Initialize a new dataset configuration in the current directory |
| `devals doctor` | Check that all prerequisites are installed and configured |
| `devals create pipeline` | Interactive guide to create a sample, task, and job in one go |
| `devals create sample` | Create a new sample interactively |
| `devals create task` | Create a new task directory with a starter `task.yaml` |
| `devals create job` | Create a new job file |
| `devals run <job_name>` | Run evaluations (wraps `run-evals`) |
| `devals run <job_name> --dry-run` | Preview what would be run without executing |
| `devals view [log_dir_path]` | Launch the Inspect AI log viewer |

---

## Usage

```
CLI for managing evals - create samples, run evaluations, and view results.

Usage: devals <command> [arguments]

Global options:
-h, --help    Print this usage information.

Available commands:
  create        Create samples, jobs, and tasks for the dataset.
    job           Create a new job file interactively.
    pipeline      Interactive guide to create a sample, task, and job in one go.
    sample        Create a new sample and set it up to run.
    task          Create a new task directory with a starter task.yaml.
  doctor        Check that all prerequisites are installed and configured.
  init          Initialize a new dataset configuration in the current directory.
  run           Run evaluations using the dash_evals.
  view          Launch the Inspect AI viewer to view evaluation results.

Run "devals help <command>" for more information about a command.
```

## Commands

### `devals init`

Initializes a new dataset configuration in the current directory. Creates:

- `evals/tasks/get_started/task.yaml` — a starter task with an example sample
- `evals/jobs/local_dev.yaml` — a default job for local development

Use this when starting a new project that needs its own evaluation dataset.

### `devals doctor`

Checks that all prerequisites for the CLI, `dash_evals`, and `eval_explorer` are installed and correctly configured. Similar to `flutter doctor`, it verifies:

- **Dart SDK** — required for the CLI itself
- **Python 3.13+** — required for `dash_evals`
- **dash_evals** (`run-evals`) — the Python evaluation package
- **Podman** — container runtime for sandboxed execution
- **Flutter SDK** — needed for Flutter-based eval tasks
- **Serverpod** — needed for the `eval_explorer` app
- **API Keys** — checks for `GOOGLE_API_KEY`, `ANTHROPIC_API_KEY`, `OPENAI_API_KEY`

### `devals create pipeline`

An interactive walkthrough that guides you through creating your first sample, task, and job — ideal for first-time contributors.

### `devals create sample`

Interactively creates a new sample directory with a `sample.yaml` file. Prompts for:

- Sample ID (snake_case identifier)
- Difficulty level
- Whether a workspace is needed
- Workspace type (template, path, git, or create command)

### `devals create task`

Creates a new task directory under `tasks/` with a starter `task.yaml`. Prompts for:

- Task ID
- Task function (selected from the Python registry)
- Optional system message

### `devals create job`

Creates a new job YAML file in `jobs/`. Prompts for:

- Job name
- Which models, variants, and tasks to include

### `devals run <job_name>`

Runs evaluations using the `dash_evals`. Wraps the Python `run-evals` entry point.

```bash
devals run local_dev        # Run a specific job
devals run local_dev --dry-run  # Preview without executing
```

### `devals view [log_path]`

Launches the Inspect AI log viewer to browse evaluation results. If no path is given, defaults to the `logs/` directory in the dataset.

```bash
devals view                 # Auto-detect log directory
devals view /path/to/logs   # View specific log directory
```
