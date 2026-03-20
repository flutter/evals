"""YAML parser — reads job, task, and sample YAML files from the filesystem."""

from __future__ import annotations

import glob as globmod
import os
import re
from datetime import datetime, timezone
from typing import Any

import yaml

from dataset_config_python.models.job import Job, JobTask
from dataset_config_python.models.sample import Sample
from dataset_config_python.models.variant import Variant

# Default log directory (relative to dataset root).
_DEFAULT_LOGS_DIR = "../logs"


class ParsedTask:
    """Lightweight intermediate type used during parsing and resolution.

    Groups samples with task-level config before the resolver produces
    the final Task objects.
    """

    def __init__(
        self,
        *,
        id: str,
        func: str,
        samples: list[Sample],
        variant: Variant | None = None,
        sandbox_type: str = "local",
        system_message: str | None = None,
        save_examples: bool = False,
        examples_dir: str | None = None,
        # Task-level settings
        model: str | None = None,
        config: dict[str, Any] | None = None,
        model_roles: dict[str, str] | None = None,
        sandbox: Any | None = None,
        approval: Any | None = None,
        epochs: Any | None = None,
        fail_on_error: Any | None = None,
        continue_on_fail: bool | None = None,
        message_limit: int | None = None,
        token_limit: int | None = None,
        time_limit: int | None = None,
        working_limit: int | None = None,
        cost_limit: float | None = None,
        early_stopping: Any | None = None,
        display_name: str | None = None,
        version: Any | None = None,
        metadata: dict[str, Any] | None = None,
        sandbox_parameters: dict[str, Any] | None = None,
        # Task-level files and setup
        task_files: dict[str, str] | None = None,
        task_setup: str | None = None,
        # Dataset format metadata
        dataset_format: str = "memory",
        dataset_source: str | None = None,
        dataset_args: dict[str, Any] | None = None,
    ):
        self.id = id
        self.func = func
        self.samples = samples
        self.variant = variant or Variant()
        self.sandbox_type = sandbox_type
        self.system_message = system_message
        self.save_examples = save_examples
        self.examples_dir = examples_dir
        self.model = model
        self.config = config
        self.model_roles = model_roles
        self.sandbox = sandbox
        self.approval = approval
        self.epochs = epochs
        self.fail_on_error = fail_on_error
        self.continue_on_fail = continue_on_fail
        self.message_limit = message_limit
        self.token_limit = token_limit
        self.time_limit = time_limit
        self.working_limit = working_limit
        self.cost_limit = cost_limit
        self.early_stopping = early_stopping
        self.display_name = display_name
        self.version = version
        self.metadata = metadata
        self.sandbox_parameters = sandbox_parameters
        self.task_files = task_files
        self.task_setup = task_setup
        self.dataset_format = dataset_format
        self.dataset_source = dataset_source
        self.dataset_args = dataset_args

    _UNSET: Any = object()

    def copy_with(
        self,
        *,
        id: str | None = _UNSET,
        func: str | None = _UNSET,
        samples: list[Sample] | None = _UNSET,
        variant: Variant | None = _UNSET,
        sandbox_type: str | None = _UNSET,
        system_message: str | None = _UNSET,
        save_examples: bool | None = _UNSET,
        examples_dir: str | None = _UNSET,
        sandbox_parameters: dict[str, Any] | None = _UNSET,
        task_files: dict[str, str] | None = _UNSET,
        task_setup: str | None = _UNSET,
        model: str | None = _UNSET,
        config: dict[str, Any] | None = _UNSET,
        model_roles: dict[str, str] | None = _UNSET,
        sandbox: Any = _UNSET,
        approval: Any = _UNSET,
        epochs: Any = _UNSET,
        fail_on_error: Any = _UNSET,
        continue_on_fail: bool | None = _UNSET,
        message_limit: int | None = _UNSET,
        token_limit: int | None = _UNSET,
        time_limit: int | None = _UNSET,
        working_limit: int | None = _UNSET,
        cost_limit: float | None = _UNSET,
        early_stopping: Any = _UNSET,
        display_name: str | None = _UNSET,
        version: Any = _UNSET,
        metadata: dict[str, Any] | None = _UNSET,
    ) -> ParsedTask:
        """Create a copy with overrides."""
        _U = ParsedTask._UNSET
        return ParsedTask(
            id=self.id if id is _U else id,  # type: ignore[arg-type]
            func=self.func if func is _U else func,  # type: ignore[arg-type]
            samples=self.samples if samples is _U else samples,  # type: ignore[arg-type]
            variant=self.variant if variant is _U else variant,
            sandbox_type=self.sandbox_type if sandbox_type is _U else sandbox_type,  # type: ignore[arg-type]
            system_message=self.system_message if system_message is _U else system_message,
            save_examples=self.save_examples if save_examples is _U else save_examples,  # type: ignore[arg-type]
            examples_dir=self.examples_dir if examples_dir is _U else examples_dir,
            sandbox_parameters=self.sandbox_parameters if sandbox_parameters is _U else sandbox_parameters,
            task_files=self.task_files if task_files is _U else task_files,
            task_setup=self.task_setup if task_setup is _U else task_setup,
            model=self.model if model is _U else model,
            config=self.config if config is _U else config,
            model_roles=self.model_roles if model_roles is _U else model_roles,
            sandbox=self.sandbox if sandbox is _U else sandbox,
            approval=self.approval if approval is _U else approval,
            epochs=self.epochs if epochs is _U else epochs,
            fail_on_error=self.fail_on_error if fail_on_error is _U else fail_on_error,
            continue_on_fail=self.continue_on_fail if continue_on_fail is _U else continue_on_fail,
            message_limit=self.message_limit if message_limit is _U else message_limit,
            token_limit=self.token_limit if token_limit is _U else token_limit,
            time_limit=self.time_limit if time_limit is _U else time_limit,
            working_limit=self.working_limit if working_limit is _U else working_limit,
            cost_limit=self.cost_limit if cost_limit is _U else cost_limit,
            early_stopping=self.early_stopping if early_stopping is _U else early_stopping,
            display_name=self.display_name if display_name is _U else display_name,
            version=self.version if version is _U else version,
            metadata=self.metadata if metadata is _U else metadata,
            dataset_format=self.dataset_format,
            dataset_source=self.dataset_source,
            dataset_args=self.dataset_args,
        )


