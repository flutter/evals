# Changelog

## Unreleased

### New

- **`Job.description`.** Optional human-readable description field on Job.

- **`Job.imagePrefix` / `Job.image_prefix`.** Registry URL prefix prepended to image names during sandbox resolution. Enables switching between local images and remote registries (e.g. Artifact Registry on GKE) without duplicating job YAML files.

- **Tag-based filtering.** New `TagFilter` model with `include_tags` and `exclude_tags`, used at two levels:
  - `Job.taskFilters` / `Job.task_filters` — select tasks by metadata tags
  - `Job.sampleFilters` / `Job.sample_filters` — select samples by metadata tags

- **`JobTask.args`.** Per-task argument overrides. Allows a job to pass task-specific arguments (e.g. `base_url`, `dataset_path`) to individual tasks.

- **`Task.systemMessage` / `Task.system_message`.** System prompt override at the task level.

- **`Task.sandboxParameters` / `Task.sandbox_parameters`.** Pass-through dictionary for sandbox plugin configuration.

- **`Task.files` / `Task.setup`.** Task-level file and setup declarations. Task-level `files` stack with sample-level `files` (sample wins on key conflict). Sample-level `setup` overrides task-level `setup`.

- **Variant `task_parameters`.** Variants can now declare `task_parameters`, an arbitrary dict merged into the task config at runtime.

- **`module:task` syntax.** Task function references can now use `module.path:function_name` format for Python tasks.

### Breaking Changes

- **`Task.taskFunc` → `Task.func`.** Renamed model field to match the YAML key name. JSON serialization key changes from `"task_func"` to `"func"`. Both Dart and Python packages must update in lockstep.

- **Sandbox registry is now configurable.** The hardcoded `kSandboxRegistry` and `kSdkChannels` maps are extracted from `eval_set_resolver.dart` and made data-driven, allowing non-Flutter projects to define their own sandbox configurations.

- **Removed `workspace` and `tests` from task and sample YAML.** Replaced by `files` (a `{destination: source}` map) and `setup` (a shell command string). These are Inspect AI's native `Sample` fields. The old `workspace:` / `tests:` keys and their path/git/template sub-formats are no longer supported.

- **Consolidated sandbox config.** `Job.sandboxEnvironment`, `Job.sandboxParameters`, `Job.imagePrefix` collapsed into a single `Job.sandbox` map (keys: `environment`, `parameters`, `image_prefix`).

- **Consolidated Inspect AI eval arguments.** Individual top-level Job fields (`retryAttempts`, `failOnError`, `logLevel`, `maxTasks`, etc.) collapsed into a single `Job.inspectEvalArguments` / `Job.inspect_eval_arguments` pass-through dict.

- **`inspect_task_args` is now a pass-through dict.** Individual sub-fields (`model`, `epochs`, `time_limit`, etc.) are no longer typed on the `Task` model. The entire `inspect_task_args` section is passed through as-is to Inspect AI's `Task()` constructor.

- **Removed `JobTask.systemMessage`.** System message is now set at the task level via `Task.systemMessage`.

- **Variant field renames.** `context_files` → `files`, `skill_paths` → `skills`. Variant-level task restriction uses `include-variants` / `exclude-variants` on the job's `tasks.<id>` object instead of task-level `allowed_variants`.

### Documentation

- Added `docs/reference/yaml_config.md` with complete field-by-field reference tables.
- Updated `docs/reference/configuration_reference.md` with new examples and directory structure.
- Updated `docs/guides/config.md`.

## 11 March, 2025

### New

- **`dataset_config_python` package.** Python port of the Dart config package (`dataset_config_dart`), providing full parity for YAML parsing, resolution, and JSON output. Includes Pydantic models for `Job`, `Task`, `Sample`, `EvalSet`, `Variant`, `Dataset`, and `ContextFile`. Exposes `resolve()` and `write_eval_sets()` as the public API. No Dart SDK or Inspect AI dependency required — can be installed standalone by any team that needs to parse eval config YAML.

### Breaking Changes

- **Renamed `dataset_config` → `dataset_config_dart`.** The Dart config package was renamed for clarity alongside the new Python package.

- **Renamed `dash_evals_config` → `dataset_config_python`.** The Python config package was renamed from its original name for consistency with the Dart package.

## 28 February, 2025

### New

- **`eval_config` Dart package.** New package with a layered Parser → Resolver → Writer architecture that converts dataset YAML into EvalSet JSON for the Python runner. Provides `ConfigResolver` facade plus direct access to `YamlParser`, `JsonParser`, `EvalSetResolver`, and `EvalSetWriter`.

- **Dual-mode eval runner.** The Python runner now supports two invocation modes:
  - `run-evals --json ./eval_set.json` — consume a JSON manifest produced by the Dart CLI
  - `run-evals --task <name> --model <model>` — run a single task directly from CLI arguments

- **Generalized task functions.** Task implementations are now language-agnostic by default. Flutter-specific tasks (`flutter_bug_fix`, `flutter_code_gen`) are thin wrappers around the generic `bug_fix` and `code_gen` tasks. New tasks: `analyze_codebase`, `mcp_tool`, `skill_test`.

- **New Dart domain models.** `EvalSet`, `Task`, `Sample`, `Variant`, and `TaskInfo` models in the `models` package map directly to the Inspect AI evaluation structure.

### Breaking Changes

- **Removed Python `registries.py`.** Task/model/sandbox registries are removed. Task functions are now discovered dynamically via `importlib` (short names like `"flutter_code_gen"` resolve automatically).

- **Removed `TaskConfig` and `SampleConfig`.** Replaced by `ParsedTask` (intermediate parsing type in `eval_config`) and `Sample` (Inspect AI domain model).

- **Removed legacy Python config parsing.** The `config/parsers/` directory, `load_yaml` utility, and associated model definitions have been removed from `eval_runner`. Configuration is now handled by the Dart `eval_config` package.

- **Models package reorganized.** Report-app models (used by the Flutter results viewer) moved to `models/lib/src/report_app/`. The top-level `models/lib/src/` now contains inspect-domain models.

- **Dataset utilities moved.** `DatasetReader`, `filesystem_utils`, and discovery helpers moved from `eval_config` to `eval_cli`.

## 25 February, 2025

### Breaking Changes

- **Variant format changed from list to named map.** Job YAML files now define variants as a named map instead of a list. Tasks can optionally restrict applicable variants via `allowed_variants` in their `task.yaml`.

  **Before (list format):**
  ```yaml
  variants:
    - baseline
    - { mcp_servers: [dart] }
  ```

  **After (named map format):**
  ```yaml
  # job.yaml
  variants:
    baseline: {}
    mcp_only: { mcp_servers: [dart] }
    context_only: { context_files: [./context_files/flutter.md] }
    full: { context_files: [./context_files/flutter.md], mcp_servers: [dart] }
  ```

  ```yaml
  # task.yaml (optional — omit to accept all job variants)
  allowed_variants: [baseline, mcp_only]
  ```

- **Removed `DEFAULT_VARIANTS` registry.** Variants are no longer defined globally in `registries.py`. Each job file defines its own variants.

- **Removed `variants` from `JobTask`.** Per-task variant overrides (`job.tasks.<id>.variants`) are replaced by task-level `allowed_variants` whitelists.