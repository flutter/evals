# dataset_config_dart

Dart library for resolving eval dataset YAML into EvalSet JSON for the Python runner. Also contains the shared data models (e.g., `EvalSet`, `Task`, `Sample`, `Variant`, `Job`) used across the eval pipeline. Python equivalents of these models live in `dash_evals_config`. Located in `packages/dataset_config_dart/`.

---

## Architecture

The package follows a layered pipeline design:

```
YAML / JSON files
    │
    ▼
┌──────────┐
│  Parser  │  YamlParser · JsonParser
└────┬─────┘
     │  => List<ParsedTask>, Job
     ▼
┌──────────┐
│ Resolver │  EvalSetResolver
└────┬─────┘
     │  => List<EvalSet>
     ▼
┌──────────┐
│  Writer  │  EvalSetWriter
└────┬─────┘
     │  => JSON file(s) on disk
     ▼
  Python dash_evals
```

The JSON files written to disk conform to the InspectAI API for `eval_set`, which is an 
entry point from which to start running evals.


| Layer | Class | Responsibility |
|-------|-------|----------------|
| **Parsers** | `YamlParser`, `JsonParser` | Read task YAML and job files into `ParsedTask` and `Job` objects |
| **Resolvers** | `EvalSetResolver` | Combine parsed tasks with a job to produce fully resolved `EvalSet` objects (expanding models, variants, sandbox config, etc.) |
| **Writers** | `EvalSetWriter` | Serialize `EvalSet` objects to JSON files that the Python runner can consume |
| **Facade** | `ConfigResolver` | Single-call convenience that composes Parser → Resolver |

---

## Quick Start

```dart
import 'package:dataset_config_dart/dataset_config_dart.dart';

// Single-call convenience
final resolver = ConfigResolver();
final configs = resolver.resolve(datasetPath, ['my_job']);

// Or use the layers individually
final parser = YamlParser();
final tasks = parser.parseTasks(datasetPath);
final job = parser.parseJob(jobPath, datasetPath);

final evalSetResolver = EvalSetResolver();
final evalSets = evalSetResolver.resolve(tasks, job, datasetPath);

final writer = EvalSetWriter();
writer.write(evalSets, outputDir);
```

---

## Data Models

This package also contains the shared Dart data models used across the eval pipeline. All models are built with [Freezed](https://pub.dev/packages/freezed) for immutability, pattern matching, and JSON serialization via [json_serializable](https://pub.dev/packages/json_serializable).

> [!NOTE]
> Python equivalents of these models live in the `dash_evals_config` package.

### Config Models

| Model | Description |
|-------|-------------|
| `Job` | A job configuration — runtime settings, model/variant/task selection, and `eval_set()` overrides |
| `JobTask` | Per-task overrides within a job (sample filtering, custom system messages) |
| `Variant` | A named configuration variant (e.g. `baseline`, `with_docs`) applied to task runs |
| `ContextFile` | A file to inject into the sandbox as additional context for the model |

### Inspect AI Models

Mirror the Python [Inspect AI](https://inspect.aisi.org.uk/) types so that Dart can produce JSON the Python runner understands directly.

| Model | Description |
|-------|-------------|
| `EvalSet` | Maps to `inspect_ai.eval_set()` parameters — the top-level run definition |
| `Task` | A single evaluation task with its solver, scorer, dataset, and sandbox config |
| `TaskInfo` | Lightweight task metadata (name and function reference) |
| `Sample` | An individual evaluation sample (input, target, metadata) |
| `Dataset` | A dataset definition (samples file path and field mappings) |
| `FieldSpec` | Maps dataset columns to sample fields |
| `EvalLog` | Comprehensive log structure for evaluation results |

---

## Source Layout

```
lib/
├── dataset_config_dart.dart         # Library barrel file
└── src/
    ├── config_resolver.dart # Convenience facade
    ├── parsed_task.dart     # Intermediate parsed-task model
    ├── parsers/
    │   ├── parser.dart      # Abstract parser interface
    │   ├── yaml_parser.dart # YAML file parser
    │   └── json_parser.dart # JSON map parser
    ├── resolvers/
    │   └── eval_set_resolver.dart
    ├── writers/
    │   └── eval_set_writer.dart
    ├── runner_config_exception.dart
    └── utils/
        └── yaml_utils.dart
```

---

## Testing

```bash
cd packages/dataset_config_dart
dart test
```
