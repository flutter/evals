"""Shared helper functions for building task components.

These helpers encapsulate common patterns used across tasks:
- Creating MCP servers from variant config
- Building task metadata
- Appending variant-driven solvers (context injection, MCP tools, skills)

All helpers accept a `config` dict (from the run manifest) instead of
TaskConfig, enabling the JSONL + manifest-based execution flow.
"""

from __future__ import annotations

import importlib
from typing import Any, cast

from inspect_ai.agent import react
from inspect_ai.solver import Solver, generate
from inspect_ai.tool import (
    MCPServer,
    Tool,
    mcp_server_http,
    mcp_server_sandbox,
    mcp_server_stdio,
    skill,
)

from dash_evals.runner.solvers import context_injector

# Tools that trigger sandbox injection (require Linux container).
# bash_session() and text_editor() both call sandbox_with_injected_tools(),
# which injects helper scripts and only supports Linux containers.
INJECTION_TOOLS = frozenset({"bash_session", "text_editor"})


def validate_sandbox_tools(config: dict, tool_names: list[str]) -> None:
    """Validate that the requested tools are compatible with the sandbox type.

    Args:
        config: Task manifest entry with 'sandbox_type' and 'task_name' keys.
        tool_names: Names of tools this task will use.

    Raises:
        ValueError: If local sandbox is used with injection-requiring tools.
    """
    if config.get("sandbox_type", "local") != "local":
        return

    conflicting = INJECTION_TOOLS.intersection(tool_names)
    if not conflicting:
        return

    tool_list = "\n".join(f"  • {t}()" for t in sorted(conflicting))
    task_name = config.get("task_name", "unknown")
    raise ValueError(
        f"\n{'=' * 60}\n"
        f"Task '{task_name}' cannot run on a local sandbox.\n\n"
        f"The following tools require a Linux container (Docker/Podman):\n"
        f"{tool_list}\n\n"
        f"These tools inject helper scripts into the sandbox, which is\n"
        f"not supported on macOS.\n\n"
        f"To fix this, either:\n"
        f"  1. Set sandbox_type to 'docker' or 'podman' in your job YAML\n"
        f"  2. Use a task that supports local execution (e.g. 'analyze_codebase')\n"
        f"{'=' * 60}"
    )


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


# Backwards-compatible alias
def create_mcp_server(config: dict | None = None):
    """Create the default Dart MCP server (backwards-compatible alias)."""
    return mcp_server_stdio(
        name="Dart",
        command="dart",
        args=["mcp-server", "--force-roots-fallback"],
    )


def create_dart_mcp_server():
    """Create the standard Dart MCP server tool (backwards-compatible alias)."""
    return create_mcp_server()


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


def append_context_injection(solver_chain: list, config: dict) -> None:
    """Append context injection solver if the variant has context files.

    Args:
        solver_chain: The solver chain list to append to.
        config: Task manifest entry with 'variant' key.
    """
    variant = config.get("variant", {})
    # Support both old "context_files" and new "files" key
    context_files = variant.get("files") or variant.get("context_files", [])
    if context_files:
        solver_chain.append(context_injector(context_files))


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


def append_model_interaction(
    solver_chain: list,
    config: dict,
    *,
    extra_tools: list | None = None,
) -> None:
    """Append either a react agent (with MCP tools) or plain generate.

    Args:
        solver_chain: The solver chain list to append to.
        config: Task manifest entry with 'variant' key.
        extra_tools: Additional tools to include alongside MCP (optional).
    """
    tools: list[Tool | MCPServer] = []
    variant = config.get("variant", {})
    mcp_servers_config = variant.get("mcp_servers", [])

    if mcp_servers_config:
        sandbox_type = config.get("sandbox_type", "local")
        tools.extend(create_mcp_servers(mcp_servers_config, sandbox_type))

    skill_tool = get_skill_tool(config)
    if skill_tool:
        tools.append(skill_tool)

    if extra_tools:
        tools.extend(extra_tools)

    if tools:
        solver_chain.append(cast(Solver, react(tools=tools)))
    else:
        solver_chain.append(generate())