def _is_glob(pattern: str) -> bool:
    return "*" in pattern or "?" in pattern or "[" in pattern


def _expand_glob_files(base_dir: str, pattern: str) -> list[str]:
    """Expand a glob pattern relative to base_dir, returning matching files."""
    full_pattern = os.path.join(base_dir, pattern)
    matches = [
        os.path.normpath(f)
        for f in sorted(globmod.glob(full_pattern, recursive=True))
        if os.path.isfile(f) and (f.endswith(".yaml") or f.endswith(".yml") or f.endswith(".md"))
    ]
    return matches


def _read_yaml_file(path: str) -> dict[str, Any]:
    """Read a YAML file and return as a dict."""
    with open(path) as f:
        data = yaml.safe_load(f)
    if data is None:
        return {}
    if not isinstance(data, dict):
        raise ValueError(f"Expected dict in YAML file {path}, got {type(data).__name__}")
    return data


def _resolve_log_dir(logs_dir: str, base_dir: str) -> str:
    """Resolve log directory with a timestamp subfolder."""
    now = datetime.now(timezone.utc)
    timestamp = now.strftime("%Y-%m-%d_%H-%M-%S")
    return os.path.normpath(os.path.join(base_dir, logs_dir, timestamp))






# ---------------------------------------------------------------------------
# Task parsing
# ---------------------------------------------------------------------------


def parse_tasks(dataset_root: str) -> list[ParsedTask]:
    """Parse all task.yaml files from tasks/ subdirectories."""
    tasks_dir = os.path.join(dataset_root, "tasks")
    if not os.path.isdir(tasks_dir):
        return []

    parsed = []
    for entry in sorted(os.listdir(tasks_dir)):
        task_dir = os.path.join(tasks_dir, entry)
        if not os.path.isdir(task_dir):
            continue
        task_file = os.path.join(task_dir, "task.yaml")
        if os.path.isfile(task_file):
            parsed.extend(_load_task_file(task_file, dataset_root))

    return parsed


