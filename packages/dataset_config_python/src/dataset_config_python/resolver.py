"""Resolver — combines parsed tasks and job config into EvalSet objects."""

from __future__ import annotations

import glob as globmod
import os
from dataclasses import dataclass, field
from typing import Any

from dataset_config_python.models.context_file import ContextFile
from dataset_config_python.models.dataset import Dataset
from dataset_config_python.models.eval_set import EvalSet
from dataset_config_python.models.job import Job
from dataset_config_python.models.sample import Sample
from dataset_config_python.models.tag_filter import matches_tag_filter
from dataset_config_python.models.task import Task
from dataset_config_python.models.variant import Variant
from dataset_config_python.parser import ParsedTask, find_job_file, parse_job, parse_tasks

# Default models when a job doesn't specify its own.
DEFAULT_MODELS: list[str] = [
    "anthropic/claude-haiku-4-5",
    "anthropic/claude-sonnet-4-5",
    "anthropic/claude-opus-4-6",
    "google/gemini-2.5-flash",
    "google/gemini-3-pro-preview",
    "google/gemini-3-flash-preview",
    "openai/gpt-5-mini",
    "openai/gpt-5-nano",
    "openai/gpt-5",
    "openai/gpt-5-pro",
]

# Default sandbox configurations for Flutter evaluations.
# Consumers can pass these to resolve() or provide their own.
DEFAULT_SANDBOX_REGISTRY: dict[str, dict[str, str]] = {
    "podman": {"name": "podman", "path": "./sandboxes/podman/compose.yaml"},
    "podman-beta": {"name": "podman", "path": "./sandboxes/podman/compose-beta.yaml"},
    "podman-main": {"name": "podman", "path": "./sandboxes/podman/compose-main.yaml"},
}

# Default SDK branch → sandbox registry key mapping.
DEFAULT_BRANCH_CHANNELS: dict[str, str] = {
    "stable": "podman",
    "beta": "podman-beta",
    "main": "podman-main",
}


@dataclass
class SandboxConfig:
    """Sandbox registry and branch-channel mapping."""

    registry: dict[str, dict[str, str]] = field(default_factory=dict)
    branch_channels: dict[str, str] = field(default_factory=dict)


def _is_glob(pattern: str) -> bool:
    return "*" in pattern or "?" in pattern or "[" in pattern


def resolve(
    dataset_path: str,
    job_names: list[str],
    *,
    sandbox_config: SandboxConfig | None = None,
) -> list[EvalSet]:
    """Resolve dataset + job(s) into EvalSet objects.

    This is a convenience wrapper around :func:`resolve_from_parsed` that
    handles parsing automatically.  Use ``resolve_from_parsed`` when you
    need to inspect or mutate the parsed config before resolution.

    Args:
        dataset_path: Root directory containing ``tasks/`` and ``jobs/``.
        job_names: Job names (looked up in ``jobs/``) or paths.
        sandbox_config: Sandbox registry and branch-channel mapping.

    Returns:
        A list of EvalSet objects ready for JSON serialization.
    """
    task_configs = parse_tasks(dataset_path)
    results: list[EvalSet] = []

    for job_name in job_names:
        job_path = find_job_file(dataset_path, job_name)
        job = parse_job(job_path, dataset_path)
        results.extend(
            resolve_from_parsed(
                task_configs=task_configs,
                job=job,
                dataset_path=dataset_path,
                sandbox_config=sandbox_config,
            )
        )

    return results


def resolve_from_parsed(
    task_configs: list[ParsedTask],
    job: Job,
    dataset_path: str,
    *,
    sandbox_config: SandboxConfig | None = None,
) -> list[EvalSet]:
    """Resolve pre-parsed task configs and a job into EvalSet objects.

    Use this instead of :func:`resolve` when you need to inspect or modify
    the parsed configuration before resolution.  A typical workflow::

        tasks = parse_tasks(dataset_path)
        job = parse_job(find_job_file(dataset_path, "my_job"), dataset_path)

        # Patch values before resolution
        job.log_dir = f"{job.log_dir}/{execution_id}"

        eval_sets = resolve_from_parsed(tasks, job, dataset_path)

    Args:
        task_configs: Parsed task configs (from :func:`parse_tasks`).
        job: A parsed Job object (from :func:`parse_job`).
        dataset_path: Root directory of the dataset (used for path resolution).
        sandbox_config: Sandbox registry and branch-channel mapping.

    Returns:
        A list of EvalSet objects ready for JSON serialization.
    """
    sandbox_cfg = sandbox_config or SandboxConfig()
    registry = sandbox_cfg.registry
    channels = sandbox_cfg.branch_channels
    return _resolve_job(task_configs, job, dataset_path, registry, channels)


