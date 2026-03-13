"""Resolver — combines parsed tasks and job config into EvalSet objects."""

from __future__ import annotations

import glob as globmod
import os
from typing import Any

from dataset_config_python.models.context_file import ContextFile
from dataset_config_python.models.dataset import Dataset
from dataset_config_python.models.eval_set import EvalSet
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

# Default Flutter SDK channel → sandbox registry key mapping.
DEFAULT_SDK_CHANNELS: dict[str, str] = {
    "stable": "podman",
    "beta": "podman-beta",
    "main": "podman-main",
}


def _is_glob(pattern: str) -> bool:
    return "*" in pattern or "?" in pattern or "[" in pattern


def resolve(
    dataset_path: str,
    job_names: list[str],
    *,
    sandbox_registry: dict[str, dict[str, str]] | None = None,
    sdk_channels: dict[str, str] | None = None,
) -> list[EvalSet]:
    """Resolve dataset + job(s) into EvalSet objects.

    This is the main public API of the package.

    Args:
        dataset_path: Root directory containing ``tasks/`` and ``jobs/``.
        job_names: Job names (looked up in ``jobs/``) or paths.
        sandbox_registry: Named sandbox configurations. Defaults to empty.
        sdk_channels: SDK channel → sandbox registry key mapping. Defaults to empty.

    Returns:
        A list of EvalSet objects ready for JSON serialization.
    """
    registry = sandbox_registry or {}
    channels = sdk_channels or {}
    task_configs = parse_tasks(dataset_path)
    results: list[EvalSet] = []

    for job_name in job_names:
        job_path = find_job_file(dataset_path, job_name)
        job = parse_job(job_path, dataset_path)
        results.extend(_resolve_job(task_configs, job, dataset_path, registry, channels))

    return results


