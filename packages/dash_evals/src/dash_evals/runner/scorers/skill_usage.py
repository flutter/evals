"""Scorer for verifying skill usage during evaluations."""

from inspect_ai.scorer import Score, Scorer, Target, accuracy, scorer
from inspect_ai.solver import TaskState

# The skill tool name used by Inspect AI's built-in skill() function.
SKILL_TOOL_NAME = "skill"


@scorer(metrics=[accuracy()])
def skill_usage_scorer() -> Scorer:
    """Scorer that checks if the agent used the skill tool.

    Examines the message history to determine whether the model
    actually called the skill tool to read/discover available skills,
    rather than answering from its training data alone.

    Returns:
        A Scorer that returns "C" if the skill tool was used, "I" otherwise.

    Example::

        from dash_evals.runner.scorers import skill_usage_scorer

        Task(
            dataset=my_dataset,
            solver=react(tools=[skill_tool, bash(timeout=120)]),
            scorer=[
                model_graded_fact(),    # Check answer correctness
                skill_usage_scorer(),   # Check skill tool was used
            ],
        )
    """

    async def score(state: TaskState, target: Target) -> Score:
        tools_called: list[str] = []
        skill_call_count = 0

        for message in state.messages:
            if hasattr(message, "tool_calls") and message.tool_calls:
                for tool_call in message.tool_calls:
                    tool_name = tool_call.function
                    tools_called.append(tool_name)
                    if tool_name == SKILL_TOOL_NAME:
                        skill_call_count += 1

        skill_tool_used = skill_call_count > 0
        if skill_tool_used:
            explanation = f"Skill tool was used ({skill_call_count} call(s))"
        else:
            explanation = (
                f"Skill tool was NOT used. "
                f"All tools called: {tools_called if tools_called else 'none'}"
            )

        return Score(
            value="C" if skill_tool_used else "I",
            answer=f"{skill_call_count} skill call(s)",
            explanation=explanation,
            metadata={
                "skill_tool_used": skill_tool_used,
                "skill_call_count": skill_call_count,
                "all_tools_called": tools_called,
            },
        )

    return score
