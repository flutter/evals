"""Scorer for Flutter code quality evaluation."""

from inspect_ai.scorer import Score, Scorer, Target, accuracy, scorer
from inspect_ai.solver import TaskState
from inspect_ai.util import sandbox

from .flutter_output_parser import parse_analyzer_output, parse_test_output
from .flutter_scoring import (
    calculate_analyzer_score,
    calculate_final_score,
    calculate_test_score,
    validate_code_structure,
)


@scorer(metrics=[accuracy()])
def flutter_code_scorer() -> Scorer:
    """
    Custom scorer that evaluates Flutter code based on:

    1. Code analysis (flutter analyze)
    2. Test results (flutter test)
    3. Code structure validation

    The final score is a weighted combination of these factors:

    - Analyzer: 30%
    - Tests: 50%
    - Structure: 20%

    A score >= 0.7 is considered passing for the accuracy metric.

    Returns:
        A Scorer that evaluates Flutter code quality.
    """

    async def score(state: TaskState, target: Target) -> Score:
        # Check for setup errors first
        if setup_error := state.metadata.get("setup_error"):
            return Score(
                value=0.0,
                answer="",
                explanation=f"✗ Setup failed: {setup_error}",
                metadata={"setup_error": setup_error},
            )

        sb = sandbox()
        workspace = state.metadata.get("workspace")

        if not workspace:
            return Score(value=0.0, explanation="No workspace found - setup may have failed")

        explanation_parts = []

        # 1. Run flutter analyze
        analyze_result = await sb.exec(["flutter", "analyze", "--no-pub"], cwd=workspace)

        if analyze_result.success:
            output = analyze_result.stdout + analyze_result.stderr
            analyzer_result = parse_analyzer_output(output)
            analyzer_score, analyzer_explanation = calculate_analyzer_score(analyzer_result)
            explanation_parts.append(analyzer_explanation)
        else:
            analyzer_score = 0.0
            explanation_parts.append("✗ Code analysis failed (syntax errors)")

        # 2. Run flutter test
        test_result = await sb.exec(["flutter", "test", "--no-pub"], cwd=workspace)
        output = test_result.stdout + test_result.stderr
        test_result_parsed = parse_test_output(output, test_result.success)
        test_score, test_explanation = calculate_test_score(test_result_parsed)
        explanation_parts.append(test_explanation)

        # 3. Validate code structure
        code = state.metadata.get("generated_code", "")
        required_widgets = state.metadata.get("required_widgets", [])
        structure_score, structure_explanation = validate_code_structure(code, required_widgets)
        explanation_parts.append(structure_explanation)

        # Calculate final score
        final_score = calculate_final_score(analyzer_score, test_score, structure_score)

        return Score(
            value=final_score,  # Return actual weighted score (0.0-1.0)
            answer=state.output.completion[:200] + "...",
            explanation="\n".join(explanation_parts),
            metadata={
                "analyzer_score": analyzer_score,
                "test_score": test_score,
                "structure_score": structure_score,
                "final_score": final_score,
                "analyzer_output": analyze_result.stdout if analyze_result else "",
                "test_output": test_result.stdout if test_result else "",
            },
        )

    return score
