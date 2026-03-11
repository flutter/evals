# Configuration Reference

This document describes the *standard* `eval/` directory structure and YAML configuration files used by the evaluation framework.

## Overview

The evaluation framework uses the `eval/` directory as its entry point. It contains:

- Task definitions autodiscovered from `tasks/*/task.yaml`
- Job files in `jobs/` that control what to run
- Shared resources (context files, sandboxes, workspaces)

Configuration is parsed and resolved by the Dart `dataset_config_dart` package, which produces an EvalSet JSON manifest consumed by the Python `dash_evals`.

## Directory Structure

```
eval/
├── jobs/                    # Job files for different run configurations
│   ├── local_dev.yaml
│   └── ci.yaml
├── tasks/                   # Task definitions (autodiscovered)
│   ├── flutter_bug_fix/
│   │   ├── task.yaml        # Task config with inline samples
│   │   └── project/         # Workspace files (if applicable)
│   ├── dart_question_answer/
│   │   └── task.yaml
│   └── generate_flutter_app/
│       ├── task.yaml
│       └── todo_tests/      # Test files for a sample
├── context_files/           # Context files injected into prompts
│   └── flutter.md
├── sandboxes/               # Container configurations
│   └── podman/
│       ├── Containerfile
│       └── compose.yaml
└── workspaces/              # Reusable project templates
    ├── dart_package/
    ├── flutter_app/
    └── jaspr_app/
```

---

## Task files

Each subdirectory in `tasks/` that contains a `task.yaml` is automatically discovered as a task. The **directory name** is the task ID.

```yaml
# tasks/flutter_bug_fix/task.yaml
func: flutter_bug_fix
system_message: |
  You are an expert Flutter developer. Fix the bug and explain your changes.

# Task-level workspace (inherited by all samples)
workspace:
  path: ./project

# Task-level tests (inherited by all samples)
tests:
  path: ./tests

# Restrict which job-level variants apply to this task (optional)
allowed_variants: [baseline, mcp_only]

samples:
  inline:
    - id: flutter_bloc_cart_mutation_001
      difficulty: medium
      tags: [bloc, state]
      input: |
        Fix the bug where adding items to cart doesn't update the total.
      target: |
        The fix should modify the BLoC to emit a new state instead of mutating.

    - id: navigation_crash
      difficulty: hard
      tags: [navigation]
      workspace:
        path: ./nav_project    # Override task-level workspace
      input: |
        Fix the crash when navigating back from the detail screen.
      target: |
        The fix should handle the disposed controller properly.
```

### Task-Level Fields

#### Core Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `func` | string | Yes | Name of the `@task` function (resolved dynamically via `importlib`) |
| `description` | string | No | Human-readable description |
| `samples` | object | Yes | Samples config with `inline` and/or `paths` keys |
| `allowed_variants` | list | No | Whitelist of variant names this task accepts (omit to accept all) |
| `system_message` | string | No | Custom system prompt for this task |
| `workspace` | object | No | Default workspace for all samples |
| `tests` | object | No | Default test files for all samples |

#### Inspect AI Task Parameters

