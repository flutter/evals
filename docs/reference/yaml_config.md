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
* - `sandbox_type`
  - string
  - Y
  - `sandboxType`
  - `sandbox_type`
  - Sandbox type: `local`, `docker`, or `podman` (default: `local`)
* - `image_prefix`
  - string
  - Y
  - `imagePrefix`
  - `image_prefix`
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
  - Named variant definitions (keys are names, values are config maps)
* - `variants`\
    &nbsp;&nbsp;`.<name>`\
    &nbsp;&nbsp;`.context_files`
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
  - MCP server identifiers
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
    &nbsp;&nbsp;`.flutter_channel`
  - string
  - Y
  -
  -
  - Flutter SDK channel (`stable`, `beta`, `main`)
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
    &nbsp;&nbsp;`.system_message`
  - string
  - Y
  - `JobTask.systemMessage`
  - `JobTask.system_message`
  - Override system message for this task
* - `tasks`\
    &nbsp;&nbsp;`.<task_id>`\
    &nbsp;&nbsp;`.args`
  - object
  - Y
  - `JobTask.args`
  - `JobTask.args`
  - Per-task argument overrides passed to the task function
* - `save_examples`
  - bool
  - Y
  - `saveExamples`
  - `save_examples`
  - Copy final workspace to `<logDir>/examples/` after each sample (default: `false`)
* - `retry_attempts`
  - int
  - Y
  - `retryAttempts`
  - `retry_attempts`
  - Max retry attempts before giving up
* - `max_retries`
  - int
  - Y
  - `maxRetries`
  - `max_retries`
  - Max retry attempts for failed samples
* - `retry_wait`
  - float
  - Y
  - `retryWait`
  - `retry_wait`
  - Seconds between retries (exponential backoff)
* - `retry_connections`
  - float
  - Y
  - `retryConnections`
  - `retry_connections`
  - Reduce `max_connections` at this rate per retry
* - `retry_cleanup`
  - bool
  - Y
  - `retryCleanup`
  - `retry_cleanup`
  - Cleanup failed log files after retries
* - `fail_on_error`
  - float
  - Y
  - `failOnError`
  - `fail_on_error`
  - Fail if error proportion exceeds threshold (`0.0–1.0`)
* - `continue_on_fail`
  - bool
  - Y
  - `continueOnFail`
  - `continue_on_fail`
  - Continue running even if `fail_on_error` condition is met
* - `retry_on_error`
  - int
  - Y
  - `retryOnError`
  - `retry_on_error`
  - Retry samples on error (per-sample)
* - `debug_errors`
  - bool
  - Y
  - `debugErrors`
  - `debug_errors`
  - Raise task errors for debugging
* - `max_samples`
  - int
  - Y
  - `maxSamples`
  - `max_samples`
  - Max concurrent samples per task
* - `max_tasks`
  - int
  - Y
  - `maxTasks`
  - `max_tasks`
  - Max tasks to run in parallel
* - `max_subprocesses`
  - int
  - Y
  - `maxSubprocesses`
  - `max_subprocesses`
  - Max subprocesses in parallel
* - `max_sandboxes`
  - int
  - Y
  - `maxSandboxes`
  - `max_sandboxes`
  - Max sandboxes (per-provider) in parallel
* - `log_level`
  - string
  - Y
  - `logLevel`
  - `log_level`
  - Console log level (`debug`, `info`, `warning`, `error`)
* - `log_level_transcript`
  - string
  - Y
  - `logLevelTranscript`
  - `log_level_transcript`
  - Log file level
* - `log_format`
  - string
  - Y
  - `logFormat`
  - `log_format`
  - Log format (`eval` or `json`)
* - `log_samples`
  - bool
  - Y
  - `logSamples`
  - `log_samples`
  - Log detailed samples and scores
* - `log_realtime`
  - bool
  - Y
  - `logRealtime`
  - `log_realtime`
  - Log events in realtime
