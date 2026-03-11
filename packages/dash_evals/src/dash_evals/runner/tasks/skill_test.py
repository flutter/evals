"""
Skill Test Task

Evaluates whether the agent discovers and applies specific skills provided
to it. This task is designed to allow the agent to use the skill tool if
provided, and the scorer checks if the tool was utilized appropriately when
skills are available.

Requires a sandbox since Inspect AI's skill() tool copies skill directories
into the sandbox filesystem.
"""

from textwrap import dedent
from typing import cast

from inspect_ai import Task, task
from inspect_ai.agent import react
from inspect_ai.dataset import Dataset
from inspect_ai.scorer import model_graded_fact
from inspect_ai.solver import Solver
from inspect_ai.tool import bash

from dash_evals.runner.scorers import export_workspace, skill_usage_scorer
from dash_evals.runner.solvers import add_system_message, setup_workspace

from .task_helpers import (
    append_context_injection,
    build_task_metadata,
    get_skill_tool,
)

DEFAULT_SKILL_TEST_SYSTEM_MESSAGE = dedent("""\
    You are an expert developer solving a task.

    You MAY be provided with agent skills — folders of instructions,
    scripts, and resources that will help you complete this task more
    accurately and efficiently.

    Your approach should be:

    1. First, use the skill tool to discover available skills
    2. Read the SKILL.md file(s) to understand the guidance provided
    3. Apply the skill instructions to complete the user's task
    4. When done, call submit() with your answer

    Important:
    - Base your answer on the skill content, not just your training data
    - Reference specific guidance from the Skills (if available) in your response
""")


def _build_solver_chain(config: dict, system_message: str) -> list:
    """Build the solver chain for skill test tasks."""
    solver_chain = []

    solver_chain.append(add_system_message(system_message))

    append_context_injection(solver_chain, config)

    # Build tools list — skill tool is required for this task type
    skill_tool = get_skill_tool(config)

    tools = [bash(timeout=120)]
    if skill_tool is not None:
        tools.append(skill_tool)

    # Add the react agent with bash (and optionally skill) tool
    solver_chain.append(
        cast(
            Solver,
            react(
                name="skill_tester",
                description="Developer who discovers and applies agent skills to complete tasks.",
                tools=tools,
            ),
        )
    )

    return solver_chain


@task
def skill_test(dataset: Dataset, config: dict) -> Task:
    """Task for evaluating whether an agent correctly uses provided skills.

    This task is specifically designed to test skill discovery and application.
    If skills are provided, the agent may:

    1. Use the skill tool to discover available skills
    2. Read and understand the skill instructions
    3. Apply the skill guidance to answer the user's question
    4. Submit an answer that reflects skill-based knowledge

    The scorer checks both answer quality (model_graded_fact) and, if skills
    are present, whether the skill tool was actually used (skill_usage_scorer).

    Args:
        dataset: Inspect dataset loaded from JSONL.
        config: Task manifest entry with variant, system_message, etc.
    """
    system_message = config.get("system_message") or DEFAULT_SKILL_TEST_SYSTEM_MESSAGE

    solver_chain = _build_solver_chain(config, system_message)

    scorers: list = [
        model_graded_fact(),  # Answer quality
    ]
    if get_skill_tool(config) is not None:
        scorers.append(skill_usage_scorer())  # Verify skill tool was actually used
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
