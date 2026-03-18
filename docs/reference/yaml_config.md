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
* - `sandbox`\\
    &nbsp;&nbsp;`.environment`
  - string
  - Y
  -
  -
  - Sandbox type: `local`, `docker`, or `podman` (default: `local`)
* - `sandbox`\\
    &nbsp;&nbsp;`.parameters`
  - object
  - Y
  -
  -
  - Pass-through parameters for sandbox plugin configuration
* - `sandbox`\\
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
  - Y
  - `models`
  - `models`
  - Filter to specific models — omit to use defaults
* - `variants`
  - map
  - Y
  - `variants`
  - `variants`
  - Named variant definitions (keys are names, values are config maps). Can also be a list of paths to external variant files.
* - `variants`\
    &nbsp;&nbsp;`.<name>`\
    &nbsp;&nbsp;`.files`
  - list
  - Y
  -
  -
  - Paths or glob patterns to context files
* - `variants`\
    &nbsp;&nbsp;`.<name>`\
    &nbsp;&nbsp;`.mcp_servers`
  - list
  - Y
  -
  -
  - MCP server configurations (list of objects with `name`, `command`, `args`, `env`, `transport`; or a `ref:` string to a Python package)
* - `variants`\
    &nbsp;&nbsp;`.<name>`\
    &nbsp;&nbsp;`.skills`
  - list
  - Y
  -
  -
  - Paths or glob patterns to skill directories
* - `variants`\
    &nbsp;&nbsp;`.<name>`\
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
* - `task_filters`\
    &nbsp;&nbsp;`.include_tags`
  - list
  - Y
  - `TagFilter.includeTags`
  - `TagFilter.include_tags`
  - Only run tasks whose metadata tags include **all** of these
* - `task_filters`\
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
* - `tasks`\
    &nbsp;&nbsp;`.<task_id>`\
    &nbsp;&nbsp;`.include-samples`
  - list
  - Y
  - `JobTask.includeSamples`
  - `JobTask.include_samples`
  - Only run these sample IDs
* - `tasks`\
    &nbsp;&nbsp;`.<task_id>`\
    &nbsp;&nbsp;`.exclude-samples`
  - list
  - Y
  - `JobTask.excludeSamples`
  - `JobTask.exclude_samples`
  - Exclude these sample IDs
* - `tasks`\
    &nbsp;&nbsp;`.<task_id>`\
    &nbsp;&nbsp;`.args`
  - object
  - Y
  - `JobTask.args`
  - `JobTask.args`
  - Per-task argument overrides passed to the task function
* - `tasks`\\
    &nbsp;&nbsp;`.<task_id>`\\
    &nbsp;&nbsp;`.include-variants`
  - list
  - Y
  - `JobTask.includeVariants`
  - `JobTask.include_variants`
  - Only run these variant names for this task
* - `tasks`\\
    &nbsp;&nbsp;`.<task_id>`\\
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
* - `samples`
  - object
  - Y
  -
  -
  - Samples config with `inline` and/or `paths` keys (optional — task can have no samples)
* - `samples`\\
    &nbsp;&nbsp;`.inline`
  - list
  - Y
  -
  -
  - Inline sample definitions (list of sample objects)
* - `samples`\\
    &nbsp;&nbsp;`.paths`
  - list
  - Y
  -
  -
  - Glob patterns for external sample YAML files (relative to task dir)
* - `system_message`
  - string
  - Y
  - `systemMessage`
  - `system_message`
  - Custom system prompt for this task
* - `workspace`
  - string/object
  - Y
  -
  -
  - Default workspace for all samples (resolved into `Sample.files` and `Sample.setup`)
* - `tests`
  - string/object
  - Y
  -
  -
  - Default test files for all samples
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
  - Inspect AI `Task` parameters. See sub-fields below.
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.model`
  - string
  - Y
  - `model`
  - `model`
  - Default model for this task
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.config`
  - object
  - Y
  - `config`
  - `config`
  - Model generation config (e.g. `{temperature: 0.2}`)
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.model_roles`
  - object
  - Y
  - `modelRoles`
  - `model_roles`
  - Named roles for `get_model()`
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.sandbox`
  - string/object
  - Y
  - `sandbox`
  - `sandbox`
  - Sandbox environment type or config
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.sandbox_parameters`
  - object
  - Y
  - `sandboxParameters`
  - `sandbox_parameters`
  - Pass-through parameters for sandbox plugin configuration
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.approval`
  - string/object
  - Y
  - `approval`
  - `approval`
  - Tool use approval policies
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.epochs`
  - int/object
  - Y
  - `epochs`
  - `epochs`
  - Number of times to repeat each sample
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.fail_on_error`
  - number/bool
  - Y
  - `failOnError`
  - `fail_on_error`
  - Fail threshold for sample errors
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.continue_on_fail`
  - bool
  - Y
  - `continueOnFail`
  - `continue_on_fail`
  - Continue running if `fail_on_error` condition is met
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.message_limit`
  - int
  - Y
  - `messageLimit`
  - `message_limit`
  - Max total messages per sample
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.token_limit`
  - int
  - Y
  - `tokenLimit`
  - `token_limit`
  - Max total tokens per sample
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.time_limit`
  - int
  - Y
  - `timeLimit`
  - `time_limit`
  - Max clock time (seconds) per sample
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.working_limit`
  - int
  - Y
  - `workingLimit`
  - `working_limit`
  - Max working time (seconds) per sample
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.cost_limit`
  - float
  - Y
  - `costLimit`
  - `cost_limit`
  - Max cost (dollars) per sample
* - `inspect_task_args`\\
    &nbsp;&nbsp;`.early_stopping`
  - string/object
  - Y
  - `earlyStopping`
  - `early_stopping`
  - Early stopping callbacks
```

## Sample

Samples are individual test cases defined either inline in `task.yaml` under `samples.inline`, or in external YAML files referenced via `samples.paths`. Fields like `difficulty`, `tags`, `workspace`, and `tests` should be nested inside the sample's `metadata` dict.

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
* - `metadata`\\
    &nbsp;&nbsp;`.difficulty`
  - string
  - Y
  -
  -
  - `easy`, `medium`, or `hard`
* - `metadata`\\
    &nbsp;&nbsp;`.tags`
  - list
  - Y
  -
  -
  - Categories for filtering
* - `metadata`\\
    &nbsp;&nbsp;`.system_message`
  - string
  - Y
  -
  -
  - Override system prompt for this sample
* - `workspace`
  - string/object
  - Y
  -
  -
  - Override task-level workspace (resolved path stored in `metadata["workspace"]`)
* - `tests`
  - string/object
  - Y
  -
  -
  - Override task-level tests (resolved path stored in `metadata["tests"]`)
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
