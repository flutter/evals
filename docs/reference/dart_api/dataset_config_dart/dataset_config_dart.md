# dataset_config_dart

Core library for resolving eval dataset YAML into EvalSet JSON.

This package contains the business logic for:
- Parsing task and job YAML files (or pre-parsed JSON maps)
- Resolving configs (models, sandboxes, variants)
- Writing EvalSet JSON for the Python runner

It is frontend-agnostic — both the CLI and a future web interface
can use this library.

## Quick start

Use [ConfigResolver] for a single-call convenience facade:

```dart
final resolver = ConfigResolver();
final configs = resolver.resolve(datasetPath, ['my_job']);
```

## Layered API

For finer-grained control, use the individual layers:

1. **Parsers** — [YamlParser], [JsonParser]
2. **Resolvers** — [EvalSetResolver]
3. **Writers** — [EvalSetWriter]

---

## abstract class `ChatCompletionChoice`

**Mixins:** `_$ChatCompletionChoice`

Choice generated for completion.

### Constructors

#### `ChatCompletionChoice`

```dart
ChatCompletionChoice({required ChatMessageAssistant message, String stopReason, Logprobs? logprobs})
```

Creates a chat completion choice.

#### `ChatCompletionChoice.fromJson`

```dart
ChatCompletionChoice.fromJson(Map<String, dynamic> json)
```

---

## abstract class `ChatMessage`

**Mixins:** `_$ChatMessage`

Chat message.

### Constructors

#### `ChatMessage.system`

```dart
ChatMessage.system({String? id, required Object content, String? source, Map<String, dynamic>? metadata, String role})
```

System chat message.

#### `ChatMessage.user`

```dart
ChatMessage.user({String? id, required Object content, String? source, Map<String, dynamic>? metadata, String role, Object? toolCallId})
```

User chat message.

#### `ChatMessage.assistant`

```dart
ChatMessage.assistant({String? id, required Object content, String? source, Map<String, dynamic>? metadata, String role, List<ToolCall>? toolCalls, String? model})
```

Assistant chat message.

#### `ChatMessage.tool`

```dart
ChatMessage.tool({String? id, required Object content, String? source, Map<String, dynamic>? metadata, String role, String? toolCallId, String? function, ToolCallError? error})
```

Tool chat message.

#### `ChatMessage.fromJson`

```dart
ChatMessage.fromJson(Map<String, dynamic> json)
```

---

## class `ConfigException`

**Implements:** `Exception`

Exception thrown when runner config resolution fails.

This is the library-level exception for the runner_config package.
CLI or web frontends can catch this and present the error appropriately.

### Constructors

#### `ConfigException`

```dart
ConfigException(String message)
```

### Properties

- **`message`** → `String` *(final)*

---

## class `ConfigResolver`

Convenience facade that composes Parser → Resolver into a single call.

For finer-grained control, use [YamlParser], [JsonParser],
and [EvalSetResolver] directly.

### Constructors

#### `ConfigResolver`

```dart
ConfigResolver()
```

### Methods

#### `resolve`

```dart
List<EvalSet> resolve(String datasetPath, List<String> jobNames)
```

Resolve dataset + job(s) into [EvalSet] objects.

[datasetPath] is the root directory containing `tasks/` and `jobs/`.
[jobNames] are the job names (looked up in `jobs/`) or paths.

**Parameters:**

- `datasetPath` (`String`) *(required)*
- `jobNames` (`List<String>`) *(required)*

---

## abstract class `Content`

**Mixins:** `_$Content`

Content sent to or received from a model.

### Constructors

#### `Content.text`

```dart
Content.text({required String text, bool refusal, List<Object>? citations, String type})
```

Text content.

#### `Content.reasoning`

```dart
Content.reasoning({required String reasoning, String? summary, String? signature, bool redacted, String? text, String type})
```

Reasoning content.

#### `Content.image`

```dart
Content.image({required String image, String detail, String type})
```

Image content.

#### `Content.audio`

```dart
Content.audio({required String audio, required String format, String type})
```

Audio content.

#### `Content.video`

```dart
Content.video({required String video, required String format, String type})
```

Video content.

#### `Content.document`

```dart
Content.document({required String document, String? filename, String? mimeType, String type})
```

Document content.

#### `Content.data`

```dart
Content.data({required Map<String, dynamic> data, String type})
```

Model internal data.

#### `Content.toolUse`

```dart
Content.toolUse({required String toolType, required String id, required String name, Map<String, dynamic>? context, required Map<String, dynamic> arguments, Object? result, Object? error, String type})
```

Server side tool use.

#### `Content.fromJson`

```dart
Content.fromJson(Map<String, dynamic> json)
```

---

## abstract class `ContextFile`

**Mixins:** `_$ContextFile`

A context file with parsed YAML frontmatter and markdown content.

Context files provide additional documentation or guidelines that are
injected into the model's conversation as part of a variant configuration.

