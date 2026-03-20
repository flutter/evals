# YAML Configuration Fields

This page provides a complete field-by-field reference for each YAML configuration file type, cross-referenced with the corresponding Dart and Python object field names.

## Job

Job files define runtime settings for an evaluation run, including sandbox configuration, rate limits, model selection, variant definitions, tag-based filtering, and pass-through parameters for Inspect AI's `eval_set()` and `Task` constructors. Located in `eval/jobs/`.

```{list-table}
:header-rows: 1
:widths: 20 8 5 12 12 43

* - Field name
  - YAML type
  - Optional
  - Dart field
  - Python field
  - Description
* - `description`
  - string
  - Y
  - `description`
  - `description`
  - Human-readable description of the job
* - `log_dir`
  - string
  - N
  - `logDir`
  - `log_dir`
  - Directory to write evaluation logs to
* - `sandbox`
  - string/object
  - Y
  - `sandbox`
  - `sandbox`
  - Sandbox configuration. String shorthand (e.g. `podman`) is equivalent to `{environment: podman}`
* - `sandbox` \
    &nbsp;&nbsp;`.environment`
  - string
  - Y
  -
  -
  - Sandbox type: `local`, `docker`, or `podman` (default: `local`)
* - `sandbox` \
    &nbsp;&nbsp;`.parameters`
  - object
  - Y
  -
  -
  - Pass-through parameters for sandbox plugin configuration
* - `sandbox` \
    &nbsp;&nbsp;`.image_prefix`
  - string
  - Y
  -
  -
  - Registry prefix prepended to image names during sandbox resolution (e.g. `us-central1-docker.pkg.dev/project/repo/`)
* - `max_connections`
  - int
  - Y
  - `maxConnections`
  - `max_connections`
  - Maximum concurrent API connections (default: `10`)
* - `models`
  - list
  - N
  - `models`
  - `models`
  - List of model identifiers to evaluate (required — at least one model must be specified)
* - `variants`
  - map
  - Y
  - `variants`
  - `variants`
  - Named variant definitions (keys are names, values are config maps). Can also be a list of paths to external variant files.
* - `variants` \
    &nbsp;&nbsp;`.<name>` \
    &nbsp;&nbsp;`.files`
  - list
  - Y
  -
  -
  - Paths or glob patterns to context files
* - `variants` \
    &nbsp;&nbsp;`.<name>` \
    &nbsp;&nbsp;`.mcp_servers`
  - list
  - Y
  -
  -
  - MCP server configurations. Each entry is one of: (1) an object with `command`/`args` for stdio/sandbox, (2) an object with `url` for HTTP, or (3) a `ref:` string pointing to a Python MCPServer object. Common sub-fields: `name`, `transport`. Stdio sub-fields: `command`, `args`, `env`, `cwd`. HTTP sub-fields: `url`, `authorization`, `headers`.
* - `variants` \
    &nbsp;&nbsp;`.<name>` \
    &nbsp;&nbsp;`.skills`
  - list
  - Y
  -
  -
  - Paths or glob patterns to skill directories
* - `variants` \
    &nbsp;&nbsp;`.<name>` \
    &nbsp;&nbsp;`.task_parameters`
  - object
  - Y
  -
  -
  - Optional parameters merged into the task config dict at runtime
* - `task_filters`
  - object
  - Y
  - `taskFilters`
  - `task_filters`
  - Tag-based task selection filter
* - `task_filters` \
    &nbsp;&nbsp;`.include_tags`
  - list
  - Y
  - `TagFilter.includeTags`
  - `TagFilter.include_tags`
  - Only run tasks whose metadata tags include **all** of these
* - `task_filters` \
    &nbsp;&nbsp;`.exclude_tags`
  - list
  - Y
  - `TagFilter.excludeTags`
  - `TagFilter.exclude_tags`
  - Exclude tasks whose metadata tags include **any** of these
* - `sample_filters`
  - object
  - Y
  - `sampleFilters`
  - `sample_filters`
  - Tag-based sample selection filter (same schema as `task_filters`)
* - `task_paths`
  - list
  - Y
  - `taskPaths`
  - `task_paths`
  - Glob patterns for discovering task directories (relative to dataset root)
* - `tasks`
  - object
  - Y
  - `tasks`
  - `tasks`
  - Per-task configurations with inline overrides
* - `tasks` \
    &nbsp;&nbsp;`.<task_id>` \
    &nbsp;&nbsp;`.include-samples`
  - list
  - Y
  - `JobTask.includeSamples`
  - `JobTask.include_samples`
  - Only run these sample IDs
* - `tasks` \
    &nbsp;&nbsp;`.<task_id>` \
    &nbsp;&nbsp;`.exclude-samples`
  - list
  - Y
  - `JobTask.excludeSamples`
  - `JobTask.exclude_samples`
  - Exclude these sample IDs
* - `tasks` \
    &nbsp;&nbsp;`.<task_id>` \
    &nbsp;&nbsp;`.args`
  - object
  - Y
  - `JobTask.args`
  - `JobTask.args`
  - Per-task argument overrides passed to the task function
* - `tasks` \
    &nbsp;&nbsp;`.<task_id>` \
    &nbsp;&nbsp;`.include-variants`
  - list
  - Y
  - `JobTask.includeVariants`
  - `JobTask.include_variants`
  - Only run these variant names for this task
* - `tasks` \
    &nbsp;&nbsp;`.<task_id>` \
    &nbsp;&nbsp;`.exclude-variants`
  - list
  - Y
  - `JobTask.excludeVariants`
  - `JobTask.exclude_variants`
  - Exclude these variant names for this task
* - `save_examples`
  - bool
  - Y
  - `saveExamples`
  - `save_examples`
  - Copy final workspace to `<logDir>/examples/` after each sample (default: `false`)
* - `inspect_eval_arguments`
  - object
  - Y
  - `inspectEvalArguments`
  - `inspect_eval_arguments`
  - Pass-through dict of any valid Inspect AI `eval_set()` kwargs (e.g. `retry_attempts`, `log_level`, `max_tasks`, `tags`, `task_defaults`, `eval_set_overrides`, etc.). See [Inspect AI docs](https://inspect.ai-safety-institute.org.uk/) for the full list of supported parameters.
```

