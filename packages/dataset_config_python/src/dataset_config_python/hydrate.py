"""Hydrate — convert resolved config dicts into Inspect AI objects.

This module is the single source of truth for interpreting config structures
(datasets, MCP servers, skills, metadata) as Inspect AI objects. Both
``dash_evals`` and external consumers (e.g. yardstick) should use these
helpers rather than re-implementing the same logic.

No solver or task-execution logic lives here — only config → object conversion.
"""

from __future__ import annotations

import importlib
from typing import Any

from inspect_ai.dataset import MemoryDataset, Sample, csv_dataset, json_dataset
from inspect_ai.tool import (
    MCPServer,
    Tool,
    mcp_server_http,
    mcp_server_sandbox,
    mcp_server_stdio,
    skill,
)

# ---------------------------------------------------------------------------
# Dataset hydration
# ---------------------------------------------------------------------------


def build_dataset(task_def: dict) -> Any:
    """Build an Inspect AI dataset from a task definition dict.

    Dispatches on ``task_def["dataset"]["format"]``:

    - ``"memory"`` (default): builds a ``MemoryDataset`` from inline samples.
    - ``"json"``: delegates to ``inspect_ai.dataset.json_dataset(source, **args)``.
    - ``"csv"``: delegates to ``inspect_ai.dataset.csv_dataset(source, **args)``.

    Args:
        task_def: A task entry from the EvalSet JSON manifest.

    Returns:
        An Inspect AI dataset object.

    Raises:
        ValueError: If the dataset format is unrecognised or required fields
            (e.g. ``source`` for json/csv) are missing.
    """
    dataset_def = task_def.get("dataset")
    task_name = task_def.get("name", "")

    if not dataset_def:
        return MemoryDataset([], name=task_name)

    fmt = dataset_def.get("format", "memory")
    extra_args: dict = dataset_def.get("args") or {}

    if fmt == "json":
        source = dataset_def.get("source")
        if not source:
            raise ValueError(
                f"Task '{task_name}': dataset format 'json' requires a 'source' field."
            )
        return json_dataset(source, **extra_args)

    if fmt == "csv":
        source = dataset_def.get("source")
        if not source:
            raise ValueError(f"Task '{task_name}': dataset format 'csv' requires a 'source' field.")
        return csv_dataset(source, **extra_args)

    if fmt == "memory":
        raw_samples = dataset_def.get("samples", [])
        samples = []
        for raw in raw_samples:
            sample = Sample(
                input=raw["input"],
                target=raw.get("target", ""),
                id=raw.get("id"),
                metadata=raw.get("metadata"),
                files=raw.get("files"),
                setup=raw.get("setup"),
                sandbox=raw.get("sandbox"),
            )
            samples.append(sample)

        return MemoryDataset(
            samples,
            name=dataset_def.get("name", task_name),
        )

    raise ValueError(
        f"Task '{task_name}': unknown dataset format '{fmt}'. "
        f"Expected one of: 'memory', 'json', 'csv'."
    )


# ---------------------------------------------------------------------------
# MCP server hydration
# ---------------------------------------------------------------------------


def _resolve_mcp_ref(ref: str) -> MCPServer:
    """Resolve a Python import reference to an MCPServer object.

    Supports ``"module.path:variable_name"`` format.

    Args:
        ref: Import reference (e.g. ``"my_package.mcp:staging_server"``).

    Returns:
        The resolved MCPServer object.
    """
    if ":" not in ref:
        raise ValueError(
            f"Invalid MCP server ref '{ref}'. Expected format: 'module.path:variable_name'"
        )
    module_path, attr_name = ref.rsplit(":", 1)
    try:
        module = importlib.import_module(module_path)
    except ImportError as e:
        raise ImportError(
            f"Could not import module '{module_path}' for MCP server ref '{ref}': {e}"
        ) from e
    try:
        server = getattr(module, attr_name)
    except AttributeError as e:
        raise AttributeError(
            f"Module '{module_path}' has no attribute '{attr_name}' "
            f"(referenced by MCP server ref '{ref}')"
        ) from e
    return server


