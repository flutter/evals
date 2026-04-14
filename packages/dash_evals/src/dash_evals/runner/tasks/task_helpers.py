"""Shared helper functions for building task components.

These helpers encapsulate common patterns used across tasks:
- Creating MCP servers from variant config
- Building task metadata
- Appending variant-driven solvers (context injection, MCP tools, skills)

All helpers accept a `config` dict (from the run manifest) instead of
TaskConfig, enabling the JSONL + manifest-based execution flow.
"""

from __future__ import annotations

from typing import cast

# Re-export config-interpretation helpers from the shared package.
# These are the single source of truth for interpreting config dicts
# as Inspect AI objects; both dash_evals and yardstick use them.
from dataset_config_python.hydrate import (  # noqa: F401
    build_task_metadata,
    create_mcp_servers,
    get_skill_tool,
)
from inspect_ai.agent import react
from inspect_ai.solver import Solver, generate
from inspect_ai.tool import (
    MCPServer,
    Tool,
    mcp_server_stdio,
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


def append_context_injection(solver_chain: list, config: dict) -> None:
    """Append context injection solver if the variant has context files.

    Args:
        solver_chain: The solver chain list to append to.
        config: Task manifest entry with 'variant' key or 'metadata' key.
    """
    metadata = config.get("metadata", {})
    variant = metadata.get("variant_config")
    if variant is None:
        variant = config.get("variant", {})

    # If variant is still just a name string, we can't extract files from it.
    if isinstance(variant, str):
        return

    # Support both old "context_files" and new "files" key
    context_files = variant.get("files") or variant.get("context_files", [])
    if context_files:
        solver_chain.append(context_injector(context_files))


def append_model_interaction(
    solver_chain: list,
    config: dict,
    *,
    extra_tools: list | None = None,
) -> None:
    """Append either a react agent (with MCP tools) or plain generate.

    Args:
        solver_chain: The solver chain list to append to.
        config: Task manifest entry with 'variant' key or 'metadata' key.
        extra_tools: Additional tools to include alongside MCP (optional).
    """
    tools: list[Tool | MCPServer] = []
    metadata = config.get("metadata", {})
    variant = metadata.get("variant_config")
    if variant is None:
        variant = config.get("variant", {})

    mcp_servers_config = []
    if not isinstance(variant, str):
        mcp_servers_config = variant.get("mcp_servers", [])

    if mcp_servers_config:
        sandbox_type = config.get("sandbox_type", "local")
        tools.extend(cast(list[Tool | MCPServer], create_mcp_servers(mcp_servers_config, sandbox_type)))

    skill_tool = get_skill_tool(config)
    if skill_tool:
        tools.append(cast(Tool | MCPServer, skill_tool))

    if extra_tools:
        tools.extend(extra_tools)

    if tools:
        solver_chain.append(cast(Solver, react(tools=tools)))
    else:
        solver_chain.append(generate())
