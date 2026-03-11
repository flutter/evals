"""Solver to add a system message to the conversation."""

from inspect_ai.model import ChatMessageSystem
from inspect_ai.solver import Generate, Solver, TaskState, solver


@solver
def add_system_message(message: str) -> Solver:
    """
    Add a system message without template formatting.

    This avoids the template formatting that system_message() does,
    which would fail on curly braces in the message content (e.g., code examples).

    Args:
        message: The system message content (literal string, no formatting)

    Returns:
        A solver that inserts the system message
    """

    async def solve(state: TaskState, generate: Generate) -> TaskState:
        # Insert system message at the beginning
        state.messages.insert(0, ChatMessageSystem(content=message))
        return state

    return solve
