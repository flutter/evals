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
        task_func: str,
        samples: list[Sample],
        variant: Variant | None = None,
        sandbox_type: str = "local",
        system_message: str | None = None,
        allowed_variants: list[str] | None = None,
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
    ):
        self.id = id
        self.task_func = task_func
        self.samples = samples
        self.variant = variant or Variant()
        self.sandbox_type = sandbox_type
        self.system_message = system_message
        self.allowed_variants = allowed_variants
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

    _UNSET: Any = object()

    def copy_with(
        self,
        *,
        id: str | None = _UNSET,
        task_func: str | None = _UNSET,
        samples: list[Sample] | None = _UNSET,
        variant: Variant | None = _UNSET,
        sandbox_type: str | None = _UNSET,
        system_message: str | None = _UNSET,
        allowed_variants: list[str] | None = _UNSET,
        save_examples: bool | None = _UNSET,
        examples_dir: str | None = _UNSET,
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
            task_func=self.task_func if task_func is _U else task_func,  # type: ignore[arg-type]
            samples=self.samples if samples is _U else samples,  # type: ignore[arg-type]
            variant=self.variant if variant is _U else variant,
            sandbox_type=self.sandbox_type if sandbox_type is _U else sandbox_type,  # type: ignore[arg-type]
            system_message=self.system_message if system_message is _U else system_message,
            allowed_variants=self.allowed_variants if allowed_variants is _U else allowed_variants,
            save_examples=self.save_examples if save_examples is _U else save_examples,  # type: ignore[arg-type]
            examples_dir=self.examples_dir if examples_dir is _U else examples_dir,
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


def _pre_resolve_to_abs(resource: Any, task_dir: str) -> Any:
    """Pre-resolve a task-level resource to an absolute path."""
    if resource is None:
        return None
    if isinstance(resource, str):
        if resource.startswith("./") or resource.startswith("../") or resource.startswith("/"):
            return {"path": os.path.normpath(os.path.join(task_dir, resource))}
        return resource
    if isinstance(resource, dict):
        if "path" in resource:
            return {**resource, "path": os.path.normpath(os.path.join(task_dir, resource["path"]))}
        return resource
    return resource


def _resolve_resource_path(resource: Any, base_dir: str) -> str | None:
    """Resolve a workspace/tests resource reference to an absolute path."""
    if resource is None:
        return None
    if isinstance(resource, str):
        if resource.startswith("./") or resource.startswith("../") or resource.startswith("/"):
            return os.path.normpath(os.path.join(base_dir, resource))
        return None
    if isinstance(resource, dict) and "path" in resource:
        return os.path.normpath(os.path.join(base_dir, resource["path"]))
    return None


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
    task_func = data.get("func") or task_id

    task_workspace_raw = data.get("workspace")
    task_tests_raw = data.get("tests")
    system_message = data.get("system_message")

    task_workspace = _pre_resolve_to_abs(task_workspace_raw, task_dir)
    task_tests = _pre_resolve_to_abs(task_tests_raw, task_dir)

    allowed_variants = data.get("allowed_variants")

    # Parse samples section
    samples_raw = data.get("samples")
    if not isinstance(samples_raw, dict):
        raise ValueError(
            f"Task '{task_id}': 'samples' must be a dict with 'inline' and/or "
            f"'paths' keys, got {type(samples_raw).__name__}"
        )
    samples = _load_samples_section(samples_raw, dataset_root, task_workspace, task_tests, task_dir)

    return [
        ParsedTask(
            id=task_id,
            task_func=task_func,
            variant=Variant(),
            samples=samples,
            system_message=system_message,
            allowed_variants=allowed_variants,
            model=data.get("model"),
            config=data.get("config") if isinstance(data.get("config"), dict) else None,
            model_roles=data.get("model_roles") if isinstance(data.get("model_roles"), dict) else None,
            sandbox=data.get("sandbox"),
            approval=data.get("approval"),
            epochs=data.get("epochs"),
            fail_on_error=data.get("fail_on_error"),
            continue_on_fail=data.get("continue_on_fail"),
            message_limit=data.get("message_limit"),
            token_limit=data.get("token_limit"),
            time_limit=data.get("time_limit"),
            working_limit=data.get("working_limit"),
            cost_limit=float(data["cost_limit"]) if data.get("cost_limit") is not None else None,
            early_stopping=data.get("early_stopping"),
            display_name=data.get("display_name"),
            version=data.get("version"),
            metadata=data.get("metadata") if isinstance(data.get("metadata"), dict) else None,
        )
    ]


# ---------------------------------------------------------------------------
# Sample loading
# ---------------------------------------------------------------------------


def _load_samples_section(
    samples_map: dict[str, Any],
    dataset_root: str,
    task_workspace: Any,
    task_tests: Any,
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

        samples.extend(_load_samples_from_files(matched, dataset_root, task_workspace, task_tests))

    for defn in inline_defs:
        if not defn:
            continue
        samples.append(_resolve_sample(defn, task_dir, dataset_root, task_workspace, task_tests))

    return samples


def _load_samples_from_files(
    sample_files: list[str],
    dataset_root: str,
    task_workspace: Any,
    task_tests: Any,
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
                    _resolve_sample(data, sample_dir, dataset_root, task_workspace, task_tests)
                )

    return samples


def _resolve_sample(
    doc: dict[str, Any],
    base_dir: str,
    dataset_root: str,
    task_workspace: Any,
    task_tests: Any,
) -> Sample:
    """Resolve a single sample dict into a Sample."""
    for field in ("id", "input", "target"):
        if field not in doc:
            raise ValueError(
                f"Sample '{doc.get('id', 'unknown')}' missing required field: {field}"
            )

    sample_workspace = doc.get("workspace")
    sample_tests = doc.get("tests")

    effective_workspace = sample_workspace if sample_workspace is not None else task_workspace

    workspace = None
    workspace_git = None
    workspace_git_ref = None

    if effective_workspace is not None:
        if isinstance(effective_workspace, dict) and "git" in effective_workspace:
            workspace_git = effective_workspace.get("git")
            workspace_git_ref = effective_workspace.get("ref")
        else:
            resolve_dir = base_dir if sample_workspace is not None else dataset_root
            workspace = _resolve_resource_path(effective_workspace, resolve_dir)

    tests = None
    if sample_tests is not None:
        tests = _resolve_resource_path(sample_tests, base_dir)
    elif task_tests is not None:
        tests = _resolve_resource_path(task_tests, dataset_root)

    # Normalize tags
    raw_tags = doc.get("tags")
    if isinstance(raw_tags, str):
        tags = [t.strip() for t in raw_tags.split(",")]
    elif isinstance(raw_tags, list):
        tags = raw_tags
    else:
        tags = []

    # Build metadata
    meta: dict[str, Any] = {**(doc.get("metadata") or {})}
    meta["difficulty"] = doc.get("difficulty", "medium")
    meta["tags"] = tags
    if workspace is not None:
        meta["workspace"] = workspace
    if tests is not None:
        meta["tests"] = tests
    if workspace_git is not None:
        meta["workspace_git"] = workspace_git
    if workspace_git_ref is not None:
        meta["workspace_git_ref"] = workspace_git_ref

    return Sample(
        id=doc["id"],
        input=doc["input"],
        target=doc["target"],
        metadata=meta,
        choices=doc.get("choices"),
        sandbox=doc.get("sandbox"),
        files=doc.get("files"),
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

    sandbox_type = data.get("sandbox_type") or "local"
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

    # Parse variants
    variants = None
    variants_raw = data.get("variants")
    if isinstance(variants_raw, dict):
        variants = {}
        for key, value in variants_raw.items():
            if isinstance(value, dict):
                variants[str(key)] = dict(value)
            else:
                variants[str(key)] = {}

    return Job(
        log_dir=log_dir,
        sandbox_type=sandbox_type,
        max_connections=max_connections,
        models=data.get("models"),
        variants=variants,
        task_paths=task_paths,
        tasks=tasks,
        save_examples=data.get("save_examples") is True,
        retry_attempts=data.get("retry_attempts"),
        max_retries=data.get("max_retries"),
        retry_wait=float(data["retry_wait"]) if data.get("retry_wait") is not None else None,
        retry_connections=(
            float(data["retry_connections"]) if data.get("retry_connections") is not None else None
        ),
        retry_cleanup=data.get("retry_cleanup"),
        fail_on_error=(
            float(data["fail_on_error"]) if data.get("fail_on_error") is not None else None
        ),
        continue_on_fail=data.get("continue_on_fail"),
        retry_on_error=data.get("retry_on_error"),
        debug_errors=data.get("debug_errors"),
        max_samples=data.get("max_samples"),
        max_tasks=data.get("max_tasks"),
        max_subprocesses=data.get("max_subprocesses"),
        max_sandboxes=data.get("max_sandboxes"),
        log_level=data.get("log_level"),
        log_level_transcript=data.get("log_level_transcript"),
        log_format=data.get("log_format"),
        tags=data.get("tags"),
        metadata=data.get("metadata") if isinstance(data.get("metadata"), dict) else None,
        trace=data.get("trace"),
        display=data.get("display"),
        score=data.get("score"),
        limit=data.get("limit"),
        sample_id=data.get("sample_id"),
        sample_shuffle=data.get("sample_shuffle"),
        epochs=data.get("epochs"),
        approval=data.get("approval"),
        solver=data.get("solver"),
        sandbox_cleanup=data.get("sandbox_cleanup"),
        model_base_url=data.get("model_base_url"),
        model_args=data.get("model_args") if isinstance(data.get("model_args"), dict) else None,
        model_roles=(
            data.get("model_roles") if isinstance(data.get("model_roles"), dict) else None
        ),
        task_args=data.get("task_args") if isinstance(data.get("task_args"), dict) else None,
        message_limit=data.get("message_limit"),
        token_limit=data.get("token_limit"),
        time_limit=data.get("time_limit"),
        working_limit=data.get("working_limit"),
        cost_limit=float(data["cost_limit"]) if data.get("cost_limit") is not None else None,
        model_cost_config=(
            data.get("model_cost_config")
            if isinstance(data.get("model_cost_config"), dict)
            else None
        ),
        log_samples=data.get("log_samples"),
        log_realtime=data.get("log_realtime"),
        log_images=data.get("log_images"),
        log_buffer=data.get("log_buffer"),
        log_shared=data.get("log_shared"),
        bundle_dir=data.get("bundle_dir"),
        bundle_overwrite=data.get("bundle_overwrite"),
        log_dir_allow_dirty=data.get("log_dir_allow_dirty"),
        eval_set_id=data.get("eval_set_id"),
        eval_set_overrides=(
            data.get("eval_set_overrides")
            if isinstance(data.get("eval_set_overrides"), dict)
            else None
        ),
        task_defaults=(
            data.get("task_defaults") if isinstance(data.get("task_defaults"), dict) else None
        ),
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
