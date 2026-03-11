"""QA tasks for evaluating model Q&A capabilities."""

from textwrap import dedent

from inspect_ai import Task, task
from inspect_ai.dataset import Dataset
from inspect_ai.scorer import model_graded_fact
from inspect_ai.solver import chain_of_thought

from ..solvers import add_system_message
from .task_helpers import (
    append_context_injection,
    append_model_interaction,
    build_task_metadata,
)

DEFAULT_QA_SYSTEM_MESSAGE = dedent("""
    You are a helpful and knowledgeable coding assistant.
    Answer questions clearly and accurately, providing examples when helpful.
""")


def _build_qa_solver(system_msg: str, config: dict):
    """
    Build solver chain for QA tasks.

    Includes chain_of_thought for improved reasoning.
    """
    solver_chain = [add_system_message(system_msg)]
    append_context_injection(solver_chain, config)
    solver_chain.append(chain_of_thought())
    append_model_interaction(solver_chain, config)

    return solver_chain


@task
def question_answer(dataset: Dataset, config: dict) -> Task:
    """
    Generic QA task for evaluating model Q&A capabilities.

    Args:
        dataset: Inspect dataset loaded from JSONL.
        config: Task manifest entry with variant, system_message, etc.
    """
    system_msg = config.get("system_message") or DEFAULT_QA_SYSTEM_MESSAGE

    solver = _build_qa_solver(system_msg, config)

    return Task(
        name=config["task_name"],
        dataset=dataset,
        solver=solver,
        scorer=model_graded_fact(),
        time_limit=300,
        metadata=build_task_metadata(config),
    )
