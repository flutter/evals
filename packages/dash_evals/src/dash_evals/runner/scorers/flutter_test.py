"""Flutter test runner scorer.

Reusable scorer that runs ``flutter test`` and scores based on pass/fail.
"""

from inspect_ai.scorer import Score, Scorer, Target, accuracy, scorer
from inspect_ai.solver import TaskState
from inspect_ai.util import sandbox


@scorer(metrics=[accuracy()])
def flutter_test_scorer(test_path: str = "test/") -> Scorer:
    """
    Score based on Flutter test results.

    Runs ``flutter test`` on the specified path and scores:
    - CORRECT if all tests pass
    - INCORRECT if any tests fail

    Args:
        test_path: Path to test directory or file. Default "test/".

    Returns:
        A Scorer that evaluates code by running Flutter tests.
    """

    async def score(state: TaskState, target: Target) -> Score:
        sb = sandbox()
        workspace = state.metadata.get("workspace")

        if not workspace:
            return Score(
                value=0.0,
                explanation="No workspace found - setup may have failed",
            )

        # Run flutter test
        # Scope to project_dir if set in metadata (for multi-project repos)
        cwd = workspace
        metadata_project_dir = state.metadata.get("project_dir")
        if metadata_project_dir:
            import os

            cwd = os.path.join(workspace, metadata_project_dir)

        result = await sb.exec(
            ["flutter", "test", test_path, "--no-pub"],
            cwd=cwd,
            timeout=180,
        )

        stdout = result.stdout or ""
        stderr = result.stderr or ""
        output = stdout + stderr

        # Parse test results
        test_info = _parse_test_output(output)
        total_tests = test_info["passed"] + test_info["failed"]

        if total_tests == 0:
            return Score(
                value=0.0,
                explanation="No tests found or executed",
                metadata={"test_output": output, "passed": 0, "failed": 0},
            )

        pass_rate = test_info["passed"] / total_tests

        if result.returncode == 0:
            return Score(
                value=1.0,
                explanation=f"All tests passed ({test_info['passed']} tests)",
                metadata={
                    "test_output": output,
                    "passed": test_info["passed"],
                    "failed": 0,
                    "pass_rate": 1.0,
                },
            )
        else:
            return Score(
                value=pass_rate,  # Return actual percentage
                explanation=f"{test_info['passed']}/{total_tests} tests passed ({pass_rate:.0%}):\n{output[:1500]}",
                metadata={
                    "test_output": output,
                    "passed": test_info["passed"],
                    "failed": test_info["failed"],
                    "pass_rate": pass_rate,
                },
            )

    return score


def _parse_test_output(output: str) -> dict:
    """Parse flutter test output to extract pass/fail counts."""
    import re

    # Normalize carriage returns to make regex work on all line endings
    output = output.replace("\r\n", "\n").replace("\r", "\n")

    # Look for patterns like "+3 -1" or "+5"
    # Format: "00:04 +3 -1: Some tests failed" (find the LAST occurrence)
    matches = re.findall(r"\+(\d+)(?:\s+-(\d+))?:", output)

    if matches:
        # Take the last match - this gives the final test counts
        last_match = matches[-1]
        passed = int(last_match[0])
        failed = int(last_match[1]) if last_match[1] else 0
        return {"passed": passed, "failed": failed}

    return {"passed": 0, "failed": 0}