* - `log_images`
  - bool
  - Y
  - `logImages`
  - `log_images`
  - Log base64-encoded images
* - `log_buffer`
  - int
  - Y
  - `logBuffer`
  - `log_buffer`
  - Samples to buffer before log write
* - `log_shared`
  - int
  - Y
  - `logShared`
  - `log_shared`
  - Sync sample events for realtime viewing
* - `log_dir_allow_dirty`
  - bool
  - Y
  - `logDirAllowDirty`
  - `log_dir_allow_dirty`
  - Allow log dir with unrelated logs
* - `model_base_url`
  - string
  - Y
  - `modelBaseUrl`
  - `model_base_url`
  - Base URL for the model API
* - `model_args`
  - object
  - Y
  - `modelArgs`
  - `model_args`
  - Model creation arguments
* - `model_roles`
  - object
  - Y
  - `modelRoles`
  - `model_roles`
  - Named roles for `get_model()`
* - `task_args`
  - object
  - Y
  - `taskArgs`
  - `task_args`
  - Task creation arguments
* - `model_cost_config`
  - object
  - Y
  - `modelCostConfig`
  - `model_cost_config`
  - Model prices for cost tracking
* - `limit`
  - int/list
  - Y
  - `limit`
  - `limit`
  - Limit samples (count or `[start, end]` range)
* - `sample_id`
  - string/list
  - Y
  - `sampleId`
  - `sample_id`
  - Evaluate specific sample(s)
* - `sample_shuffle`
  - bool/int
  - Y
  - `sampleShuffle`
  - `sample_shuffle`
  - Shuffle samples (pass seed for deterministic order)
* - `epochs`
  - int/object
  - Y
  - `epochs`
  - `epochs`
  - Repeat samples and optional score reducer
* - `message_limit`
  - int
  - Y
  - `messageLimit`
  - `message_limit`
  - Max messages per sample
* - `token_limit`
  - int
  - Y
  - `tokenLimit`
  - `token_limit`
  - Max tokens per sample
* - `time_limit`
  - int
  - Y
  - `timeLimit`
  - `time_limit`
  - Max clock time (seconds) per sample
* - `working_limit`
  - int
  - Y
  - `workingLimit`
  - `working_limit`
  - Max working time (seconds) per sample
* - `cost_limit`
  - float
  - Y
  - `costLimit`
  - `cost_limit`
  - Max cost (dollars) per sample
* - `tags`
  - list
  - Y
  - `tags`
  - `tags`
  - Tags for this evaluation run
* - `metadata`
  - object
  - Y
  - `metadata`
  - `metadata`
  - Metadata for this evaluation run
* - `trace`
  - bool
  - Y
  - `trace`
  - `trace`
  - Trace model interactions to terminal
* - `display`
  - string
  - Y
  - `display`
  - `display`
  - Task display type (default: `full`)
* - `score`
  - bool
  - Y
  - `score`
  - `score`
  - Score output (default: `true`)
* - `approval`
  - string/object
  - Y
  - `approval`
  - `approval`
  - Tool use approval policies
* - `solver`
  - string/object
  - Y
  - `solver`
  - `solver`
  - Alternative solver(s)
* - `sandbox_cleanup`
  - bool
  - Y
  - `sandboxCleanup`
  - `sandbox_cleanup`
  - Cleanup sandbox after task
* - `bundle_dir`
  - string
  - Y
  - `bundleDir`
  - `bundle_dir`
  - Directory for bundled logs + viewer
* - `bundle_overwrite`
  - bool
  - Y
  - `bundleOverwrite`
  - `bundle_overwrite`
  - Overwrite files in `bundle_dir`
* - `eval_set_id`
  - string
  - Y
  - `evalSetId`
  - `eval_set_id`
  - Custom ID for the eval set