def _load_task_file(task_path: str, dataset_root: str) -> list[ParsedTask]:
    """Load a single task.yaml file into ParsedTask(s)."""
    data = _read_yaml_file(task_path)
    task_dir = os.path.dirname(task_path)

    task_id = data.get("id") or os.path.basename(task_dir)
    func_name = data.get("func") or task_id

    system_message = data.get("system_message")

    # Parse task-level files and setup
    task_files = data.get("files")
    if isinstance(task_files, dict):
        task_files = {str(k): str(v) for k, v in task_files.items()}
    else:
        task_files = None
    task_setup = data.get("setup")
    if isinstance(task_setup, str):
        pass  # already a string
    else:
        task_setup = None

    # Parse dataset section (replaces the old top-level 'samples' key)
    dataset_raw = data.get("dataset")
    samples: list[Sample] = []
    dataset_format = "memory"
    dataset_source: str | None = None
    dataset_args: dict[str, Any] | None = None

    if dataset_raw is not None:
        if not isinstance(dataset_raw, dict):
            raise ValueError(
                f"Task '{task_id}': 'dataset' must be a dict with one of "
                f"'samples', 'json', or 'csv' keys, got {type(dataset_raw).__name__}"
            )

        # Check for mutually exclusive format keys
        format_keys = {'samples', 'json', 'csv'}
        present_keys = format_keys & set(dataset_raw.keys())
        if len(present_keys) > 1:
            raise ValueError(
                f"Task '{task_id}': 'dataset' must have exactly one of "
                f"'samples', 'json', or 'csv', found: {present_keys}"
            )

        dataset_args = dataset_raw.get("args")
        if dataset_args is not None and not isinstance(dataset_args, dict):
            raise ValueError(
                f"Task '{task_id}': 'dataset.args' must be a dict, "
                f"got {type(dataset_args).__name__}"
            )

        if "samples" in dataset_raw:
            # Inline/path-based samples (existing MemoryDataset behavior)
            samples_section = dataset_raw["samples"]
            if not isinstance(samples_section, dict):
                raise ValueError(
                    f"Task '{task_id}': 'dataset.samples' must be a dict with "
                    f"'inline' and/or 'paths' keys, got {type(samples_section).__name__}"
                )
            samples = _load_samples_section(samples_section, dataset_root, task_files, task_dir)
        elif "json" in dataset_raw:
            dataset_format = "json"
            dataset_source = str(dataset_raw["json"])
        elif "csv" in dataset_raw:
            dataset_format = "csv"
            dataset_source = str(dataset_raw["csv"])

    # Task-level Inspect AI args are nested under inspect_task_args
    task_args = data.get("inspect_task_args") or {}

    return [
        ParsedTask(
            id=task_id,
            func=func_name,
            variant=Variant(),
            samples=samples,
            system_message=system_message,
            model=task_args.get("model"),
            config=task_args.get("config") if isinstance(task_args.get("config"), dict) else None,
            model_roles=task_args.get("model_roles") if isinstance(task_args.get("model_roles"), dict) else None,
            sandbox=task_args.get("sandbox"),
            approval=task_args.get("approval"),
            epochs=task_args.get("epochs"),
            fail_on_error=task_args.get("fail_on_error"),
            continue_on_fail=task_args.get("continue_on_fail"),
            message_limit=task_args.get("message_limit"),
            token_limit=task_args.get("token_limit"),
            time_limit=task_args.get("time_limit"),
            working_limit=task_args.get("working_limit"),
            cost_limit=float(task_args["cost_limit"]) if task_args.get("cost_limit") is not None else None,
            early_stopping=task_args.get("early_stopping"),
            display_name=data.get("display_name"),
            version=data.get("version"),
            metadata=data.get("metadata") if isinstance(data.get("metadata"), dict) else None,
            sandbox_parameters=data.get("sandbox_parameters") if isinstance(data.get("sandbox_parameters"), dict) else None,
            task_files=task_files,
            task_setup=task_setup,
            dataset_format=dataset_format,
            dataset_source=dataset_source,
            dataset_args=dataset_args,
        )
    ]