def _resolve_job(
    dataset_tasks: list[ParsedTask],
    job: Any,
    dataset_root: str,
    sandbox_registry: dict[str, dict[str, str]],
    sdk_channels: dict[str, str],
) -> list[EvalSet]:
    """Resolve task configs and job into EvalSet objects."""
    models = job.models if job.models else list(DEFAULT_MODELS)
    sandbox_type_str = job.sandbox_type

    expanded_tasks = _expand_task_configs(dataset_tasks, job, sandbox_type_str, dataset_root)

    # Group by flutter channel
    groups: dict[str | None, list[ParsedTask]] = {}
    for tc in expanded_tasks:
        key = tc.variant.flutter_channel
        groups.setdefault(key, []).append(tc)

    return [
        _build_eval_set(
            task_configs=group,
            log_dir=job.log_dir,
            models=models,
            sandbox=_resolve_sandbox(dataset_root, job, sandbox_registry, sdk_channels, flutter_channel=channel),
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
    is_container = job.sandbox_type and job.sandbox_type != "local"
    task_defaults = job.task_defaults or {}

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
        if tc.metadata:
            task_metadata.update(tc.metadata)

        # Determine sandbox for this task
        task_sandbox = None
        if tc.sandbox is not None:
            task_sandbox = tc.sandbox
        elif tc.sandbox_type and tc.sandbox_type != "local":
            task_sandbox = _serialize_sandbox(sandbox)

        # Resolve task-level settings with precedence:
        # task.yaml > task_defaults > hardcoded defaults
        resolved_time_limit = (
            tc.time_limit
            or task_defaults.get("time_limit")
            or (300 if job.sandbox_type != "local" else None)
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

    # Build EvalSet with all job-level parameters
    overrides = job.eval_set_overrides or {}

    return EvalSet(
        tasks=inspect_tasks,
        log_dir=log_dir,
        model=models,
        sandbox=_serialize_sandbox(sandbox),
        # Retry
        retry_attempts=job.retry_attempts or overrides.get("retry_attempts") or 10,
        retry_wait=job.retry_wait or overrides.get("retry_wait") or 60.0,
        retry_connections=job.retry_connections or overrides.get("retry_connections") or 0.5,
        retry_cleanup=job.retry_cleanup if job.retry_cleanup is not None else overrides.get("retry_cleanup"),
        retry_on_error=job.retry_on_error or job.max_retries or overrides.get("retry_on_error"),
        # Error handling
        fail_on_error=job.fail_on_error if job.fail_on_error is not None else (overrides.get("fail_on_error") or 0.05),
        continue_on_fail=job.continue_on_fail if job.continue_on_fail is not None else overrides.get("continue_on_fail"),
        debug_errors=job.debug_errors if job.debug_errors is not None else overrides.get("debug_errors"),
        # Concurrency
        max_samples=job.max_samples or overrides.get("max_samples"),
        max_tasks=job.max_tasks or overrides.get("max_tasks"),
        max_subprocesses=job.max_subprocesses or overrides.get("max_subprocesses"),
        max_sandboxes=job.max_sandboxes or overrides.get("max_sandboxes"),
        # Logging
        log_level=job.log_level or overrides.get("log_level") or "info",
        log_level_transcript=job.log_level_transcript or overrides.get("log_level_transcript"),
        log_format=job.log_format or overrides.get("log_format") or "json",
        log_samples=job.log_samples if job.log_samples is not None else overrides.get("log_samples"),
        log_realtime=job.log_realtime if job.log_realtime is not None else overrides.get("log_realtime"),
        log_images=job.log_images if job.log_images is not None else overrides.get("log_images"),
        log_buffer=job.log_buffer or overrides.get("log_buffer"),
        log_shared=job.log_shared or overrides.get("log_shared"),
        log_dir_allow_dirty=job.log_dir_allow_dirty if job.log_dir_allow_dirty is not None else overrides.get("log_dir_allow_dirty"),
        # Model config
        model_base_url=job.model_base_url or overrides.get("model_base_url"),
        model_args=job.model_args or overrides.get("model_args") or {},
        model_roles=job.model_roles or overrides.get("model_roles"),
        task_args=job.task_args or overrides.get("task_args") or {},
        model_cost_config=job.model_cost_config or overrides.get("model_cost_config"),
        # Sandbox
        sandbox_cleanup=job.sandbox_cleanup if job.sandbox_cleanup is not None else overrides.get("sandbox_cleanup"),
        # Sample control
        limit=job.limit or overrides.get("limit"),
        sample_id=job.sample_id or overrides.get("sample_id"),
        sample_shuffle=job.sample_shuffle or overrides.get("sample_shuffle"),
        epochs=job.epochs or overrides.get("epochs"),
        # Misc
        tags=job.tags or overrides.get("tags"),
        metadata=job.metadata or overrides.get("metadata"),
        trace=job.trace if job.trace is not None else overrides.get("trace"),
        display=job.display or overrides.get("display"),
        approval=job.approval or overrides.get("approval"),
        solver=job.solver or overrides.get("solver"),
        score=job.score if job.score is not None else (overrides.get("score") if overrides.get("score") is not None else True),
        # Limits
        message_limit=job.message_limit or overrides.get("message_limit"),
        token_limit=job.token_limit or overrides.get("token_limit"),
        time_limit=job.time_limit or overrides.get("time_limit"),
        working_limit=job.working_limit or overrides.get("working_limit"),
        cost_limit=job.cost_limit if job.cost_limit is not None else (
            float(overrides["cost_limit"]) if overrides.get("cost_limit") is not None else None
        ),
        # Bundling
        bundle_dir=job.bundle_dir or overrides.get("bundle_dir"),
        bundle_overwrite=job.bundle_overwrite if job.bundle_overwrite is not None else (overrides.get("bundle_overwrite") or False),
        eval_set_id=job.eval_set_id or overrides.get("eval_set_id"),
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
    sdk_channels: dict[str, str],
    *,
    flutter_channel: str | None = None,
) -> Any:
    """Resolve sandbox spec for a given config."""
    sandbox_type = job.sandbox_type
    if not sandbox_type or sandbox_type == "local":
        return "local"

    # Channel override
    if flutter_channel and flutter_channel in sdk_channels:
        registry_key = sdk_channels[flutter_channel]
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

        # Apply system_message override
        system_message = tc.system_message
        if job_task and job_task.system_message is not None:
            system_message = job_task.system_message

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
        flutter_channel=vdef.get("flutter_channel"),
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
