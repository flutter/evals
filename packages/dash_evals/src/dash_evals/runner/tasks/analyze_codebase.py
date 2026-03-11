"""
Analyze Codebase Task

Evaluates LLM ability to explore and answer questions about an existing codebase.
The model gets read-only access to workspace files via bash commands,
but is instructed not to modify any files.
"""

from textwrap import dedent
from typing import cast

from inspect_ai import Task, task
from inspect_ai.agent import react
from inspect_ai.dataset import Dataset
from inspect_ai.model import ChatMessageSystem
from inspect_ai.scorer import model_graded_fact
from inspect_ai.solver import Generate, Solver, TaskState, solver
from inspect_ai.tool import bash

from dash_evals.runner.scorers import export_workspace
from dash_evals.runner.solvers import setup_workspace

from .task_helpers import (
    append_context_injection,
    build_task_metadata,
    get_skill_tool,
)

DEFAULT_ANALYZE_SYSTEM_MESSAGE = dedent("""\
    You are an expert code reviewer analyzing a codebase.

    Your task is to:

    1. Explore the codebase at {workspace} using the available tools
    2. Understand the project structure, dependencies, and architecture
    3. Answer the user's question based on what you find in the code

    Important guidelines:
    - Use bash commands (cat, find, grep, ls, head, tail, etc.) to browse files
    - Do NOT edit or modify any files
    - Base your answer on actual code you find, not assumptions
    - Reference specific files and line numbers when relevant
    - When done, call submit() with your complete answer
""")


@solver
def _add_workspace_system_message(template: str) -> Solver:
    """Add system message with workspace path substituted from metadata."""

    async def solve(state: TaskState, generate: Generate) -> TaskState:
        workspace = state.metadata.get("workspace", "/workspace")
        message = template.format(workspace=workspace)
        state.messages.insert(0, ChatMessageSystem(content=message))
        return state

    return solve


def _build_solver_chain(config: dict, system_message: str) -> list:
    """Build the solver chain for analyze codebase tasks."""
    solver_chain = []

    solver_chain.append(_add_workspace_system_message(system_message))

    append_context_injection(solver_chain, config)

    tools = [
        bash(timeout=120),
    ]
    skill_tool = get_skill_tool(config)
    if skill_tool:
        tools.append(skill_tool)

    solver_chain.append(
        cast(
            Solver,
            react(
                name="code_analyzer",
                description="Expert code reviewer who explores and analyzes codebases.",
                tools=tools,
            ),
        )
    )

    return solver_chain


@task
def analyze_codebase(dataset: Dataset, config: dict) -> Task:
    """
    Task for evaluating LLM ability to explore and answer questions about a codebase.

    Args:
        dataset: Inspect dataset loaded from JSONL.
        config: Task manifest entry with variant, system_message, etc.
    """
    system_message = config.get("system_message") or DEFAULT_ANALYZE_SYSTEM_MESSAGE

    solver_chain = _build_solver_chain(config, system_message)

    scorers: list = [model_graded_fact()]
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