File format:
```markdown
---
title: Flutter Widget Guide
version: "1.0"
description: Comprehensive guide to Flutter widgets
---
# Content starts here...

```

### Constructors

#### `ContextFile`

```dart
ContextFile({required ContextFileMetadata metadata, required String content, required String filePath})
```

#### `ContextFile.fromJson`

```dart
ContextFile.fromJson(Map<String, dynamic> json)
```

### Methods

#### `static load`

```dart
static ContextFile load(String filePath)
```

Load a context file from disk, parsing its YAML frontmatter.

The file must begin with `---` and contain valid YAML frontmatter
followed by a closing `---` delimiter.

Throws [FileSystemException] if the file doesn't exist.
Throws [FormatException] if the file lacks valid YAML frontmatter.

**Parameters:**

- `filePath` (`String`) *(required)*

---

## abstract class `ContextFileMetadata`

**Mixins:** `_$ContextFileMetadata`

Metadata parsed from a context file's YAML frontmatter.

### Constructors

#### `ContextFileMetadata`

```dart
ContextFileMetadata({required String title, required String version, required String description, String? dartVersion, String? flutterVersion, String? updated})
```

#### `ContextFileMetadata.fromJson`

```dart
ContextFileMetadata.fromJson(Map<String, dynamic> json)
```

---

## abstract class `Dataset`

**Mixins:** `_$Dataset`

Dart representation of Inspect AI's `Dataset` / `MemoryDataset` class.

A sequence of [Sample] objects.

This models the `MemoryDataset` variant which holds samples in an
in-memory list.

