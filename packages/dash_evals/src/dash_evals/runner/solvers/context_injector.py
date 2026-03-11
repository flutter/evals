"""Solver to inject context files into the conversation."""

from inspect_ai.model import ChatMessageUser
from inspect_ai.solver import Generate, Solver, TaskState, solver


@solver
def context_injector(context_files: list[dict]) -> Solver:
    """
    Inject context files into the conversation.

    This solver inserts context files (like Dart/Flutter best practices) as a user
    message after the system message but before the main prompt.

    Args:
        context_files: List of context file dicts with 'title', 'version', 'content' keys.

    Returns:
        A solver that injects context files into the conversation.
    """

    async def solve(state: TaskState, generate: Generate) -> TaskState:
        if not context_files:
            return state

        # Build context content from all context files
        context_parts = ["## Additional Guidelines\n"]
        for cf in context_files:
            title = cf.get("title", "Untitled")
            version = cf.get("version", "0.0")
            content = cf.get("content", "")
            context_parts.append(f"\n### {title} (v{version})\n")
            context_parts.append(content)

        context_message = "\n".join(context_parts)

        # Insert after system message (index 1) but before user prompt
        state.messages.insert(1, ChatMessageUser(content=context_message))

        return state

    return solve
