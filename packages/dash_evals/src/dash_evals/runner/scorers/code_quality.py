"""LLM-graded code quality scorer.

Reusable scorer that uses an LLM to evaluate subjective code quality aspects.
"""

import json
import re

from inspect_ai.model import get_model
from inspect_ai.scorer import Score, Scorer, Target, mean, scorer, stderr
from inspect_ai.solver import TaskState

DEFAULT_RUBRIC = """
Evaluate this code fix on subjective quality (0-3 scale):

1. **Minimality**: Is the fix focused? Does it avoid unnecessary changes?
   - 0: Bloated, touches unrelated code or adds unnecessary complexity
   - 1: Some unnecessary changes but mostly focused
   - 2: Focused with minor extras
   - 3: Surgical, changes only what's needed

2. **Elegance**: Would a senior developer approve of this approach?
   - 0: Hacky, works but ugly or non-idiomatic
   - 1: Works but has style issues
   - 2: Good but not exemplary
   - 3: Clean, idiomatic, follows language conventions

3. **Robustness**: Does it handle edge cases appropriately?
   - 0: Fragile, likely breaks on edge cases
   - 1: Handles basic cases only
   - 2: Handles most edge cases
   - 3: Defensive, handles nulls/empty states/errors gracefully

Respond with ONLY a JSON object (no markdown):
{"minimality": N, "elegance": N, "robustness": N, "reasoning": "Brief explanation"}
"""


@scorer(metrics=[mean(), stderr()])
def code_quality_scorer(rubric: str | None = None, model: str | None = None) -> Scorer:
    """
    Score code quality using LLM judgment.

    Uses a rubric to evaluate subjective aspects of code quality that
    static analysis can't capture: minimality, elegance, robustness.

    Args:
        rubric: Custom rubric prompt. If None, uses default Dart/Flutter rubric.
        model: Model to use for grading. If None, uses the task's model.

    Returns:
        A Scorer that evaluates code quality on a 0-1 scale.
    """
    grading_rubric = rubric or DEFAULT_RUBRIC

    async def score(state: TaskState, target: Target) -> Score:
        code = state.output.completion

        # Build grading prompt
        prompt = f"{grading_rubric}\n\nCode to evaluate:\n```dart\n{code}\n```"

        # Get grader model
        grader = get_model(model) if model else get_model()

        try:
            result = await grader.generate(prompt)
            response_text = result.completion

            # Parse JSON from response
            scores = _parse_json_response(response_text)

            if scores is None:
                return Score(
                    value=0.0,
                    explanation=f"Failed to parse grader response: {response_text[:500]}",
                    metadata={"raw_response": response_text},
                )

            # Calculate normalized score (0-1)
            # Use `or 0` pattern to handle None values (not just missing keys)
            minimality = scores.get("minimality") or 0
            elegance = scores.get("elegance") or 0
            robustness = scores.get("robustness") or 0
            total = minimality + elegance + robustness
            normalized_score = total / 9.0  # Max possible is 9 (3 + 3 + 3)

            return Score(
                value=normalized_score,
                explanation=scores.get("reasoning", "No reasoning provided"),
                metadata={
                    "minimality": minimality,
                    "elegance": elegance,
                    "robustness": robustness,
                    "raw_response": response_text,
                },
            )

        except Exception as e:
            return Score(
                value=0.0,
                explanation=f"Grading failed: {e!s}",
                metadata={"error": str(e)},
            )

    return score


def _parse_json_response(text: str) -> dict | None:
    """Extract JSON from LLM response, handling markdown code blocks."""
    # Try direct parse first
    try:
        return json.loads(text.strip())
    except json.JSONDecodeError:
        pass

    # Try extracting from markdown code block
    match = re.search(r"```(?:json)?\s*(\{.*?\})\s*```", text, re.DOTALL)
    if match:
        try:
            return json.loads(match.group(1))
        except json.JSONDecodeError:
            pass

    # Try finding any JSON object in the text
    match = re.search(r"\{[^{}]*\}", text)
    if match:
        try:
            return json.loads(match.group(0))
        except json.JSONDecodeError:
            pass

    return None