def _resolve_job(
    dataset_tasks: list[ParsedTask],
    job: Any,
    dataset_root: str,
    sandbox_registry: dict[str, dict[str, str]],
    branch_channels: dict[str, str],
) -> list[EvalSet]:
    """Resolve task configs and job into EvalSet objects."""
    models = job.models if job.models else list(DEFAULT_MODELS)
    sandbox_cfg = job.sandbox or {}
    sandbox_type_str = sandbox_cfg.get("environment", "local")

    expanded_tasks = _expand_task_configs(dataset_tasks, job, sandbox_type_str, dataset_root)

    # Group by branch
    groups: dict[str | None, list[ParsedTask]] = {}
    for tc in expanded_tasks:
        key = tc.variant.branch
        groups.setdefault(key, []).append(tc)

    return [
        _build_eval_set(
            task_configs=group,
            log_dir=job.log_dir,
            models=models,
            sandbox=_resolve_sandbox(dataset_root, job, sandbox_registry, branch_channels, branch=channel),
            job=job,
        )
        for channel, group in groups.items()
    ]


# ---------------------------------------------------------------------------
# EvalSet building
# ---------------------------------------------------------------------------


def _build_eval_set(
    *,
    task_configs: list[ParsedTask],
    log_dir: str,
    models: list[str],
    sandbox: Any,
    job: Any,
) -> EvalSet:
    """Build an EvalSet from resolved ParsedTasks."""
    inspect_tasks: list[Task] = []
    sandbox_cfg = job.sandbox or {}
    sandbox_type_str = sandbox_cfg.get("environment", "local")
    is_container = sandbox_type_str and sandbox_type_str != "local"
    eval_args = job.inspect_eval_arguments or {}
    task_defaults = eval_args.get("task_defaults") or {}

    for tc in task_configs:
        # Enrich each sample with task-level metadata
        inspect_samples: list[Sample] = []
        for sample in tc.samples:
            enriched: dict[str, Any] = {**(sample.metadata or {})}

            if tc.save_examples:
                enriched["save_examples"] = True
                if tc.examples_dir is not None:
                    enriched["examples_dir"] = tc.examples_dir
                    enriched["task_variant"] = f"{tc.id}:{tc.variant.name}"

            # Build files + setup for sandbox provisioning
            files = dict(sample.files) if sample.files else None
            setup = sample.setup
            workspace = (sample.metadata or {}).get("workspace")
            workspace_git = (sample.metadata or {}).get("workspace_git")
            workspace_git_ref = (sample.metadata or {}).get("workspace_git_ref")

            if workspace is not None and is_container:
                files = {**(files or {}), "/workspace": workspace}
                setup = setup or "cd /workspace && flutter pub get"
                enriched["workspace"] = "/workspace"
            if workspace_git is not None:
                enriched["workspace_git"] = workspace_git
                if workspace_git_ref is not None:
                    enriched["workspace_git_ref"] = workspace_git_ref

            inspect_samples.append(
                Sample(
                    id=sample.id,
                    input=sample.input,
                    target=sample.target,
                    metadata=enriched,
                    choices=sample.choices,
                    sandbox=sample.sandbox,
                    files=files,
                    setup=setup,
                )
            )

        dataset = Dataset(
            samples=inspect_samples,
            name=f"{tc.id}:{tc.variant.name}",
        )

        # Task metadata (variant config, system message, etc.)
        task_metadata: dict[str, Any] = {"variant": tc.variant.name}
        if tc.variant.context_files:
            task_metadata["variant_config"] = {
                "context_files": [
                    {
                        "title": cf.metadata.title,
                        "version": cf.metadata.version,
                        "content": cf.content,
                    }
                    for cf in tc.variant.context_files
                ],
                "mcp_servers": tc.variant.mcp_servers,
                "skill_paths": tc.variant.skill_paths,
            }
        elif tc.variant.mcp_servers or tc.variant.skill_paths:
            task_metadata["variant_config"] = {
                "mcp_servers": tc.variant.mcp_servers,
                "skill_paths": tc.variant.skill_paths,
            }
        if tc.system_message is not None:
            task_metadata["system_message"] = tc.system_message
        if tc.save_examples:
            task_metadata["save_examples"] = True
        if tc.examples_dir is not None:
            task_metadata["examples_dir"] = tc.examples_dir
        # Propagate image_prefix from job for container image resolution
        if (job.sandbox or {}).get("image_prefix"):
            task_metadata["image_prefix"] = job.sandbox["image_prefix"]
        if tc.metadata:
            task_metadata.update(tc.metadata)

        # Determine sandbox for this task
        task_sandbox = None
        if tc.sandbox is not None:
            task_sandbox = tc.sandbox
        elif sandbox_type_str != "local":
            task_sandbox = _serialize_sandbox(sandbox)

        # Resolve task-level settings with precedence:
        # task.yaml > task_defaults > hardcoded defaults
        resolved_time_limit = (
            tc.time_limit
            or task_defaults.get("time_limit")
            or (300 if sandbox_type_str != "local" else None)
        )

        inspect_tasks.append(
            Task(
                name=f"{tc.id}:{tc.variant.name}",
                func=tc.func,
                dataset=dataset,
                sandbox=task_sandbox,
                metadata=task_metadata,
                system_message=tc.system_message,
                sandbox_parameters=tc.sandbox_parameters,
                model=tc.model or task_defaults.get("model"),
                config=tc.config or task_defaults.get("config"),
                model_roles=tc.model_roles or task_defaults.get("model_roles"),
                approval=tc.approval or task_defaults.get("approval"),
                epochs=tc.epochs or task_defaults.get("epochs"),
                fail_on_error=tc.fail_on_error or task_defaults.get("fail_on_error"),
                continue_on_fail=tc.continue_on_fail if tc.continue_on_fail is not None else task_defaults.get("continue_on_fail"),
                message_limit=tc.message_limit or task_defaults.get("message_limit"),
                token_limit=tc.token_limit or task_defaults.get("token_limit"),
                time_limit=resolved_time_limit,
                working_limit=tc.working_limit or task_defaults.get("working_limit"),
                cost_limit=tc.cost_limit if tc.cost_limit is not None else (
                    float(task_defaults["cost_limit"]) if task_defaults.get("cost_limit") is not None else None
                ),
                early_stopping=tc.early_stopping or task_defaults.get("early_stopping"),
                display_name=tc.display_name or task_defaults.get("display_name"),
                version=tc.version if tc.version is not None else (task_defaults.get("version") or 0),
            )
        )

    # Build EvalSet with all job-level parameters from inspect_eval_arguments
    eval_set_overrides = eval_args.get("eval_set_overrides") or {}

    # Helper to get a value from eval_args then overrides
    def _get(key, default=None):
        v = eval_args.get(key)
        if v is not None:
            return v
        v = eval_set_overrides.get(key)
        if v is not None:
            return v
        return default

    return EvalSet(
        tasks=inspect_tasks,
        log_dir=log_dir,
        model=models,
        sandbox=_serialize_sandbox(sandbox),
        # Retry
        retry_attempts=_get("retry_attempts", 10),
        retry_wait=float(_get("retry_wait", 60.0)),
        retry_connections=float(_get("retry_connections", 0.5)),
        retry_cleanup=_get("retry_cleanup"),
        retry_on_error=_get("retry_on_error") or _get("max_retries"),
        # Error handling
        fail_on_error=float(_get("fail_on_error", 0.05)),
        continue_on_fail=_get("continue_on_fail"),
        debug_errors=_get("debug_errors"),
        # Concurrency
        max_samples=_get("max_samples"),
        max_tasks=_get("max_tasks"),
        max_subprocesses=_get("max_subprocesses"),
        max_sandboxes=_get("max_sandboxes"),
        # Logging
        log_level=_get("log_level", "info"),
        log_level_transcript=_get("log_level_transcript"),
        log_format=_get("log_format", "json"),
        log_samples=_get("log_samples"),
        log_realtime=_get("log_realtime"),
        log_images=_get("log_images"),
        log_buffer=_get("log_buffer"),
        log_shared=_get("log_shared"),
        log_dir_allow_dirty=_get("log_dir_allow_dirty"),
        # Model config
        model_base_url=_get("model_base_url"),
        model_args=_get("model_args", {}),
        model_roles=_get("model_roles"),
        task_args=_get("task_args", {}),
        model_cost_config=_get("model_cost_config"),
        # Sandbox
        sandbox_cleanup=_get("sandbox_cleanup"),
        # Sample control
        limit=_get("limit"),
        sample_id=_get("sample_id"),
        sample_shuffle=_get("sample_shuffle"),
        epochs=_get("epochs"),
        # Misc
        tags=_get("tags"),
        metadata=_get("metadata"),
        trace=_get("trace"),
        display=_get("display"),
        approval=_get("approval"),
        solver=_get("solver"),
        score=_get("score", True),
        # Limits
        message_limit=_get("message_limit"),
        token_limit=_get("token_limit"),
        time_limit=_get("time_limit"),
        working_limit=_get("working_limit"),
        cost_limit=float(_get("cost_limit")) if _get("cost_limit") is not None else None,
        # Bundling
        bundle_dir=_get("bundle_dir"),
        bundle_overwrite=_get("bundle_overwrite", False),
        eval_set_id=_get("eval_set_id"),
    )


