"""Tests the agent's ability to use the Dart MCP server"""

from inspect_ai import Task, task
from inspect_ai.dataset import Dataset
from inspect_ai.model import ChatMessageSystem
from inspect_ai.scorer import model_graded_fact
from inspect_ai.solver import Generate, Solver, TaskState, solver

from dash_evals.runner.scorers import export_workspace, mcp_tool_usage
from dash_evals.runner.solvers import setup_workspace

from .task_helpers import (
    append_context_injection,
    append_model_interaction,
    build_task_metadata,
)


@solver
def _add_working_dir_system_message() -> Solver:
    """Adds a dynamic system message with the working directory."""

    async def solve(state: TaskState, generate: Generate) -> TaskState:
        working_dir = state.metadata.get("working_dir", "")
        host_workspace = state.metadata.get("host_workspace")

        if host_workspace:
            # Container sandbox
            current_dir = f"/workspace/{working_dir}"
        else:
            # Local sandbox
            current_dir = working_dir

        message = f"""
You are an expert Dart and Flutter developer. Use all the tools available to
you to accomplish the task and ensure the result is free of errors.

The current project directory is {current_dir}

For MCP tools, use the following root path:
file://{current_dir}
"""
        state.messages.insert(0, ChatMessageSystem(content=message.strip()))
        return state

    return solve


@task
def mcp_coding_task(dataset: Dataset, config: dict) -> Task:
    """
    Tests the agent's ability to use the Dart MCP server for generic coding tasks.

    Args:
        dataset: Inspect dataset loaded from JSONL.
        config: Task configuration containing dataset, context, and variant.
    """
    solver_chain = [_add_working_dir_system_message()]

    append_context_injection(solver_chain, config)
    append_model_interaction(solver_chain, config)

    scorers: list = [model_graded_fact(), mcp_tool_usage()]
    if config.get("save_examples"):
        scorers.append(export_workspace())

    return Task(
        name=config["task_name"],
        dataset=dataset,
        setup=[setup_workspace()],
        solver=solver_chain,
        scorer=scorers,
        time_limit=300,
        metadata=build_task_metadata(config),
    )