These map directly to [Inspect AI's `Task` constructor](https://inspect.aisi.org.uk/reference/inspect_ai.html#task). All are optional and override any `task_defaults` set in the job file.

| Field | Type | Description |
|-------|------|-------------|
| `model` | string | Default model for this task (overrides the eval model) |
| `config` | object | Model generation config (e.g., `{temperature: 0.2, max_tokens: 4096}`) |
| `model_roles` | object | Named roles for use in `get_model()` |
| `sandbox` | string/object | Sandbox environment type or `[type, config_path]` |
| `approval` | string/object | Tool use approval policies |
| `epochs` | int/object | Number of times to repeat each sample (optionally with score reducer) |
| `fail_on_error` | number/bool | `true` = fail on first error, `0.0–1.0` = fail if proportion exceeds threshold |
| `continue_on_fail` | bool | Continue running if `fail_on_error` condition is met |
| `message_limit` | int | Max total messages per sample |
| `token_limit` | int | Max total tokens per sample |
| `time_limit` | int | Max clock time (seconds) per sample |
| `working_limit` | int | Max working time (seconds) per sample (excludes wait time) |
| `cost_limit` | float | Max cost (dollars) per sample |
| `early_stopping` | string/object | Early stopping callbacks |
| `display_name` | string | Task display name (e.g., for plotting) |
| `version` | int | Version of task spec (to distinguish evolutions) |
| `metadata` | object | Additional metadata to associate with the task |

### Samples Object

| Field | Type | Description |
|-------|------|-------------|
| `inline` | list | Inline sample definitions |
| `paths` | list | Glob patterns for external sample YAML files (relative to task dir) |

### Sample Fields (inline in task.yaml)

#### Core Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | Yes | Unique sample identifier |
| `input` | string | Yes | The prompt given to the model |
| `target` | string | Yes | Expected output or grading criteria |
| `difficulty` | string | No | `easy`, `medium`, or `hard` |
| `tags` | list | No | Categories for filtering |
| `system_message` | string | No | Override system prompt for this sample |
| `metadata` | object | No | Arbitrary metadata |
| `workspace` | object | No | Override task-level workspace |
| `tests` | object | No | Override task-level tests |

#### Inspect AI Sample Parameters

These map directly to [Inspect AI's `Sample`](https://inspect.aisi.org.uk/reference/inspect_ai.dataset.html#sample).

| Field | Type | Description |
|-------|------|-------------|
| `choices` | list | Answer choices for multiple-choice evaluations |
| `sandbox` | string/object | Override sandbox environment for this sample |
| `files` | object | Files to copy into the sandbox (`{destination: source}`) |
| `setup` | string | Setup script to run in the sandbox before evaluation |

### Workspace/Tests References

```yaml
# Reference a reusable template
workspace:
  template: flutter_app

# Reference a path relative to task directory
workspace:
  path: ./project

# Clone from git
workspace:
  git: https://github.com/example/repo.git

# Shorthand (equivalent to path:)
workspace: ./project
```

> [!NOTE]
> Paths in `workspace` and `tests` are resolved **relative to the task directory** (e.g., `tasks/flutter_bug_fix/`).

---

## Sample files

A sample is a single test case containing an input prompt, expected output (grading target), and optional configuration. Samples are defined inline in `task.yaml` or in external YAML files referenced via `paths`.

```yaml
# Inline in task.yaml
samples:
  inline:
    - id: dart_async_await_001
      difficulty: medium
      tags: [async, dart]
      input: |
        Explain the difference between Future.then() and async/await in Dart.
      target: |
        The answer should cover both approaches, explain that they are
        functionally equivalent, and note when each is preferred.
      metadata:
        added: 2025-02-04
        category: language_fundamentals
```

---

### Core Fields

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | string | Yes | Unique sample identifier |
| `input` | string | Yes | The prompt given to the model |
| `target` | string | Yes | Expected output or grading criteria |
| `difficulty` | string | No | `easy`, `medium`, or `hard` |
| `tags` | list | No | Categories for filtering |
| `system_message` | string | No | Override system prompt for this sample |
| `metadata` | object | No | Arbitrary metadata |
| `workspace` | object | No | Override task-level workspace |
| `tests` | object | No | Override task-level tests |

---

### Inspect AI Sample Parameters

These map directly to [Inspect AI's `Sample`](https://inspect.aisi.org.uk/reference/inspect_ai.dataset.html#sample).

| Field | Type | Description |
|-------|------|-------------|
| `choices` | list | Answer choices for multiple-choice evaluations |
| `sandbox` | string/object | Override sandbox environment for this sample |
| `files` | object | Files to copy into the sandbox (`{destination: source}`) |
| `setup` | string | Setup script to run in the sandbox before evaluation |

### Multiple Choice Example

```yaml
- id: dart_null_safety_quiz
  input: "Which of the following is NOT a valid way to handle null in Dart 3?"
  target: C
  choices:
    - "Use the null-aware operator ?."
    - "Use a null check with if (x != null)"
    - "Use the ! operator on every nullable variable"
    - "Use late initialization"
```

### Sandbox Files Example

```yaml
- id: flutter_fix_counter
  input: "Fix the bug in the counter app."
  target: "The fix should update the state correctly."
  sandbox: docker
  files:
    /workspace/lib/main.dart: ./fixtures/broken_counter.dart
    /workspace/test/widget_test.dart: ./fixtures/counter_test.dart
  setup: "cd /workspace && flutter pub get"
```

---

### Workspace & Tests References

Workspaces and test paths can be specified at task level (inherited by all samples) or per-sample (overrides task level).

```yaml
# Reference a reusable template
workspace:
  template: flutter_app

# Reference a path relative to task directory
workspace:
  path: ./project

# Clone from git
workspace:
  git: https://github.com/example/repo.git

# Shorthand (equivalent to path:)
workspace: ./project
```

> [!NOTE]
> Paths in `workspace` and `tests` are resolved **relative to the task directory** (e.g., `tasks/flutter_bug_fix/`).


---

## Job files

Job files define **what to run** and can **override built-in runtime defaults**. They're selected via `devals run <job_name>`. Multiple jobs can be run sequentially.

```yaml
# jobs/local_dev.yaml
name: local_dev

# Override runtime defaults
sandbox_type: podman
max_connections: 15
max_retries: 10

# Save the agent's final workspace output to logs/<run>/examples/
# save_examples: true

# Filter what to run (optional - omit to run all)
models:
  - google/gemini-2.5-flash

# Variants are defined as a named map.
# Each key is a variant name; the value is the variant configuration.
variants:
  baseline: {}
  context_only: { context_files: [./context_files/flutter.md] }
  mcp_only: { mcp_servers: [dart] }
  full: { context_files: [./context_files/flutter.md], mcp_servers: [dart] }

# Inspect AI eval_set() parameters (all optional)
retry_attempts: 20
fail_on_error: 0.05
log_level: info
tags: [nightly]

# Default Task-level overrides applied to every task
task_defaults:
  time_limit: 600
  message_limit: 50

# Additional eval_set() parameters not covered above
# eval_set_overrides:
#   bundle_dir: ./bundle
#   log_images: true
```


### Core Job Fields

| Field | Type | Description |
|-------|------|-------------|
| `logs_dir` | string | Override logs directory (default: `../logs`) |
| `sandbox_type` | string | Sandbox type: `local`, `docker`, or `podman` (default: `local`) |
| `max_connections` | int | Max concurrent API connections (default: `10`) |
| `max_retries` | int | Max retry attempts for failed samples (default: `3`) |
| `save_examples` | bool | If `true`, copies the agent's final workspace to `<logs_dir>/<run>/examples/` after each sample. (default: `false`) |
| `models` | list | Filter to specific models — omit to run all |
| `variants` | map | Named variant definitions (see Variants section) — omit to run all defined in task files |
| `tasks` | object | Task discovery and overrides (see below) |

### Inspect AI eval_set() Parameters

All [Inspect AI `eval_set()` parameters](https://inspect.aisi.org.uk/reference/inspect_ai.html#eval_set) are available as top-level keys in the job file. These control retry behavior, concurrency, logging, and more.

#### Retry & Error Handling

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `retry_attempts` | int | `10` | Max retry attempts before giving up |
| `retry_wait` | float | `60` | Seconds between retries (exponential backoff) |
| `retry_connections` | float | `0.5` | Reduce max_connections at this rate per retry |
| `retry_cleanup` | bool | `true` | Cleanup failed log files after retries |
| `retry_on_error` | int | — | Retry samples on error (per-sample) |
| `fail_on_error` | float | `0.05` | Fail if error proportion exceeds threshold |
| `continue_on_fail` | bool | — | Continue running even if fail_on_error is met |
| `debug_errors` | bool | `false` | Raise task errors for debugging |

#### Concurrency

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `max_samples` | int | `max_connections` | Max concurrent samples per task |
| `max_tasks` | int | `max(4, models)` | Max tasks to run in parallel |
| `max_subprocesses` | int | `cpu_count` | Max subprocesses in parallel |
| `max_sandboxes` | int | — | Max sandboxes per-provider in parallel |

#### Logging

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `log_level` | string | `info` | Console log level (`debug`, `info`, `warning`, `error`) |
| `log_level_transcript` | string | `info` | Log file level |
| `log_format` | string | `json` | Log format (`eval` or `json`) |
| `log_samples` | bool | `true` | Log detailed samples and scores |
| `log_realtime` | bool | `true` | Log events in realtime |
| `log_images` | bool | `false` | Log base64-encoded images |
| `log_buffer` | int | — | Samples to buffer before log write |
| `log_shared` | int | — | Sync sample events for realtime viewing |
| `log_dir_allow_dirty` | bool | `false` | Allow log dir with unrelated logs |

#### Model Configuration

| Field | Type | Description |
|-------|------|-------------|
| `model_base_url` | string | Base URL for the model API |
| `model_args` | object | Model creation arguments |
| `model_roles` | object | Named roles for `get_model()` |
| `task_args` | object | Task creation arguments |
| `model_cost_config` | object | Model prices for cost tracking |

#### Sample Control

| Field | Type | Description |
|-------|------|-------------|
| `limit` | int/list | Limit samples (count or `[start, end]` range) |
| `sample_id` | string/list | Evaluate specific sample(s) |
| `sample_shuffle` | bool/int | Shuffle samples (pass seed for deterministic order) |
| `epochs` | int/object | Repeat samples and optional score reducer |

#### Limits (Applied to All Samples)

| Field | Type | Description |
|-------|------|-------------|
| `message_limit` | int | Max messages per sample |
| `token_limit` | int | Max tokens per sample |
| `time_limit` | int | Max clock time (seconds) per sample |
| `working_limit` | int | Max working time (seconds) per sample |
| `cost_limit` | float | Max cost (dollars) per sample |

#### Miscellaneous

| Field | Type | Description |
|-------|------|-------------|
| `tags` | list | Tags for this evaluation run |
| `metadata` | object | Metadata for this evaluation run |
| `trace` | bool | Trace model interactions to terminal |
| `display` | string | Task display type (default: `full`) |
| `score` | bool | Score output (default: `true`) |
| `approval` | string/object | Tool use approval policies |
| `solver` | string/object | Alternative solver(s) |
| `sandbox_cleanup` | bool | Cleanup sandbox after task (default: `true`) |
| `bundle_dir` | string | Directory for bundled logs + viewer |
| `bundle_overwrite` | bool | Overwrite files in bundle_dir |
| `eval_set_id` | string | Custom ID for the eval set |

### Pass-Through Sections

#### `task_defaults`

Default [Task parameters](#inspect-ai-task-parameters) applied to **every task** in this job. Per-task overrides from `task.yaml` take precedence.

```yaml
task_defaults:
  time_limit: 600
  message_limit: 50
  cost_limit: 2.0
  epochs: 3
```

#### `eval_set_overrides`

Arbitrary `eval_set()` kwargs for parameters not covered by the named fields above. Top-level fields take precedence over overrides.

```yaml
eval_set_overrides:
  bundle_dir: ./bundle
  log_images: true
```

### Tasks Object

```yaml
tasks:
  # Discover tasks via glob patterns (relative to dataset root)
  paths: [tasks/*]
  # Per-task overrides (keys must match directory names in tasks/)
  inline:
    flutter_bug_fix:
      allowed_variants: [baseline]   # Override variants for this task
      include-samples: [sample_001]  # Only run these samples
      exclude-samples: [slow_test]   # Exclude these samples
```

| Field | Type | Description |
|-------|------|-------------|
| `paths` | list | Glob patterns for discovering task directories |
| `inline` | object | Per-task configuration overrides |

---

## Variants

Variants modify how tasks execute, controlling context injection, tool availability, and skill access. Variants are defined as **named maps** in job files.

```yaml
variants:
  baseline: {}
  context_only: { context_files: [./context_files/flutter.md] }
  mcp_only: { mcp_servers: [dart] }
  full: { context_files: [./context_files/flutter.md], mcp_servers: [dart] }
```

| Field | Type | Default | Description |
|-------|------|---------|-------------|
| `context_files` | list | `[]` | Paths or glob patterns to context files (relative to task dir) |
| `skills` | list | `[]` | Paths or glob patterns to skill directories (relative to task dir) |
| `mcp_servers` | list | `[]` | MCP server identifiers |

Tasks can optionally restrict which variants apply to them via `allowed_variants` in their `task.yaml`:

```yaml
# task.yaml — only run baseline and mcp_only variants for this task
allowed_variants: [baseline, mcp_only]
```

Glob patterns (containing `*`, `?`, or `[`) are expanded automatically. For skills, only directories containing `SKILL.md` are included.

> [!IMPORTANT]
> The `skills` feature requires a sandbox (docker/podman). Skill directories are copied into the sandbox filesystem by Inspect AI's built-in `skill()` tool. Each skill directory must contain a `SKILL.md` file.

---

## Context Files

Markdown files with YAML frontmatter providing additional context to the model.

```markdown
---
title: "AI Rules for Flutter"
version: "1.0.0"
description: "Recommended patterns and best practices"
dart_version: "3.10.0"
flutter_version: "3.24.0"
updated: "2025-12-24"
---

## Flutter Best Practices

Content here is injected into the model's context when the variant
has context_files pointing to this file.
```

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `title` | string | Yes | Context file title |
| `version` | string | Yes | Version identifier |
| `description` | string | Yes | Brief description |
| `dart_version` | string | No | Target Dart version |
| `flutter_version` | string | No | Target Flutter version |
| `updated` | string | No | Last update date |

---

## CLI Usage

```bash
# Run a specific job
devals run local_dev
devals run ci

# Dry run — validate config without executing
devals run local_dev --dry-run

# Create a new task
devals create task

# Add a sample to an existing task
devals create sample

# Initialize a new dataset
devals init
```