# ---------------------------------------------------------------------------
# Model resolution
# ---------------------------------------------------------------------------


def _resolve_models(job: Any) -> list[str]:
    if job.models:
        return job.models
    return list(DEFAULT_MODELS)


# ---------------------------------------------------------------------------
# Sandbox resolution
# ---------------------------------------------------------------------------


def _resolve_sandbox(
    dataset_root: str,
    job: Any,
    sandbox_registry: dict[str, dict[str, str]],
    branch_channels: dict[str, str],
    *,
    branch: str | None = None,
) -> Any:
    """Resolve sandbox spec for a given config."""
    sandbox_cfg = job.sandbox or {}
    sandbox_type = sandbox_cfg.get("environment", "local")
    if not sandbox_type or sandbox_type == "local":
        return "local"

    # Channel override
    # Branch override → look up branch-specific sandbox
    if branch and branch in branch_channels:
        registry_key = branch_channels[branch]
        if registry_key in sandbox_registry:
            defn = sandbox_registry[registry_key]
            sandbox_path = defn["path"]
            if not os.path.isabs(sandbox_path):
                sandbox_path = os.path.normpath(os.path.join(dataset_root, sandbox_path))
            return {"type": defn["name"], "path": sandbox_path}

    # Named sandbox from registry
    if sandbox_type in sandbox_registry:
        defn = sandbox_registry[sandbox_type]
        sandbox_path = defn["path"]
        if not os.path.isabs(sandbox_path):
            sandbox_path = os.path.normpath(os.path.join(dataset_root, sandbox_path))
        return {"type": defn["name"], "path": sandbox_path}

    return "local"