## Task

Task files define a single evaluation task with its samples, prompt configuration, and optional Inspect AI `Task` parameter overrides. Located in `eval/tasks/<task_id>/task.yaml`.

Task-level Inspect AI `Task` parameters (model, limits, sandbox, etc.) are nested under `inspect_task_args`.

```{list-table}
:header-rows: 1
:widths: 20 8 5 12 12 43

* - Field name
  - YAML type
  - Optional
  - Dart field
  - Python field
  - Description
* - `func`
  - string
  - Y
  - `func`
  - `func`
  - Name of the `@task` function or `module:function` reference (defaults to directory name)
* - `id`
  - string
  - Y
  -
  -
  - Task identifier (defaults to directory name)
* - `description`
  - string
  - Y
  - `description`
  - `description`
  - Human-readable description
* - `dataset`
  - object
  - Y
  -
  -
  - Dataset configuration. Must contain exactly one of `samples`, `json`, or `csv`.
* - `dataset` \
    &nbsp;&nbsp;`.samples`
  - object
  - Y
  -
  -
  - Inline/file-based sample definitions (see `samples.inline` and `samples.paths` below)
* - `dataset` \
    &nbsp;&nbsp;`.samples` \
    &nbsp;&nbsp;`.inline`
  - list
  - Y
  -
  -
  - Inline sample definitions (list of sample objects)
* - `dataset` \
    &nbsp;&nbsp;`.samples` \
    &nbsp;&nbsp;`.paths`
  - list
  - Y
  -
  -
  - Glob patterns for external sample YAML files (relative to task dir)
* - `dataset` \
    &nbsp;&nbsp;`.json`
  - string
  - Y
  -
  -
  - Path or URL to a JSON/JSONL dataset file (maps to Inspect's `json_dataset()`)
* - `dataset` \
    &nbsp;&nbsp;`.csv`
  - string
  - Y
  -
  -
  - Path to a CSV dataset file (maps to Inspect's `csv_dataset()`)
* - `dataset` \
    &nbsp;&nbsp;`.args`
  - object
  - Y
  - `Dataset.args`
  - `Dataset.args`
  - Additional arguments passed through to the dataset constructor (e.g. `auto_id`, `shuffle`, `delimiter`)
* - `system_message`
  - string
  - Y
  - `systemMessage`
  - `system_message`
  - Custom system prompt for this task
* - `files`
  - object
  - Y
  - `files`
  - `files`
  - Files to copy into sandbox for all samples (`{destination: source}`). Task-level files stack with sample-level files (sample wins on key conflict).
* - `setup`
  - string
  - Y
  - `setup`
  - `setup`
  - Setup script to run in sandbox before evaluation (overridden by sample-level `setup`)
* - `display_name`
  - string
  - Y
  - `displayName`
  - `display_name`
  - Task display name (e.g. for plotting)
* - `version`
  - int
  - Y
  - `version`
  - `version`
  - Version of task spec
* - `metadata`
  - object
  - Y
  - `metadata`
  - `metadata`
  - Additional metadata to associate with the task
* - `inspect_task_args`
  - object
  - Y
  -
  -
  - Pass-through dict of any valid Inspect AI `Task()` kwargs (e.g. `model`, `time_limit`, `message_limit`, `epochs`, `sandbox`, etc.). See [Inspect AI docs](https://inspect.ai-safety-institute.org.uk/) for the full list.
```

## Sample

Samples are individual test cases defined either inline in `task.yaml` under `dataset.samples.inline`, or in external YAML files referenced via `dataset.samples.paths`. Fields like `difficulty` and `tags` should be nested inside the sample's `metadata` dict.

```{list-table}
:header-rows: 1
:widths: 20 8 5 12 12 43

* - Field name
  - YAML type
  - Optional
  - Dart field
  - Python field
  - Description
* - `id`
  - string
  - N
  - `id`
  - `id`
  - Unique sample identifier
* - `input`
  - string
  - N
  - `input`
  - `input`
  - The prompt given to the model
* - `target`
  - string
  - N
  - `target`
  - `target`
  - Expected output or grading criteria
* - `metadata` \
    &nbsp;&nbsp;`.difficulty`
  - string
  - Y
  -
  -
  - `easy`, `medium`, or `hard`
* - `metadata` \
    &nbsp;&nbsp;`.tags`
  - list
  - Y
  -
  -
  - Categories for filtering
* - `metadata` \
    &nbsp;&nbsp;`.system_message`
  - string
  - Y
  -
  -
  - Override system prompt for this sample
* - `choices`
  - list
  - Y
  - `choices`
  - `choices`
  - Answer choices for multiple-choice evaluations
* - `metadata`
  - object
  - Y
  - `metadata`
  - `metadata`
  - Arbitrary metadata
* - `sandbox`
  - string/object
  - Y
  - `sandbox`
  - `sandbox`
  - Override sandbox environment for this sample
* - `files`
  - object
  - Y
  - `files`
  - `files`
  - Files to copy into sandbox (`{destination: source}`)
* - `setup`
  - string
  - Y
  - `setup`
  - `setup`
  - Setup script to run in sandbox before evaluation
```