def create_mcp_servers(
    mcp_configs: list[dict],
    sandbox_type: str = "local",
) -> list[MCPServer]:
    """Create MCP server objects from variant config.

    Supports three modes per entry:

    - **Declarative stdio/sandbox**: dict with ``command``, ``args``, etc.
    - **Declarative HTTP**: dict with ``url``, and optionally ``authorization``/``headers``.
    - **Python ref**: dict with ``ref`` key pointing to a pre-built MCPServer.

    Transport is auto-selected when not explicit:

    - If ``url`` is present → ``mcp_server_http``
    - If sandbox is non-local → ``mcp_server_sandbox``
    - Otherwise → ``mcp_server_stdio``

    Args:
        mcp_configs: List of MCP server config dicts from variant_config.
        sandbox_type: The sandbox type for the current eval run.

    Returns:
        List of MCPServer objects.
    """
    servers: list[MCPServer] = []
    for cfg in mcp_configs:
        # Ref mode — import a pre-built MCPServer from Python
        if cfg.get("ref"):
            servers.append(_resolve_mcp_ref(cfg["ref"]))
            continue

        # HTTP mode — url-based server
        url = cfg.get("url")
        if url:
            name = cfg.get("name", url)
            authorization = cfg.get("authorization") or cfg.get("auth")
            headers = cfg.get("headers")
            servers.append(
                mcp_server_http(
                    url=url,
                    name=name,
                    authorization=authorization,
                    headers=headers,
                )
            )
            continue

        # Stdio / sandbox mode — command-based server
        command = cfg.get("command")
        if not command:
            raise ValueError(
                f"MCP server config missing 'command' or 'url' for server "
                f"'{cfg.get('name', 'unknown')}': {cfg}"
            )

        name = cfg.get("name", command)
        args = cfg.get("args", [])
        env = cfg.get("env")
        cwd = cfg.get("cwd")

        transport = cfg.get("transport")
        if transport is None:
            transport = "sandbox" if sandbox_type != "local" else "stdio"

        if transport == "stdio":
            servers.append(
                mcp_server_stdio(
                    name=name,
                    command=command,
                    args=args,
                    env=env,
                    cwd=cwd,
                )
            )
        elif transport == "sandbox":
            servers.append(
                mcp_server_sandbox(
                    name=name,
                    command=command,
                    args=args,
                    env=env,
                    cwd=cwd,
                )
            )
        else:
            raise ValueError(f"Unknown MCP transport '{transport}' for server '{name}'")

    return servers


# ---------------------------------------------------------------------------
# Skill tool hydration
# ---------------------------------------------------------------------------


def get_skill_tool(config: dict) -> Tool | None:
    """Create the skill tool if the variant has skills configured.

    Args:
        config: Task manifest entry with 'variant' key.

    Returns:
        The skill Tool, or None if no skills are configured.
    """
    variant = config.get("variant", {})
    # Support both old "skill_paths" and new "skills" key
    skill_paths = variant.get("skills") or variant.get("skill_paths", [])
    if skill_paths:
        return skill(skill_paths)
    return None


# ---------------------------------------------------------------------------
# Task metadata
# ---------------------------------------------------------------------------


def build_task_metadata(config: dict) -> dict:
    """Build task metadata dictionary from manifest config.

    Args:
        config: Task manifest entry with 'variant', 'save_examples', etc.

    Returns:
        Metadata dictionary for Task.
    """
    metadata: dict[str, Any] = {}
    variant = config.get("variant", {})
    if variant:
        metadata["variant_config"] = variant

    if config.get("save_examples") and config.get("examples_dir"):
        metadata["save_examples"] = True
        metadata["examples_dir"] = config["examples_dir"]
        metadata["task_variant"] = config.get("task_name", "unknown")

    return metadata