# ---------------------------------------------------------------------------
# Task × variant expansion
# ---------------------------------------------------------------------------


def _expand_task_configs(
    dataset_tasks: list[ParsedTask],
    job: Any,
    sandbox_type: str,
    dataset_root: str,
) -> list[ParsedTask]:
    """Expand task × variant combinations."""
    job_variants = job.variants or {"baseline": {}}
    expanded: list[ParsedTask] = []

    for tc in dataset_tasks:
        task_id = tc.id

        # Filter by job.tasks (ID-based)
        if job.tasks is not None and task_id not in job.tasks:
            continue

        # Filter by job.task_filters (tag-based)
        if job.task_filters is not None:
            task_tags = (tc.metadata or {}).get("tags", [])
            if not matches_tag_filter(task_tags, job.task_filters):
                continue

        # Determine effective variants (intersection)
        effective_variants: dict[str, dict[str, Any]] = {}
        for vname, vdef in job_variants.items():
            if tc.allowed_variants is None or vname in tc.allowed_variants:
                effective_variants[vname] = vdef

        # Filter by task-level variant_filters (tag-based)
        if tc.variant_filters is not None:
            effective_variants = {
                vname: vdef
                for vname, vdef in effective_variants.items()
                if matches_tag_filter([vname], tc.variant_filters)
            }

        # Get job-level task overrides
        job_task = job.tasks.get(task_id) if job.tasks else None

        # Apply sample filtering
        samples = tc.samples
        if job_task is not None:
            if job_task.include_samples:
                samples = [s for s in samples if s.id in job_task.include_samples]
            if job_task.exclude_samples:
                samples = [s for s in samples if s.id not in job_task.exclude_samples]

        # Apply sample tag filtering (job-level)
        if job.sample_filters is not None:
            samples = [
                s for s in samples
                if matches_tag_filter((s.metadata or {}).get("tags", []), job.sample_filters)
            ]

        # Apply system_message from task (no longer overridden by job task)
        system_message = tc.system_message

        # Merge job-task args into metadata
        merged_metadata = dict(tc.metadata) if tc.metadata else None
        if job_task and job_task.args:
            merged_metadata = {**(merged_metadata or {}), "args": job_task.args}

        # Create one ParsedTask per effective variant
        for vname, vdef in effective_variants.items():
            variant = _resolve_variant(vname, vdef, dataset_root)

            examples_dir = None
            if job.save_examples:
                examples_dir = os.path.join(job.log_dir, "examples")

            expanded.append(
                tc.copy_with(
                    samples=samples,
                    variant=variant,
                    sandbox_type=sandbox_type,
                    system_message=system_message,
                    allowed_variants=None,
                    save_examples=job.save_examples,
                    examples_dir=examples_dir,
                    metadata=merged_metadata,
                )
            )

    return expanded


