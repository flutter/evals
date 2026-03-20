# Configuration Reference

This document describes the *standard* `eval/` directory structure and YAML configuration files used by the evaluation framework.

## Overview

The evaluation framework uses the `eval/` directory as its entry point. It contains:

- Task definitions autodiscovered from `tasks/*/task.yaml`
- Job files in `jobs/` that control what to run
- Shared resources (context files, sandboxes)

Configuration is parsed and resolved by the Dart `dataset_config_dart` package, which produces an EvalSet JSON manifest consumed by the Python `dash_evals`.

> **See also:** [YAML Configuration Fields](yaml_config.md) for a complete field-by-field reference with Dart and Python cross-references.

## Directory Structure

```
eval/
├── jobs/                    # Job files for different run configurations
│   ├── local_dev.yaml
│   └── ci.yaml
├── tasks/                   # Task definitions (autodiscovered)
│   ├── flutter_bug_fix/
│   │   ├── task.yaml        # Task config with inline samples
│   │   └── project/         # Project files (if applicable)
│   ├── dart_question_answer/
│   │   └── task.yaml
│   └── generate_flutter_app/
│       ├── task.yaml
│       └── todo_tests/      # Test files for a sample
├── context_files/           # Context files injected into prompts
│   └── flutter.md
└── sandboxes/               # Container configurations
    └── podman/
        ├── Containerfile
        └── compose.yaml
```

---

## Task files

Each subdirectory in `tasks/` that contains a `task.yaml` is automatically discovered as a task. The **directory name** is the task ID.

```yaml
# tasks/flutter_bug_fix/task.yaml
func: flutter_bug_fix
system_message: |
  You are an expert Flutter developer. Fix the bug and explain your changes.

# Task-level files copied into sandbox (inherited by all samples)
files:
  /workspace: ./project
setup: "cd /workspace && flutter pub get"

dataset:
  samples:
    inline:
      - id: flutter_bloc_cart_mutation_001
        input: |
          Fix the bug where adding items to cart doesn't update the total.
        target: |
          The fix should modify the BLoC to emit a new state instead of mutating.
        metadata:
          difficulty: medium
          tags: [bloc, state]

      - id: navigation_crash
        files:
          /workspace: ./nav_project    # Override task-level files
        input: |
          Fix the crash when navigating back from the detail screen.
        target: |
          The fix should handle the disposed controller properly.
        metadata:
          difficulty: hard
          tags: [navigation]
```

For the complete list of task fields (including Inspect AI `Task` parameters), see the [Task fields table](yaml_config.md#task).

### Files and Setup

```yaml
# Copy a local directory into the sandbox
files:
  /workspace: ./project
setup: "cd /workspace && flutter pub get"

# Copy individual files
files:
  /workspace/lib/main.dart: ./fixtures/main.dart
  /workspace/test/widget_test.dart: ./fixtures/test.dart
```

> [!NOTE]
> Paths in `files` values are resolved **relative to the task directory** (e.g., `tasks/flutter_bug_fix/`). Task-level `files` and `setup` are inherited by all samples. Sample-level `files` stack on top (sample wins on key conflict). Sample-level `setup` overrides task-level `setup`.

---

## Sample files

A sample is a single test case containing an input prompt, expected output (grading target), and optional configuration. Samples are defined inline in `task.yaml` or in external YAML files referenced via `paths`.

```yaml
# Inline in task.yaml
dataset:
  samples:
    inline:
      - id: dart_async_await_001
        input: |
          Explain the difference between Future.then() and async/await in Dart.
        target: |
          The answer should cover both approaches, explain that they are
          functionally equivalent, and note when each is preferred.
        metadata:
          difficulty: medium
          tags: [async, dart]
          added: 2025-02-04
          category: language_fundamentals
```

For the complete list of sample fields, see the [Sample fields table](yaml_config.md#sample).

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

## Job files

Job files define **what to run** and can **override built-in runtime defaults**. They're selected via `devals run <job_name>`. Multiple jobs can be run sequentially.

```yaml
# jobs/local_dev.yaml
name: local_dev

# Sandbox configuration (string shorthand or object)
sandbox:
  environment: podman

# Override runtime defaults
max_connections: 15

# Save the agent's final workspace output to logs/<run>/examples/
# save_examples: true

# Filter what to run (required)
models:
  - google/gemini-2.5-flash

# Variants are defined as a named map.
# Each key is a variant name; the value is the variant configuration.
variants:
  baseline: {}
  context_only: { files: [./context_files/flutter.md] }
  mcp_only: { mcp_servers: [{name: dart, command: dart, args: [mcp-server]}] }
  full: { files: [./context_files/flutter.md], mcp_servers: [{name: dart, command: dart, args: [mcp-server]}] }

# Inspect AI eval_set() parameters (all optional, nested under inspect_eval_arguments)
inspect_eval_arguments:
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

For the complete list of job fields (including all Inspect AI `eval_set()` parameters), see the [Job fields table](yaml_config.md#job).

### Pass-Through Sections

#### `task_defaults`

Default [Task parameters](yaml_config.md#task) applied to **every task** in this job. Per-task overrides from `task.yaml` take precedence. Nested under `inspect_eval_arguments`:

```yaml
inspect_eval_arguments:
  task_defaults:
    time_limit: 600
    message_limit: 50
    cost_limit: 2.0
    epochs: 3
```

#### `eval_set_overrides`

Arbitrary `eval_set()` kwargs for parameters not covered by the named fields above. Top-level `inspect_eval_arguments` fields take precedence over overrides. Nested under `inspect_eval_arguments`:

```yaml
inspect_eval_arguments:
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
      include-variants: [baseline]     # Only run these variants for this task
      include-samples: [sample_001]    # Only run these samples
      exclude-samples: [slow_test]     # Exclude these samples
```

---

## Variants

Variants modify how tasks execute, controlling context injection, tool availability, and skill access. Variants are defined as **named maps** in job files.

```yaml
variants:
  baseline: {}
  context_only: { files: [./context_files/flutter.md] }
  mcp_only: { mcp_servers: [{name: dart, command: dart, args: [mcp-server]}] }
  full: { files: [./context_files/flutter.md], mcp_servers: [{name: dart, command: dart, args: [mcp-server]}] }
```

Variant sub-fields (`files`, `mcp_servers`, `skills`, `task_parameters`) are documented in the [Job fields table](yaml_config.md#job).

Jobs can restrict which variants apply to specific tasks via `include-variants` and `exclude-variants` on the `tasks.<task_id>` object:

```yaml
# job.yaml — only run baseline and mcp_only variants for flutter_bug_fix
tasks:
  inline:
    flutter_bug_fix:
      include-variants: [baseline, mcp_only]
```

Glob patterns (containing `*`, `?`, or `[`) are expanded automatically. For skills, only directories containing `SKILL.md` are included.

### MCP Server Modes

MCP servers in variants support three modes:

```yaml
variants:
  # 1. Declarative stdio/sandbox — command-based
  with_dart_mcp:
    mcp_servers:
      - name: dart
        command: dart
        args: [mcp-server]

  # 2. Declarative HTTP — url-based
  with_http_mcp:
    mcp_servers:
      - name: my-api
        url: https://mcp.example.com/api
        authorization: "bearer-token-here"    # optional OAuth Bearer token
        headers:                               # optional extra headers
          X-Custom-Header: value

  # 3. Python ref — import a pre-built MCPServer
  with_custom_mcp:
    mcp_servers:
      - ref: "my_package.mcp:staging_server"
```

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
has files pointing to this file.
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
