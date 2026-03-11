"""Shared helper functions for building task components.

These helpers encapsulate common patterns used across tasks:
- Creating the Dart MCP server
- Building task metadata
- Appending variant-driven solvers (context injection, MCP tools, skills)

All helpers accept a `config` dict (from the run manifest) instead of
TaskConfig, enabling the JSONL + manifest-based execution flow.
"""

from __future__ import annotations

from typing import Any, cast

from inspect_ai.agent import react
from inspect_ai.solver import Solver, generate
from inspect_ai.tool import MCPServer, Tool, mcp_server_stdio, skill

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


def create_mcp_server(config: dict | None = None):
    """
    Create an MCP server tool from config.

    Reads 'mcp_server_command' and 'mcp_server_args' from config.
    Defaults to the Dart MCP server if not specified.

    Args:
        config: Task config with optional 'mcp_server_command' and
                'mcp_server_args' keys.

    Returns:
        MCP server stdio tool.
    """
    config = config or {}
    command = config.get("mcp_server_command", "dart")
    args = config.get("mcp_server_args", ["mcp-server", "--force-roots-fallback"])
    name = config.get("mcp_server_name", "Dart")
    return mcp_server_stdio(
        name=name,
        command=command,
        args=args,
    )


# Backwards-compatible alias
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
    context_files = variant.get("context_files", [])
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
    skill_paths = variant.get("skill_paths", [])
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
    if variant.get("mcp_servers"):
        tools.append(create_mcp_server(config))

    skill_tool = get_skill_tool(config)
    if skill_tool:
        tools.append(skill_tool)

    if extra_tools:
        tools.extend(extra_tools)

    if tools:
        solver_chain.append(cast(Solver, react(tools=tools)))
    else:
        solver_chain.append(generate())