# ---------------------------------------------------------------------------
# Sample loading
# ---------------------------------------------------------------------------


def _load_samples_section(
    samples_map: dict[str, Any],
    dataset_root: str,
    task_files: dict[str, str] | None,
    task_dir: str,
) -> list[Sample]:
    """Load samples from 'paths' and 'inline' subsections."""
    path_patterns: list[str] = samples_map.get("paths") or []
    inline_defs: list[dict[str, Any]] = samples_map.get("inline") or []

    samples: list[Sample] = []

    for pattern in path_patterns:
        if _is_glob(pattern):
            matched = _expand_glob_files(task_dir, pattern)
        else:
            candidate = os.path.normpath(os.path.join(task_dir, pattern))
            matched = [candidate] if os.path.isfile(candidate) else []

        if not matched:
            raise FileNotFoundError(f"No sample files matched pattern: {pattern}")

        samples.extend(_load_samples_from_files(matched, dataset_root, task_files))

    for defn in inline_defs:
        if not defn:
            continue
        samples.append(_resolve_sample(defn, task_dir, dataset_root, task_files))

    return samples


def _load_samples_from_files(
    sample_files: list[str],
    dataset_root: str,
    task_files: dict[str, str] | None,
) -> list[Sample]:
    """Load samples from external YAML files."""
    samples: list[Sample] = []

    for file_path in sample_files:
        full_path = file_path if os.path.isabs(file_path) else os.path.join(dataset_root, file_path)
        if not os.path.isfile(full_path):
            raise FileNotFoundError(f"Sample file not found: {full_path}")

        sample_dir = os.path.dirname(full_path)
        with open(full_path) as f:
            content = f.read()

        # Support multi-document YAML (--- separated)
        docs = re.split(r"^---\s*$", content, flags=re.MULTILINE)
        for doc in docs:
            if not doc.strip():
                continue
            data = yaml.safe_load(doc)
            if isinstance(data, dict):
                samples.append(
                    _resolve_sample(data, sample_dir, dataset_root, task_files)
                )

    return samples


def _resolve_sample(
    doc: dict[str, Any],
    base_dir: str,
    dataset_root: str,
    task_files: dict[str, str] | None,
) -> Sample:
    """Resolve a single sample dict into a Sample."""
    for field in ("id", "input", "target"):
        if field not in doc:
            raise ValueError(
                f"Sample '{doc.get('id', 'unknown')}' missing required field: {field}"
            )

    # Read metadata fields from the metadata dict
    meta_raw: dict[str, Any] = doc.get("metadata") or {}

    # Normalize tags from metadata
    raw_tags = meta_raw.get("tags")
    if isinstance(raw_tags, str):
        tags = [t.strip() for t in raw_tags.split(",")]
    elif isinstance(raw_tags, list):
        tags = raw_tags
    else:
        tags = []

    # Build metadata
    meta: dict[str, Any] = {**meta_raw}
    meta["difficulty"] = meta_raw.get("difficulty", "medium")
    meta["tags"] = tags

    # Parse sample-level files
    sample_files = doc.get("files")
    if isinstance(sample_files, dict):
        sample_files = {str(k): str(v) for k, v in sample_files.items()}
    else:
        sample_files = None

    # Stack files: task-level + sample-level (sample wins on conflict)
    merged_files: dict[str, str] | None = None
    if task_files is not None or sample_files is not None:
        merged_files = {**(task_files or {}), **(sample_files or {})}

    return Sample(
        id=doc["id"],
        input=doc["input"],
        target=doc["target"],
        metadata=meta,
        choices=doc.get("choices"),
        sandbox=doc.get("sandbox"),
        files=merged_files,
        setup=doc.get("setup"),
    )


# ---------------------------------------------------------------------------
# Job parsing
# ---------------------------------------------------------------------------


