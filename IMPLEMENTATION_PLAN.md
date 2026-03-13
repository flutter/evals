# Config Improvements — Implementation Plan

This document details the implementation steps for all decided config improvements. Each section includes the specific files to modify in both Dart and Python packages, what to change, and relevant context.

> **Branch:** `yardstick-config-updates`
> **Related docs:** `CHANGELOG.md`, `docs/reference/yaml_config.md`
> **Design analysis:** The original design doc (`config_improvements.md`) has been deleted. The finalized decisions are captured in `CHANGELOG.md`.

---

## Table of Contents

1. [Model Changes](#1-model-changes)
2. [Parser/Resolver Changes](#2-parserresolver-changes)
3. [Tag-Based Filtering](#3-tag-based-filtering)
4. [File Index](#4-file-index)
5. [Verification](#5-verification)

---

## 1. Model Changes

### 1.1 Add `description` to Job

Simple optional string field.

**Dart** — `packages/dataset_config_dart/lib/src/models/job.dart`
```dart
String? description,  // Add to Job freezed class
```

**Python** — `packages/dataset_config_python/src/dataset_config_python/models/job.py`
```python
description: str | None = None
```

**Parser** — `packages/dataset_config_dart/lib/src/parsers/yaml_parser.dart`
```dart
final description = data['description'] as String?;
// Pass to Job constructor
```

---

### 1.2 Add `image_prefix` to Job

Registry URL prefix prepended to image names during sandbox resolution (e.g. `us-central1-docker.pkg.dev/project/repo/`).

**Dart** — `packages/dataset_config_dart/lib/src/models/job.dart`
```dart
String? imagePrefix,
```

**Python** — `packages/dataset_config_python/src/dataset_config_python/models/job.py`
```python
image_prefix: str | None = None
```

**Parser** — read `image_prefix` from YAML, pass to Job.

**Resolver** — `packages/dataset_config_dart/lib/src/resolvers/eval_set_resolver.dart`
- In `_resolveSandbox()`, prepend `job.imagePrefix` to image names when constructing sandbox specs.

---

### 1.3 Add `args` to JobTask

Per-task argument overrides passed to the task function.

**Dart** — `packages/dataset_config_dart/lib/src/models/job.dart` (on `JobTask` class)
```dart
@JsonKey(name: 'args') Map<String, dynamic>? args,
```

**Python** — `packages/dataset_config_python/src/dataset_config_python/models/job.py` (on `JobTask` class)
```python
args: dict[str, Any] | None = None
```

**Parser** — In `JobTask.fromYaml()` (both Dart and Python), read `args` from the per-task map.

---

### 1.4 Add `system_message` to Task model

Currently exists on `ParsedTask` but not the output `Task` model. Promote it.

**Dart** — `packages/dataset_config_dart/lib/src/models/task.dart`
```dart
@JsonKey(name: 'system_message') String? systemMessage,
```

**Python** — `packages/dataset_config_python/src/dataset_config_python/models/task.py`
```python
system_message: str | None = None
```

**Resolver** — `eval_set_resolver.dart` already puts `system_message` into Task metadata. After this change, set it as a first-class field on the Task object instead.

---

### 1.5 Add `sandbox_parameters` to Task

Pass-through dict for sandbox plugin configuration.

**Dart** — `packages/dataset_config_dart/lib/src/models/task.dart`
```dart
@JsonKey(name: 'sandbox_parameters') Map<String, dynamic>? sandboxParameters,
```

**Python** — `packages/dataset_config_python/src/dataset_config_python/models/task.py`
```python
sandbox_parameters: dict[str, Any] | None = None
```

**Parser** — read `sandbox_parameters` from task.yaml.

---

### 1.6 Rename `task_func` → `func`

The YAML parser already aliases `func` → `task_func`. This renames the model field to match.

**Dart** — `packages/dataset_config_dart/lib/src/models/task.dart`
- Rename `taskFunc` → `func`
- Update `@JsonKey(name: 'task_func')` → `@JsonKey(name: 'func')`
- Regenerate `.freezed.dart` / `.g.dart`

**Python** — `packages/dataset_config_python/src/dataset_config_python/models/task.py`
- Rename `task_func` → `func`

**Other files to update:**
- `packages/dataset_config_dart/lib/src/parsed_task.dart` — `taskFunc` field and `copyWith`
- `packages/dataset_config_dart/lib/src/parsers/yaml_parser.dart` — variable names referencing `taskFunc`
- `packages/dataset_config_dart/lib/src/resolvers/eval_set_resolver.dart` — `tc.taskFunc`
- `packages/devals_cli/lib/src/dataset/dry_run.dart` — references `task_func`
- `packages/dash_evals/src/dash_evals/runner/json_runner.py` — `task_def.get("task_func")`
- `packages/dataset_config_python/tests/test_config.py` — Task construction with `task_func=`
- `tool/config_parity/` — both `resolve_dart.dart` and `resolve_python.py`

---

## 2. Parser/Resolver Changes

### 2.1 Support `module:task` syntax

Task function references can use `module.path:function_name` format.

**Python** — `packages/dash_evals/src/dash_evals/runner/json_runner.py`
- Update `_resolve_task_func()` to split on `:` and import the module, then get the function by attribute name.

**Dart parser** — `yaml_parser.dart` L53 already reads `func` as a string. No Dart change needed — the module resolution happens in the Python runner.

---

### 2.2 Make sandbox registry configurable

The hardcoded `kSandboxRegistry` and `kSdkChannels` in `eval_set_resolver.dart` (lines 25-42) need to become data-driven.

**Approach:**
1. Move `kSandboxRegistry` and `kSdkChannels` out of the resolver
2. Add an optional `sandbox_registry` parameter to `EvalSetResolver.resolve()`, or make it a field on the resolver
3. The consuming project (dash_evals CLI) passes its sandbox registry when calling the resolver
4. Default to an empty registry if none provided (no sandbox resolution)

**Files:**
- `packages/dataset_config_dart/lib/src/resolvers/eval_set_resolver.dart` — extract constants, add parameter
- `packages/devals_cli/` — pass the Flutter-specific registry when calling the resolver
- Python resolver (`packages/dataset_config_python/src/dataset_config_python/resolver.py`) — mirror the same approach

---

### 2.3 Workspace: use native Inspect fields

The `workspace` YAML key stays as parser sugar but resolves into Inspect's native `Sample.files` and `Sample.setup`.

**Current behavior** (`eval_set_resolver.dart` L132-141):
```dart
if (workspace != null && isContainer) {
  files = {...?files, '/workspace': workspace};
  setup = setup ?? 'cd /workspace && flutter pub get';
  enriched['workspace'] = '/workspace';
}
```

**Change:**
- Make the auto-generated `setup` command configurable. Options:
  - Add a `workspace_setup` field to Task YAML (e.g. `workspace_setup: "cd /workspace && npm install"`)
  - Or: only auto-generate setup for tasks that have a Flutter-specific tag/metadata
  - Or: remove auto-generation entirely; require the task author to specify `setup` if needed
- The resolver should still map `workspace` → `Sample.files['/workspace']`, but not assume Flutter.

**Files:**
- `packages/dataset_config_dart/lib/src/resolvers/eval_set_resolver.dart` — update workspace → files mapping
- `packages/dataset_config_python/src/dataset_config_python/resolver.py` — mirror

---

## 3. Tag-Based Filtering

### 3.1 New `TagFilter` model

**Dart** — new file `packages/dataset_config_dart/lib/src/models/tag_filter.dart`
```dart
@freezed
sealed class TagFilter with _$TagFilter {
  const factory TagFilter({
    @JsonKey(name: 'include_tags') List<String>? includeTags,
    @JsonKey(name: 'exclude_tags') List<String>? excludeTags,
  }) = _TagFilter;

  factory TagFilter.fromJson(Map<String, dynamic> json) =>
      _$TagFilterFromJson(json);
}
```

**Python** — new file or add to `packages/dataset_config_python/src/dataset_config_python/models/tag_filter.py`
```python
class TagFilter(BaseModel):
    include_tags: list[str] | None = None
    exclude_tags: list[str] | None = None
```

**Shared matching function** (add to both languages):
```python
def matches_filter(item_tags: list[str], filter: TagFilter) -> bool:
    if filter.include_tags and not all(t in item_tags for t in filter.include_tags):
        return False
    if filter.exclude_tags and any(t in item_tags for t in filter.exclude_tags):
        return False
    return True
```

### 3.2 Add filters to Job and Task

**Job model:**
- `taskFilters: TagFilter?` / `task_filters: TagFilter | None`
- `sampleFilters: TagFilter?` / `sample_filters: TagFilter | None`

**Task YAML (parser-level, not model):**
- `variant_filters: TagFilter?` — parsed from task.yaml, stored on `ParsedTask`

### 3.3 Apply filters in resolver

In `_expandTaskConfigs()` (`eval_set_resolver.dart` L418-493), add filtering steps:

1. **Task filtering** (after L431): if `job.taskFilters` is set, check `taskConfig.metadata['tags']` against the filter
2. **Sample filtering** (after L460): if `job.sampleFilters` is set, filter samples by `sample.metadata['tags']`
3. **Variant filtering** (after L440): if `taskConfig.variantFilters` is set, check variant metadata tags

These run alongside (not replacing) the existing ID-based filters.

---

## 4. File Index

All files that need modification, grouped by package:

### `dataset_config_dart`
| File | Changes |
|---|---|
| `lib/src/models/job.dart` | Add `description`, `imagePrefix`, `taskFilters`, `sampleFilters` |
| `lib/src/models/job.dart` (JobTask) | Add `args` |
| `lib/src/models/task.dart` | Rename `taskFunc` → `func`, add `systemMessage`, `sandboxParameters` |
| `lib/src/models/tag_filter.dart` | **New file** — `TagFilter` model |
| `lib/src/models/models.dart` | Export `tag_filter.dart` |
| `lib/src/parsed_task.dart` | Rename `taskFunc` → `func`, add `variantFilters` |
| `lib/src/parsers/yaml_parser.dart` | Read new fields from YAML |
| `lib/src/resolvers/eval_set_resolver.dart` | Configurable sandbox registry, tag filtering, workspace setup |
| `test/` | Update tests for renamed fields and new features |

### `dataset_config_python`
| File | Changes |
|---|---|
| `models/job.py` | Add `description`, `image_prefix`, `task_filters`, `sample_filters` |
| `models/job.py` (JobTask) | Add `args` |
| `models/task.py` | Rename `task_func` → `func`, add `system_message`, `sandbox_parameters` |
| `models/tag_filter.py` | **New file** — `TagFilter` model |
| `models/__init__.py` | Export `TagFilter` |
| `parser.py` | Read new fields from YAML |
| `resolver.py` | Configurable sandbox registry, tag filtering, workspace setup |
| `tests/test_config.py` | Update tests |

### `dash_evals` (Python runner)
| File | Changes |
|---|---|
| `runner/json_runner.py` | `task_func` → `func`, `module:task` syntax support |

### `devals_cli` (Dart CLI)
| File | Changes |
|---|---|
| `lib/src/dataset/dry_run.dart` | `task_func` → `func` references |

### Other
| File | Changes |
|---|---|
| `tool/config_parity/` | Update both resolve scripts for renamed fields |
| `docs/reference/yaml_config.md` | Already updated |
| `CHANGELOG.md` | Already updated |
| `docs/guides/config.md` | Update after implementation |

---

## 5. Verification

### Automated
- Run `dart test` in `dataset_config_dart`
- Run `pytest` in `dataset_config_python`
- Run `tool/config_parity` to verify Dart/Python output parity
- Run `dart analyze` across workspace

### Manual
- Verify `make html` in `docs/` builds without new errors
- Verify a sample job YAML with the new fields parses correctly
- Verify tag filtering produces expected task/sample subsets