# ---------------------------------------------------------------------------
# Variant resolution
# ---------------------------------------------------------------------------


def _resolve_variant(
    name: str,
    vdef: dict[str, Any],
    dataset_root: str,
) -> Variant:
    """Resolve a variant dict into a fully-resolved Variant."""
    if not vdef:
        return Variant(name=name)

    # Load context files (with glob support)
    context_files: list[ContextFile] = []
    cf_paths: list[str] = vdef.get("context_files") or []
    for cf_path in cf_paths:
        if _is_glob(cf_path):
            full_pattern = os.path.join(dataset_root, cf_path)
            matched = sorted(
                f
                for f in globmod.glob(full_pattern, recursive=True)
                if os.path.isfile(f) and (f.endswith(".yaml") or f.endswith(".yml") or f.endswith(".md"))
            )
            if not matched:
                raise FileNotFoundError(f"No context files matched pattern: {cf_path}")
            for f in matched:
                context_files.append(ContextFile.load(f))
        else:
            full_path = os.path.normpath(os.path.join(dataset_root, cf_path))
            context_files.append(ContextFile.load(full_path))

    # Resolve skill paths (with glob support)
    skill_paths: list[str] = []
    raw_skills: list[str] = vdef.get("skills") or vdef.get("skill_paths") or []
    for skill_path_str in raw_skills:
        if _is_glob(skill_path_str):
            full_pattern = os.path.join(dataset_root, skill_path_str)
            matched_dirs = sorted(
                d
                for d in globmod.glob(full_pattern, recursive=True)
                if os.path.isdir(d)
            )
            valid_dirs = [d for d in matched_dirs if os.path.isfile(os.path.join(d, "SKILL.md"))]
            if not valid_dirs:
                raise FileNotFoundError(f"No skill directories matched pattern: {skill_path_str}")
            skill_paths.extend(valid_dirs)
        else:
            skill_dir = os.path.normpath(os.path.join(dataset_root, skill_path_str))
            if not os.path.isdir(skill_dir):
                raise FileNotFoundError(f"Skill directory not found: {skill_dir}")
            if not os.path.isfile(os.path.join(skill_dir, "SKILL.md")):
                raise FileNotFoundError(
                    f"SKILL.md not found in {skill_dir}. "
                    "Each skill directory must contain a SKILL.md file."
                )
            skill_paths.append(skill_dir)

    return Variant(
        name=name,
        context_files=context_files,
        mcp_servers=vdef.get("mcp_servers") or [],
        skill_paths=skill_paths,
        branch=vdef.get("branch"),
    )


# ---------------------------------------------------------------------------
# Serialization helpers
# ---------------------------------------------------------------------------


def _serialize_sandbox(sandbox: Any) -> Any:
    """Serialize sandbox to eval_set()-compatible format."""
    if isinstance(sandbox, str):
        return None if sandbox == "local" else sandbox
    if isinstance(sandbox, dict):
        return [sandbox["type"], sandbox["path"]]
    return None