See [`Dataset`](https://inspect.aisi.org.uk/reference/inspect_ai.dataset.html#dataset)
and [`MemoryDataset`](https://inspect.aisi.org.uk/reference/inspect_ai.dataset.html#memorydataset).

### Constructors

#### `Dataset`

```dart
Dataset({List<Sample> samples, String? name, String? location, bool shuffled})
```

#### `Dataset.fromJson`

```dart
Dataset.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EarlyStoppingSummary`

**Mixins:** `_$EarlyStoppingSummary`

Early stopping summary.

### Constructors

#### `EarlyStoppingSummary`

```dart
EarlyStoppingSummary({required String type, double? limit, double? score, Map<String, dynamic> metadata})
```

Creates an early stopping summary.

#### `EarlyStoppingSummary.fromJson`

```dart
EarlyStoppingSummary.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalConfig`

**Mixins:** `_$EvalConfig`

Configuration used for evaluation.

### Constructors

#### `EvalConfig`

```dart
EvalConfig({Object? limit, Object? sampleId, bool? sampleShuffle, int? epochs, List<String>? epochsReducer, String? approval, Object? failOnError, bool? continueOnFail, int? retryOnError, int? messageLimit, int? tokenLimit, int? timeLimit, int? workingLimit, int? maxSamples, int? maxTasks, int? maxSubprocesses, int? maxSandboxes, bool? sandboxCleanup, bool? logSamples, bool? logRealtime, bool? logImages, int? logBuffer, int? logShared, bool? scoreDisplay})
```

Creates an evaluation configuration.

#### `EvalConfig.fromJson`

```dart
EvalConfig.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalDataset`

**Mixins:** `_$EvalDataset`

Dataset used for evaluation.

### Constructors

#### `EvalDataset`

```dart
EvalDataset({String? name, String? location, required int samples, List<Object>? sampleIds, bool shuffled})
```

Creates an evaluation dataset.

#### `EvalDataset.fromJson`

```dart
EvalDataset.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalError`

**Mixins:** `_$EvalError`

Eval error details.

### Constructors

#### `EvalError`

```dart
EvalError({required String message, required String traceback, required String tracebackAnsi})
```

Creates evaluation error details.

#### `EvalError.fromJson`

```dart
EvalError.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalLog`

**Mixins:** `_$EvalLog`

Evaluation log.

### Constructors

#### `EvalLog`

```dart
EvalLog({int version, String status, required EvalSpec eval, EvalPlan? plan, EvalResults? results, EvalStats? stats, EvalError? error, bool invalidated, List<EvalSample>? samples, List<EvalSampleReductions>? reductions, String? location, String? etag, EvalSetInfo? evalSetInfo})
```

Creates an evaluation log.

#### `EvalLog.fromJson`

```dart
EvalLog.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalMetric`

**Mixins:** `_$EvalMetric`

Metric for evaluation score.

### Constructors

#### `EvalMetric`

```dart
EvalMetric({required String name, required Object value, Map<String, dynamic> params, Map<String, dynamic>? metadata})
```

Creates an evaluation metric.

#### `EvalMetric.fromJson`

```dart
EvalMetric.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalPlan`

**Mixins:** `_$EvalPlan`

Plan (solvers) used in evaluation.

### Constructors

#### `EvalPlan`

```dart
EvalPlan({String name, List<EvalPlanStep> steps, EvalPlanStep? finish, GenerateConfig config})
```

Creates an evaluation plan.

#### `EvalPlan.fromJson`

```dart
EvalPlan.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalPlanStep`

**Mixins:** `_$EvalPlanStep`

Solver step.

### Constructors

#### `EvalPlanStep`

```dart
EvalPlanStep({required String solver, Map<String, dynamic> params, Map<String, dynamic>? paramsPassed})
```

Creates an evaluation plan step.

#### `EvalPlanStep.fromJson`

```dart
EvalPlanStep.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalResults`

**Mixins:** `_$EvalResults`

Scoring results from evaluation.

### Constructors

#### `EvalResults`

```dart
EvalResults({int totalSamples, int completedSamples, EarlyStoppingSummary? earlyStopping, List<EvalScore> scores, Map<String, dynamic> metadata, List<EvalSampleReductions>? sampleReductions})
```

Creates evaluation results.

#### `EvalResults.fromJson`

```dart
EvalResults.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalRevision`

**Mixins:** `_$EvalRevision`

Git revision for evaluation.

### Constructors

#### `EvalRevision`

```dart
EvalRevision({required String type, required String origin, required String commit, bool dirty})
```

Creates an evaluation revision.

#### `EvalRevision.fromJson`

```dart
EvalRevision.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalSample`

**Mixins:** `_$EvalSample`

Sample from evaluation task.

### Constructors

#### `EvalSample`

```dart
EvalSample({required Object id, required int epoch, required Object input, List<String>? choices, Object? target, Map<String, dynamic> metadata, Object? sandbox, List<String>? files, String? setup, List<ChatMessage> messages, required ModelOutput output, Map<String, Score>? scores, Map<String, dynamic> store, List<Object> events, Map<String, ModelUsage> modelUsage, String? startedAt, String? completedAt, double? totalTime, double? workingTime, String? uuid, ProvenanceData? invalidation, EvalError? error, List<EvalError>? errorRetries, Map<String, String> attachments, EvalSampleLimit? limit})
```

Creates an evaluation sample.

#### `EvalSample.fromJson`

```dart
EvalSample.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalSampleLimit`

**Mixins:** `_$EvalSampleLimit`

Limit encountered by sample.

### Constructors

#### `EvalSampleLimit`

```dart
EvalSampleLimit({required String type, required double limit})
```

Creates an evaluation sample limit.

#### `EvalSampleLimit.fromJson`

```dart
EvalSampleLimit.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalSampleReductions`

**Mixins:** `_$EvalSampleReductions`

Score reductions.

### Constructors

#### `EvalSampleReductions`

```dart
EvalSampleReductions({required String scorer, String? reducer, required List<EvalSampleScore> samples})
```

Creates evaluation sample reductions.

#### `EvalSampleReductions.fromJson`

```dart
EvalSampleReductions.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalSampleScore`

**Mixins:** `_$EvalSampleScore`

Score and sample_id scored.

### Constructors

#### `EvalSampleScore`

```dart
EvalSampleScore({required Object value, String? answer, String? explanation, Map<String, dynamic> metadata, List<Object> history, Object? sampleId})
```

Creates an evaluation sample score.

#### `EvalSampleScore.fromJson`

```dart
EvalSampleScore.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalScore`

**Mixins:** `_$EvalScore`

Score for evaluation task.

### Constructors

#### `EvalScore`

```dart
EvalScore({required String name, required String scorer, String? reducer, int? scoredSamples, int? unscoredSamples, Map<String, dynamic> params, List<EvalMetric> metrics, Map<String, dynamic>? metadata})
```

Creates an evaluation score.

#### `EvalScore.fromJson`

```dart
EvalScore.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalSet`

**Mixins:** `_$EvalSet`

Dart representation of Inspect AI's `eval_set()` function parameters.

Models the configuration passed to
[`inspect_ai.eval_set()`](https://inspect.aisi.org.uk/reference/inspect_ai.html#eval_set).

This is the **Inspect AI** side of the eval set contract — it mirrors the
Python function signature. For the Dart-side resolved config that is
serialised *to* the Python runner, see `config/eval_set.dart`.

### Constructors

#### `EvalSet`

```dart
EvalSet({required List<Task> tasks, required String logDir, int? retryAttempts, double? retryWait, double? retryConnections, bool? retryCleanup, List<String>? model, String? modelBaseUrl, Map<String, Object?> modelArgs, Map<String, String>? modelRoles, Map<String, Object?> taskArgs, Object? sandbox, bool? sandboxCleanup, Object? solver, List<String>? tags, Map<String, dynamic>? metadata, bool? trace, String? display, Object? approval, bool score, String? logLevel, String? logLevelTranscript, String? logFormat, Object? limit, Object? sampleId, Object? sampleShuffle, Object? epochs, double? failOnError, bool? continueOnFail, int? retryOnError, bool? debugErrors, int? messageLimit, int? tokenLimit, int? timeLimit, int? workingLimit, double? costLimit, Map<String, Object?>? modelCostConfig, int? maxSamples, int? maxTasks, int? maxSubprocesses, int? maxSandboxes, bool? logSamples, bool? logRealtime, bool? logImages, int? logBuffer, int? logShared, String? bundleDir, bool bundleOverwrite, bool? logDirAllowDirty, String? evalSetId})
```

#### `EvalSet.fromJson`

```dart
EvalSet.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalSetInfo`

**Mixins:** `_$EvalSetInfo`

Eval set information.

### Constructors

#### `EvalSetInfo`

```dart
EvalSetInfo({required String evalSetId, required List<EvalSetTask> tasks})
```

Creates evaluation set information.

#### `EvalSetInfo.fromJson`

```dart
EvalSetInfo.fromJson(Map<String, dynamic> json)
```

---

## class `EvalSetResolver`

Resolves parsed task configs and job into fully-resolved
[EvalSet] objects ready for JSON serialization.

This is the resolution engine. It:
1. Resolves models, sandboxes, and variants
2. Expands task × variant combinations into [Task] entries
3. Propagates job-level and task-level settings to the output

### Constructors

#### `EvalSetResolver`

```dart
EvalSetResolver({Map<String, Map<String, String>> sandboxRegistry})
```

Creates a resolver with optional sandbox configuration.

If [sandboxRegistry] is not provided, it defaults to an empty map
(no sandbox resolution). Pass [kDefaultSandboxRegistry] for the
Flutter-specific sandbox setup.

### Properties

- **`sandboxRegistry`** → `Map<String, Map<String, String>>` *(final)*

  Named sandbox configurations (e.g. `'podman'` → compose file path).

### Methods

#### `resolve`

```dart
List<EvalSet> resolve(List<ParsedTask> datasetTasks, Job job, String datasetRoot)
```

Resolve task configs and job into [EvalSet] objects.

**Parameters:**

- `datasetTasks` (`List<ParsedTask>`) *(required)*
- `job` (`Job`) *(required)*
- `datasetRoot` (`String`) *(required)*

---

## abstract class `EvalSetTask`

**Mixins:** `_$EvalSetTask`

Task in an eval set.

### Constructors

#### `EvalSetTask`

```dart
EvalSetTask({String? name, required String taskId, String? taskFile, Map<String, dynamic> taskArgs, required String model, Map<String, dynamic> modelArgs, Map<String, String>? modelRoles, required int sequence})
```

Creates an evaluation set task.

#### `EvalSetTask.fromJson`

```dart
EvalSetTask.fromJson(Map<String, dynamic> json)
```

---

## class `EvalSetWriter`

Writes resolved [EvalSet] configs as a single JSON file.

The output JSON maps ~1:1 to `eval_set()` kwargs. Datasets are inlined
in each task — no separate JSONL files needed.

### Constructors

#### `EvalSetWriter`

```dart
EvalSetWriter()
```

### Methods

#### `write`

```dart
String write(List<EvalSet> configs, String outputDir)
```

Write [EvalSet] JSON for the given resolved configs.

Files are written to [outputDir]. Returns the path to the JSON file.

**Parameters:**

- `configs` (`List<EvalSet>`) *(required)*
- `outputDir` (`String`) *(required)*

---

## abstract class `EvalSpec`

**Mixins:** `_$EvalSpec`

Eval target and configuration.

### Constructors

#### `EvalSpec`

```dart
EvalSpec({String? evalSetId, required String evalId, required String runId, required String created, required String task, required String taskId, Object taskVersion, String? taskFile, String? taskDisplayName, String? taskRegistryName, Map<String, dynamic> taskAttribs, Map<String, dynamic> taskArgs, Map<String, dynamic> taskArgsPassed, String? solver, Map<String, dynamic> solverArgs, Map<String, dynamic> solverArgsPassed, List<String> tags, EvalDataset? dataset, Object? sandbox, required String model, GenerateConfig? modelGenerateConfig, String? modelBaseUrl, Map<String, dynamic> modelArgs, Map<String, String>? modelRoles, EvalConfig config, EvalRevision? revision, Map<String, String> packages, Map<String, dynamic>? metadata, List<Object> scorers, List<Object> metrics})
```

Creates an evaluation specification.

#### `EvalSpec.fromJson`

```dart
EvalSpec.fromJson(Map<String, dynamic> json)
```

---

## abstract class `EvalStats`

**Mixins:** `_$EvalStats`

Timing and usage statistics.

### Constructors

#### `EvalStats`

```dart
EvalStats({required String startedAt, required String completedAt, Map<String, ModelUsage> modelUsage})
```

Creates evaluation statistics.

#### `EvalStats.fromJson`

```dart
EvalStats.fromJson(Map<String, dynamic> json)
```

---

## abstract class `FieldSpec`

**Mixins:** `_$FieldSpec`

Dart representation of Inspect AI's `FieldSpec` dataclass.

Specification for mapping data source fields to sample fields.

See [`FieldSpec`](https://inspect.aisi.org.uk/reference/inspect_ai.dataset.html#fieldspec).

### Constructors

#### `FieldSpec`

```dart
FieldSpec({String? input, String? target, String? choices, String? id, List<String>? metadata, String? sandbox, String? files, String? setup})
```

#### `FieldSpec.fromJson`

```dart
FieldSpec.fromJson(Map<String, dynamic> json)
```

---

## abstract class `GenerateConfig`

**Mixins:** `_$GenerateConfig`

Model generation options.

### Constructors

#### `GenerateConfig`

```dart
GenerateConfig({int? maxRetries, int? timeout, int? attemptTimeout, int? maxConnections, String? systemMessage, int? maxTokens, double? topP, double? temperature, List<String>? stopSeqs, int? bestOf, double? frequencyPenalty, double? presencePenalty, Map<String, double>? logitBias, int? seed, int? topK, int? numChoices, bool? logprobs, int? topLogprobs, bool? parallelToolCalls, bool? internalTools, int? maxToolOutput, Object? cachePrompt})
```

Creates model generation options.

#### `GenerateConfig.fromJson`

```dart
GenerateConfig.fromJson(Map<String, dynamic> json)
```

---

## abstract class `Job`

**Mixins:** `_$Job`

A job configuration defining what to run and how to run it.

Jobs combine runtime settings (log directory, sandbox type, rate limits)
with filtering (which models, variants, and tasks to include).

Top-level fields cover the most common settings. For full control over
`eval_set()` and `Task` parameters, use [evalSetOverrides] and
[taskDefaults] respectively — any valid `eval_set()` / `Task` kwarg can
be specified there and will be passed through to the Python runner.

Example YAML:
```yaml
log_dir: ./logs/my_run
sandbox:
  environment: podman
max_connections: 10
models:
  - google/gemini-2.5-flash
variants:
  baseline: {}
  context_only:
    files: [./context_files/flutter.md]
tasks:
  dart_qa:
    include-samples: [sample_1]

# All Inspect AI eval_set() parameters
inspect_eval_arguments:
  retry_attempts: 20
  log_level: debug
  task_defaults:
    time_limit: 600
```

### Constructors

#### `Job`

```dart
Job({String? description, required String logDir, int maxConnections, List<String>? models, Map<String, Map<String, dynamic>>? variants, List<String>? taskPaths, Map<String, JobTask>? tasks, bool saveExamples, Map<String, dynamic>? sandbox, Map<String, dynamic>? inspectEvalArguments, TagFilter? taskFilters, TagFilter? sampleFilters})
```

#### `Job.fromJson`

```dart
Job.fromJson(Map<String, dynamic> json)
```

---

## abstract class `JobTask`

**Mixins:** `_$JobTask`

Per-task configuration within a job.

Allows overriding which samples and variants run for specific tasks.

### Constructors

#### `JobTask`

```dart
JobTask({required String id, List<String>? includeSamples, List<String>? excludeSamples, List<String>? includeVariants, List<String>? excludeVariants, Map<String, dynamic>? args})
```

#### `JobTask.fromJson`

```dart
JobTask.fromJson(Map<String, dynamic> json)
```

#### `JobTask.fromYaml`

```dart
JobTask.fromYaml(String taskId, Map<String, dynamic>? data)
```

Create a [JobTask] from parsed YAML data.

---

## class `JsonParser`

**Extends:** `Parser`

Parses config from pre-parsed `Map<String, dynamic>` data.

Useful for programmatic config construction (web UI, tests)
without touching the filesystem.

### Constructors

#### `JsonParser`

```dart
JsonParser()
```

### Methods

#### `parseTasks`

```dart
List<ParsedTask> parseTasks(String datasetRoot)
```

**Parameters:**

- `datasetRoot` (`String`) *(required)*

#### `parseTasksFromMaps`

```dart
List<ParsedTask> parseTasksFromMaps(List<Map<String, dynamic>> taskMaps)
```

Parse task configs from pre-parsed maps.

Each map should have the same structure as a task.yaml file.

**Parameters:**

- `taskMaps` (`List<Map<String, dynamic>>`) *(required)*

#### `parseJob`

```dart
Job parseJob(String jobPath, String datasetRoot)
```

**Parameters:**

- `jobPath` (`String`) *(required)*
- `datasetRoot` (`String`) *(required)*

#### `parseJobFromMap`

```dart
Job parseJobFromMap(Map<String, dynamic> data)
```

Parse a job from a pre-parsed map.

**Parameters:**

- `data` (`Map<String, dynamic>`) *(required)*

---

## abstract class `Logprobs`

**Mixins:** `_$Logprobs`

Logprobs for chat completion.

### Constructors

#### `Logprobs`

```dart
Logprobs({required List<Object> content})
```

Creates logprobs.

#### `Logprobs.fromJson`

```dart
Logprobs.fromJson(Map<String, dynamic> json)
```

---

## abstract class `ModelOutput`

**Mixins:** `_$ModelOutput`

Model output.

### Constructors

#### `ModelOutput`

```dart
ModelOutput({required String model, List<ChatCompletionChoice> choices, ModelUsage? usage, required String completion, String stopReason, double? time, Map<String, dynamic> metadata, String? error, ChatMessageAssistant? message})
```

Creates model output.

#### `ModelOutput.fromJson`

```dart
ModelOutput.fromJson(Map<String, dynamic> json)
```

---

## abstract class `ModelUsage`

**Mixins:** `_$ModelUsage`

Token usage for completion.

### Constructors

#### `ModelUsage`

```dart
ModelUsage({int inputTokens, int outputTokens, int totalTokens, int? inputTokensCacheWrite, int? inputTokensCacheRead, int reasoningTokens})
```

Creates model usage details.

#### `ModelUsage.fromJson`

```dart
ModelUsage.fromJson(Map<String, dynamic> json)
```

---

## class `ParsedTask`

Lightweight intermediate type used during parsing and resolution.

Groups samples with task-level config (variant, sandbox, etc.) before
the resolver produces the final [Task] objects. This replaces the
former `TaskConfig` model-package class.

### Constructors

#### `ParsedTask`

```dart
ParsedTask({required String id, required String func, required List<Sample> samples, required Variant variant, String sandboxType, String? systemMessage, bool saveExamples, String? examplesDir, Map<String, dynamic>? sandboxParameters, Map<String, String>? taskFiles, String? taskSetup, String? model, Map<String, dynamic>? config, Map<String, String>? modelRoles, Object? sandbox, Object? approval, Object? epochs, Object? failOnError, bool? continueOnFail, int? messageLimit, int? tokenLimit, int? timeLimit, int? workingLimit, double? costLimit, Object? earlyStopping, String? displayName, Object? version, Map<String, dynamic>? metadata})
```

### Properties

- **`id`** → `String` *(final)*

- **`func`** → `String` *(final)*

- **`samples`** → `List<Sample>` *(final)*

- **`variant`** → `Variant` *(final)*

- **`sandboxType`** → `String` *(final)*

- **`systemMessage`** → `String?` *(final)*

- **`saveExamples`** → `bool` *(final)*

- **`examplesDir`** → `String?` *(final)*

- **`sandboxParameters`** → `Map<String, dynamic>?` *(final)*

  Pass-through dict for sandbox plugin configuration.

- **`taskFiles`** → `Map<String, String>?` *(final)*

  Task-level files to copy into sandbox.

- **`taskSetup`** → `String?` *(final)*

  Task-level setup script.

- **`model`** → `String?` *(final)*

  Default model for this task.

- **`config`** → `Map<String, dynamic>?` *(final)*

  Model generation config.

- **`modelRoles`** → `Map<String, String>?` *(final)*

  Named roles for use in `get_model()`.

- **`sandbox`** → `Object?` *(final)*

  Sandbox environment type (or a shorthand spec).

- **`approval`** → `Object?` *(final)*

  Tool use approval policies.

- **`epochs`** → `Object?` *(final)*

  Epochs to repeat samples for.

- **`failOnError`** → `Object?` *(final)*

  Fail on sample errors.

- **`continueOnFail`** → `bool?` *(final)*

  Continue running if the `fail_on_error` condition is met.

- **`messageLimit`** → `int?` *(final)*

  Limit on total messages per sample.

- **`tokenLimit`** → `int?` *(final)*

  Limit on total tokens per sample.

- **`timeLimit`** → `int?` *(final)*

  Limit on clock time (in seconds) per sample.

- **`workingLimit`** → `int?` *(final)*

  Limit on working time (in seconds) per sample.

- **`costLimit`** → `double?` *(final)*

  Limit on total cost (in dollars) per sample.

- **`earlyStopping`** → `Object?` *(final)*

  Early stopping callbacks.

- **`displayName`** → `String?` *(final)*

  Task display name (e.g. for plotting).

- **`version`** → `Object?` *(final)*

  Version of task.

- **`metadata`** → `Map<String, dynamic>?` *(final)*

  Additional metadata to associate with the task.

### Methods

#### `copyWith`

```dart
ParsedTask copyWith({String? id, String? func, List<Sample>? samples, Variant? variant, String? sandboxType, String? systemMessage, bool? saveExamples, String? examplesDir, Map<String, dynamic>? sandboxParameters, Map<String, String>? taskFiles, String? taskSetup, String? model, Map<String, dynamic>? config, Map<String, String>? modelRoles, Object? sandbox, Object? approval, Object? epochs, Object? failOnError, bool? continueOnFail, int? messageLimit, int? tokenLimit, int? timeLimit, int? workingLimit, double? costLimit, Object? earlyStopping, String? displayName, Object? version, Map<String, dynamic>? metadata})
```

Create a copy with overrides.

**Parameters:**

- `id` (`String?`)
- `func` (`String?`)
- `samples` (`List<Sample>?`)
- `variant` (`Variant?`)
- `sandboxType` (`String?`)
- `systemMessage` (`String?`)
- `saveExamples` (`bool?`)
- `examplesDir` (`String?`)
- `sandboxParameters` (`Map<String, dynamic>?`)
- `taskFiles` (`Map<String, String>?`)
- `taskSetup` (`String?`)
- `model` (`String?`)
- `config` (`Map<String, dynamic>?`)
- `modelRoles` (`Map<String, String>?`)
- `sandbox` (`Object?`)
- `approval` (`Object?`)
- `epochs` (`Object?`)
- `failOnError` (`Object?`)
- `continueOnFail` (`bool?`)
- `messageLimit` (`int?`)
- `tokenLimit` (`int?`)
- `timeLimit` (`int?`)
- `workingLimit` (`int?`)
- `costLimit` (`double?`)
- `earlyStopping` (`Object?`)
- `displayName` (`String?`)
- `version` (`Object?`)
- `metadata` (`Map<String, dynamic>?`)

---

## abstract class `Parser`

Abstract base for config parsers.

Parsers are responsible for turning raw configuration data (YAML files,
JSON maps, etc.) into domain model objects ([ParsedTask], [Job]).

Concrete implementations:
- [YamlParser] — reads `.yaml` files from the filesystem
- [JsonParser] — accepts pre-parsed `Map<String, dynamic>` data

### Constructors

#### `Parser`

```dart
Parser()
```

### Methods

#### `parseTasks`

```dart
List<ParsedTask> parseTasks(String datasetRoot)
```

Parse all task configs from a dataset root directory.

The dataset root is expected to contain a `tasks/` subdirectory
with per-task YAML/JSON files.

**Parameters:**

- `datasetRoot` (`String`) *(required)*

#### `parseJob`

```dart
Job parseJob(String jobPath, String datasetRoot)
```

Parse a job config.

[jobPath] identifies the job (file path for YAML, key for JSON).
[datasetRoot] is the dataset root for resolving relative paths.

**Parameters:**

- `jobPath` (`String`) *(required)*
- `datasetRoot` (`String`) *(required)*

---

## abstract class `ProvenanceData`

**Mixins:** `_$ProvenanceData`

Provenance data for invalidation.

### Constructors

#### `ProvenanceData`

```dart
ProvenanceData({required String location, required String shash})
```

Creates provenance data.

#### `ProvenanceData.fromJson`

```dart
ProvenanceData.fromJson(Map<String, dynamic> json)
```

---

## abstract class `Sample`

**Mixins:** `_$Sample`

Dart representation of Inspect AI's `Sample` class.

A sample for an evaluation task.

See [`Sample`](https://inspect.aisi.org.uk/reference/inspect_ai.dataset.html#sample).

### Constructors

#### `Sample`

```dart
Sample({required Object input, List<String>? choices, Object target, Object? id, Map<String, dynamic>? metadata, Object? sandbox, Map<String, String>? files, String? setup})
```

#### `Sample.fromJson`

```dart
Sample.fromJson(Map<String, dynamic> json)
```

---

## abstract class `Score`

**Mixins:** `_$Score`

Score for evaluation.

### Constructors

#### `Score`

```dart
Score({required Object value, String? answer, String? explanation, Map<String, dynamic>? metadata})
```

Creates a score.

#### `Score.fromJson`

```dart
Score.fromJson(Map<String, dynamic> json)
```

---

## abstract class `TagFilter`

**Mixins:** `_$TagFilter`

Tag-based filter for including/excluding items by their tags.

### Constructors

#### `TagFilter`

```dart
TagFilter({List<String>? includeTags, List<String>? excludeTags})
```

#### `TagFilter.fromJson`

```dart
TagFilter.fromJson(Map<String, dynamic> json)
```

---

## abstract class `Task`

**Mixins:** `_$Task`

Dart representation of Inspect AI's `Task` class.

Models the configuration accepted by the
[`Task.__init__`](https://inspect.aisi.org.uk/reference/inspect_ai.html#task)
constructor.

### Constructors

#### `Task`

```dart
Task({Dataset? dataset, Map<String, String>? files, Object? setup, Object? solver, Object? cleanup, Object? scorer, Object? metrics, String? model, Object? config, Map<String, String>? modelRoles, Object? sandbox, Object? approval, Object? epochs, Object? failOnError, bool? continueOnFail, int? messageLimit, int? tokenLimit, int? timeLimit, int? workingLimit, double? costLimit, Object? earlyStopping, String? displayName, String? func, String? systemMessage, Map<String, dynamic>? sandboxParameters, String? name, Object version, Map<String, dynamic>? metadata})
```

#### `Task.fromJson`

```dart
Task.fromJson(Map<String, dynamic> json)
```

---

## abstract class `TaskInfo`

**Mixins:** `_$TaskInfo`

Dart representation of Inspect AI's `TaskInfo` class.

Task information including file path, name, and attributes.

See [`TaskInfo`](https://inspect.aisi.org.uk/reference/inspect_ai.html#taskinfo).

### Constructors

#### `TaskInfo`

```dart
TaskInfo({required String file, required String name, Map<String, dynamic> attribs})
```

#### `TaskInfo.fromJson`

```dart
TaskInfo.fromJson(Map<String, dynamic> json)
```

---

## class `TaskMetadata`

### Constructors

#### `TaskMetadata`

```dart
TaskMetadata(String func, Map<String, Object?> additional)
```

### Properties

- **`func`** → `String` *(final)*

- **`additional`** → `Map<String, Object?>` *(final)*

### Methods

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## abstract class `ToolCall`

**Mixins:** `_$ToolCall`

Tool call details.

### Constructors

#### `ToolCall`

```dart
ToolCall({required String id, required String function, required Map<String, dynamic> arguments, String type})
```

Creates tool call details.

#### `ToolCall.fromJson`

```dart
ToolCall.fromJson(Map<String, dynamic> json)
```

---

## abstract class `ToolCallError`

**Mixins:** `_$ToolCallError`

Tool call error.

### Constructors

#### `ToolCallError`

```dart
ToolCallError({required String message, int? code, Map<String, dynamic>? data})
```

Creates a tool call error.

#### `ToolCallError.fromJson`

```dart
ToolCallError.fromJson(Map<String, dynamic> json)
```

---

## abstract class `Variant`

**Mixins:** `_$Variant`

A configuration variant for running evaluations.

Variants define different testing configurations to compare model
performance with and without specific tooling or context.

Features are implied by field presence — no explicit feature list needed:
- [files] populated → context injection enabled
- [mcpServers] populated → MCP tools enabled
- [skills] populated → agent skills enabled
- [taskParameters] populated → extra parameters passed to the task
- all empty → baseline variant

Example YAML:
```yaml
variants:
  baseline: {}
  context_only:
    files: [./context_files/flutter.md]
  full:
    files: [./context_files/flutter.md]
    mcp_servers:
      - name: dart
        command: dart
        args: [mcp-server]
    skills: [./skills/flutter_docs_ui]
```

### Constructors

#### `Variant`

```dart
Variant({String name, List<ContextFile> files, List<Map<String, dynamic>> mcpServers, List<String> skills, Map<String, dynamic> taskParameters})
```

#### `Variant.fromJson`

```dart
Variant.fromJson(Map<String, dynamic> json)
```

### Properties

- **`label`** → `String`

---

## class `YamlParser`

**Extends:** `Parser`

Parses YAML config files from the filesystem into domain objects.

Reads `tasks/*/task.yaml` files for task configs and job YAML files
for job configs.

### Constructors

#### `YamlParser`

```dart
YamlParser()
```

### Methods

#### `parseTasks`

```dart
List<ParsedTask> parseTasks(String datasetRoot)
```

**Parameters:**

- `datasetRoot` (`String`) *(required)*

#### `parseJob`

```dart
Job parseJob(String jobPath, String datasetRoot)
```

**Parameters:**

- `jobPath` (`String`) *(required)*
- `datasetRoot` (`String`) *(required)*

#### `createDefaultJob`

```dart
Job createDefaultJob(String baseDir)
```

Create a [Job] with default settings (when no job file is provided).

**Parameters:**

- `baseDir` (`String`) *(required)*

---

## `convertYamlToObject`

```dart
dynamic convertYamlToObject(dynamic yaml)
```

Converts a YamlMap or YamlList to standard Dart Map/List.

**Parameters:**

- `yaml` (`dynamic`) *(required)*

---

## `findJobFile`

```dart
String findJobFile(String datasetRoot, String job)
```

Find a job file by name or path.

Looks in `jobs/` directory first, then treats [job] as a relative/absolute
path.

Throws [FileSystemException] if the job file is not found.

**Parameters:**

- `datasetRoot` (`String`) *(required)*
- `job` (`String`) *(required)*

---

## `matchesTagFilter`

```dart
bool matchesTagFilter(List<String> itemTags, TagFilter filter)
```

Check whether a set of [itemTags] matches the given [filter].

Returns `true` if:
- All include_tags (if any) are present in [itemTags]
- No exclude_tags (if any) are present in [itemTags]

**Parameters:**

- `itemTags` (`List<String>`) *(required)*
- `filter` (`TagFilter`) *(required)*

---

## `readYamlFile`

```dart
YamlNode readYamlFile(String filePath)
```

Reads a YAML file and returns the parsed content.
Returns the raw YamlMap/YamlList for flexibility.

**Parameters:**

- `filePath` (`String`) *(required)*

---

## `readYamlFileAsMap`

```dart
Map<String, dynamic> readYamlFileAsMap(String filePath)
```

Reads a YAML file and converts it to a standard Dart Map.

**Parameters:**

- `filePath` (`String`) *(required)*