def parse_job(job_path: str, dataset_root: str) -> Job:
    """Parse a job YAML file into a Job model."""
    if not os.path.isfile(job_path):
        raise FileNotFoundError(f"Job file not found: {job_path}")

    data = _read_yaml_file(job_path)

    logs_dir = data.get("logs_dir") or _DEFAULT_LOGS_DIR
    log_dir = _resolve_log_dir(logs_dir, dataset_root)

    # Parse sandbox config
    sandbox_raw = data.get("sandbox")
    sandbox = None
    if isinstance(sandbox_raw, dict):
        sandbox = sandbox_raw
    elif isinstance(sandbox_raw, str):
        sandbox = {"environment": sandbox_raw}

    max_connections = data.get("max_connections") or 10

    # Parse task filters
    task_paths = None
    tasks = None
    tasks_raw = data.get("tasks")
    if isinstance(tasks_raw, dict):
        task_paths = tasks_raw.get("paths")
        inline_tasks = tasks_raw.get("inline")
        if isinstance(inline_tasks, dict):
            tasks = {}
            for tid, tdata in inline_tasks.items():
                tasks[tid] = JobTask.from_yaml(tid, tdata)

    # Parse variants — supports inline dict or list of file paths
    variants = None
    variants_raw = data.get("variants")
    if isinstance(variants_raw, dict):
        variants = {}
        for key, value in variants_raw.items():
            if isinstance(value, dict):
                variants[str(key)] = dict(value)
            else:
                variants[str(key)] = {}
    elif isinstance(variants_raw, list):
        # List of relative paths to variant definition files
        job_dir = os.path.dirname(job_path)
        variants = {}
        for rel_path in variants_raw:
            variant_file = os.path.normpath(os.path.join(job_dir, str(rel_path)))
            if not os.path.isfile(variant_file):
                raise FileNotFoundError(
                    f"Variant file not found: {variant_file} "
                    f"(referenced from {job_path})"
                )
            file_data = _read_yaml_file(variant_file)
            for vname, vdef in file_data.items():
                variants[str(vname)] = dict(vdef) if isinstance(vdef, dict) else {}

    # Parse inspect_eval_arguments
    inspect_eval_arguments = data.get("inspect_eval_arguments")
    if isinstance(inspect_eval_arguments, dict):
        inspect_eval_arguments = dict(inspect_eval_arguments)
    else:
        inspect_eval_arguments = None

    # Parse models (required)
    models_raw = data.get("models")
    if not models_raw or not isinstance(models_raw, list) or len(models_raw) == 0:
        raise ValueError(
            f"Job file '{job_path}' is missing required 'models' field. "
            "Specify at least one model, e.g.:\n"
            "  models:\n    - google/gemini-2.5-flash"
        )
    models: list[str] = [str(m) for m in models_raw]

    return Job(
        log_dir=log_dir,
        max_connections=max_connections,
        models=models,
        variants=variants,
        task_paths=task_paths,
        tasks=tasks,
        save_examples=data.get("save_examples") is True,
        description=data.get("description"),
        sandbox=sandbox,
        inspect_eval_arguments=inspect_eval_arguments,
        task_filters=data.get("task_filters"),
        sample_filters=data.get("sample_filters"),
    )


def find_job_file(dataset_root: str, job: str) -> str:
    """Find a job file by name or path.

    Looks in ``jobs/`` directory first, then treats *job* as a relative/absolute path.
    """
    if "/" in job or job.endswith(".yaml"):
        job_path = job if os.path.isabs(job) else os.path.join(dataset_root, job)
        if not os.path.isfile(job_path):
            raise FileNotFoundError(f"Job file not found: {job_path}")
        return os.path.normpath(job_path)

    jobs_dir = os.path.join(dataset_root, "jobs")
    if not os.path.isdir(jobs_dir):
        raise FileNotFoundError(
            "Jobs directory not found. "
            "Create it or specify a full path to the job file."
        )

    with_ext = os.path.join(jobs_dir, f"{job}.yaml")
    if os.path.isfile(with_ext):
        return os.path.normpath(with_ext)

    without_ext = os.path.join(jobs_dir, job)
    if os.path.isfile(without_ext):
        return os.path.normpath(without_ext)

    available = [
        os.path.splitext(f)[0]
        for f in sorted(os.listdir(jobs_dir))
        if f.endswith(".yaml")
    ]
    raise FileNotFoundError(
        f"Job '{job}' not found in {jobs_dir}. "
        f"Available jobs: {available or '(none)'}"
    )
