"""
MCP Tool Usage Task (Unified)

Tests an agent's ability to use a specific MCP server tool. Consolidates the
former `mcp_create_project` and `mcp_pub_dev_search` tasks into a single
configurable task.

Config keys:
    required_tools: list[str] — MCP tool names the agent should use (for scoring)
    inject_temp_dir: bool — if True, replace {root_path} in sample inputs with a
                     temp directory (needed for create_project-style tasks)
"""

import tempfile

from inspect_ai import Task, task
from inspect_ai.dataset import Dataset, MemoryDataset, Sample
from inspect_ai.scorer import includes

from ..scorers import mcp_tool_usage
from ..solvers import add_system_message
from .task_helpers import (
    append_context_injection,
    append_model_interaction,
    build_task_metadata,
)


@task
def mcp_tool(dataset: Dataset, config: dict) -> Task:
    """
    Unified task for evaluating MCP tool usage.

    Args:
        dataset: Inspect dataset loaded from JSONL.
        config: Task manifest entry with:
            - required_tools: list of MCP tool names the agent should call
            - inject_temp_dir: if True, replaces {root_path} in inputs
            - system_message: custom system prompt (optional)
    """
    required_tools = config.get("required_tools", [])
    inject_temp_dir = config.get("inject_temp_dir", False)

    # Pre-process samples if temp directory injection is needed
    active_dataset = dataset
    if inject_temp_dir:
        temp_root = tempfile.mkdtemp(prefix="mcp_tool_")
        processed_samples = []
        for sample in dataset:
            input_str = sample.input if isinstance(sample.input, str) else str(sample.input)
            processed_samples.append(
                Sample(
                    input=input_str.replace("{root_path}", temp_root),
                    target=sample.target,
                    id=sample.id,
                    metadata=sample.metadata,
                )
            )
        active_dataset = MemoryDataset(
            samples=processed_samples,
            name=config.get("task_name", "mcp_tool"),
        )

    # Build solver chain
    system_msg = config.get("system_message", "You are a helpful assistant.")
    solver_chain = [add_system_message(system_msg)]
    append_context_injection(solver_chain, config)
    append_model_interaction(solver_chain, config)

    return Task(
        name=config["task_name"],
        dataset=active_dataset,
        solver=solver_chain,
        scorer=[
            includes(ignore_case=True),
            mcp_tool_usage(required_tools=required_tools if required_tools else None),
        ],
        time_limit=config.get("time_limit", 300),
        message_limit=config.get("message_limit", 50),
        metadata=build_task_metadata(config),
    )