* - `eval_set_overrides`
  - object
  - Y
  - `evalSetOverrides`
  - `eval_set_overrides`
  - Additional `eval_set()` kwargs not covered by top-level fields
* - `task_defaults`
  - object
  - Y
  - `taskDefaults`
  - `task_defaults`
  - Default `Task` kwargs applied to every task in this job
```

## Task

Task files define a single evaluation task with its samples, prompt configuration, and optional Inspect AI `Task` parameter overrides. Located in `eval/tasks/<task_id>/task.yaml`.

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
  - N
  -
  -
  - Samples config with `inline` and/or `paths` keys
* - `samples`\
    &nbsp;&nbsp;`.inline`
  - list
  - Y
  -
  -
  - Inline sample definitions (list of sample objects)
* - `samples`\
    &nbsp;&nbsp;`.paths`
  - list
  - Y
  -
  -
  - Glob patterns for external sample YAML files (relative to task dir)
* - `allowed_variants`
  - list
  - Y
  -
  -
  - Whitelist of variant names this task accepts
* - `variant_filters`
  - object
  - Y
  -
  -
  - Tag-based variant filter (same schema as job-level `task_filters`)
* - `system_message`
  - string
  - Y
  - `systemMessage`
  - `system_message`
  - Custom system prompt for this task
* - `sandbox_parameters`
  - object
  - Y
  - `sandboxParameters`
  - `sandbox_parameters`
  - Pass-through parameters for sandbox plugin configuration
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
* - `model`
  - string
  - Y
  - `model`
  - `model`
  - Default model for this task
* - `config`
  - object
  - Y
  - `config`
  - `config`
  - Model generation config (e.g. `{temperature: 0.2}`)
* - `model_roles`
  - object
  - Y
  - `modelRoles`
  - `model_roles`
  - Named roles for `get_model()`
* - `sandbox`
  - string/object
  - Y
  - `sandbox`
  - `sandbox`
  - Sandbox environment type or config
* - `approval`
  - string/object
  - Y
  - `approval`
  - `approval`
  - Tool use approval policies
* - `epochs`
  - int/object
  - Y
  - `epochs`
  - `epochs`
  - Number of times to repeat each sample
* - `fail_on_error`
  - number/bool
  - Y
  - `failOnError`
  - `fail_on_error`
  - Fail threshold for sample errors
* - `continue_on_fail`
  - bool
  - Y
  - `continueOnFail`
  - `continue_on_fail`
  - Continue running if `fail_on_error` condition is met
* - `message_limit`
  - int
  - Y
  - `messageLimit`
  - `message_limit`
  - Max total messages per sample
* - `token_limit`
  - int
  - Y
  - `tokenLimit`
  - `token_limit`
  - Max total tokens per sample
* - `time_limit`
  - int
  - Y
  - `timeLimit`
  - `time_limit`
  - Max clock time (seconds) per sample
* - `working_limit`
  - int
  - Y
  - `workingLimit`
  - `working_limit`
  - Max working time (seconds) per sample
* - `cost_limit`
  - float
  - Y
  - `costLimit`
  - `cost_limit`
  - Max cost (dollars) per sample
* - `early_stopping`
  - string/object
  - Y
  - `earlyStopping`
  - `early_stopping`
  - Early stopping callbacks
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
```

## Sample

Samples are individual test cases defined either inline in `task.yaml` under `samples.inline`, or in external YAML files referenced via `samples.paths`. Fields like `difficulty`, `tags`, `workspace`, and `tests` are parsed from YAML and stored inside the sample's `metadata` dict.

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
* - `difficulty`
  - string
  - Y
  -
  -
  - `easy`, `medium`, or `hard` (stored in `metadata["difficulty"]`)
* - `tags`
  - list
  - Y
  -
  -
  - Categories for filtering (stored in `metadata["tags"]`)
* - `system_message`
  - string
  - Y
  -
  -
  - Override system prompt for this sample (stored in `metadata`)
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
