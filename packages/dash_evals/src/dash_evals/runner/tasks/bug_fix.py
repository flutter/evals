"""
Bug Fix Task (Generic, Agentic)

Evaluates LLM ability to diagnose and fix bugs in existing code using
an agentic approach where the model can explore files and make edits.

This task behaves similarly to real-world AI coding assistants like Claude Code
and Cursor. Language-specific behavior (system message, scorers) is controlled
via the config dict or thin wrappers (e.g., `flutter_bug_fix`).
"""

from textwrap import dedent
from typing import cast

from inspect_ai import Task, task
from inspect_ai.agent import react
from inspect_ai.dataset import Dataset
from inspect_ai.solver import Solver
from inspect_ai.tool import bash_session, text_editor

from dash_evals.runner.scorers import (
    code_quality_scorer,
    dart_analyze_scorer,
    export_workspace,
    flutter_test_scorer,
)
from dash_evals.runner.solvers import add_system_message, inject_test_files, setup_workspace

from .task_helpers import (
    append_context_injection,
    build_task_metadata,
    get_skill_tool,
    validate_sandbox_tools,
)

# ============================================================================
# Default System Messages
# ============================================================================

DEFAULT_BUG_FIX_PROMPT = dedent("""\
    You are an expert developer debugging a production issue.

    Your task is to:

    1. Explore the codebase to understand the structure
    2. Identify the root cause of the bug
    3. Fix the bug by editing the necessary file(s)
    4. Verify your fix passes any tests and static analysis
    5. If there are any errors or warnings at all, fix them
    6. When done, call submit() with a brief explanation of what you fixed
""")

FLUTTER_BUG_FIX_PROMPT = dedent("""\
    You are an expert Flutter developer debugging a production issue.

    Your task is to:

    1. Explore the codebase to understand the structure
    2. Identify the root cause of the bug
    3. Fix the bug by editing the necessary file(s)
    4. Verify your fix passes any tests and static analysis. Be sure to run
       dart analyze in the directory containing the pubspec.yaml for the
       package you modified, not the workspace root.
    5. If there are any errors or warnings at all, fix them.
    6. When done, call submit() with a brief explanation of what you fixed
""")


# ============================================================================
# Solver Builder
# ============================================================================


def _build_solver_chain(config: dict, system_message: str) -> list:
    """Build the solver chain for bug fix tasks."""
    solver_chain = []

    solver_chain.append(add_system_message(system_message))

    append_context_injection(solver_chain, config)

    tools = [
        bash_session(timeout=120),
        text_editor(timeout=60),
    ]
    skill_tool = get_skill_tool(config)
    if skill_tool:
        tools.append(skill_tool)

    agent_name = config.get("agent_name", "debugger")
    agent_description = config.get(
        "agent_description",
        "Expert developer who debugs and fixes code issues.",
    )

    solver_chain.append(
        cast(
            Solver,
            react(
                name=agent_name,
                description=agent_description,
                tools=tools,
            ),
        )
    )

    return solver_chain


# ============================================================================
# Generic Task
# ============================================================================


@task
def bug_fix(dataset: Dataset, config: dict) -> Task:
    """
    Generic task for evaluating LLM ability to diagnose and fix bugs.

    The config dict controls language-specific behavior:
    - system_message: Custom system prompt (optional)
    - agent_name: Name for the react agent (default: "debugger")
    - agent_description: Description for the react agent (optional)
    - scorers: List of scorer instances (optional, defaults to dart analyzers)

    Args:
        dataset: Inspect dataset loaded from JSONL.
        config: Task manifest entry with variant, system_message, etc.
    """
    system_message = config.get("system_message") or DEFAULT_BUG_FIX_PROMPT

    validate_sandbox_tools(config, ["bash_session", "text_editor"])

    solver_chain = _build_solver_chain(config, system_message)

    scorers: list = config.get(
        "scorers",
        [
            dart_analyze_scorer(),
            code_quality_scorer(),
        ],
    )
    if config.get("save_examples"):
        scorers.append(export_workspace())

    return Task(
        name=config["task_name"],
        dataset=dataset,
        setup=[setup_workspace(), inject_test_files()],
        solver=solver_chain,
        scorer=scorers,
        time_limit=config.get("time_limit", 600),
        metadata=build_task_metadata(config),
    )


# ============================================================================
# Flutter Thin Wrapper
# ============================================================================


@task
def flutter_bug_fix(dataset: Dataset, config: dict) -> Task:
    """
    Flutter-specific bug fix task.

    Thin wrapper around bug_fix() with Flutter defaults:
    - Flutter system message
    - Flutter-specific scorers (dart_analyze, flutter_test, code_quality)

    Args:
        dataset: Inspect dataset loaded from JSONL.
        config: Task manifest entry with variant, system_message, etc.
    """
    flutter_config = {
        "system_message": FLUTTER_BUG_FIX_PROMPT,
        "agent_name": "flutter_debugger",
        "agent_description": "Expert Flutter developer who debugs and fixes code issues.",
        **config,
    }
    if "scorers" not in config:
        scorers: list = [
            dart_analyze_scorer(),
            flutter_test_scorer(),
            code_quality_scorer(),
        ]
        if config.get("save_examples"):
            scorers.append(export_workspace())
        flutter_config["scorers"] = scorers

    return bug_fix(dataset, flutter_config)
