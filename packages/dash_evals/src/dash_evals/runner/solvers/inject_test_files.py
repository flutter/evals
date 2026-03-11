"""Solver to inject test files into the workspace."""

import glob
from pathlib import Path

from inspect_ai.solver import Solver, TaskState, solver
from inspect_ai.util import sandbox


@solver
def inject_test_files() -> Solver:
    """Inject test files into the workspace.

    Reads test files from the source path and copies them into the workspace
    test directory using the sandbox API. Supports glob patterns like ``tests/*``.
    """

    async def solve(state: TaskState, generate) -> TaskState:
        # Early termination if previous solver failed
        if state.metadata.get("setup_error"):
            return state

        tests_path_str = state.metadata.get("tests")
        workspace_path_str = state.metadata.get("workspace")

        if not tests_path_str:
            return state

        if not workspace_path_str:
            state.metadata["setup_error"] = "No workspace path in metadata"
            return state

        # Expand glob patterns
        test_files = glob.glob(tests_path_str)
        if not test_files:
            # Try as a literal path if glob returns nothing
            tests_path = Path(tests_path_str)
            if not tests_path.exists():
                state.metadata["setup_error"] = f"Test file not found: {tests_path}"
                return state
            test_files = [tests_path_str]

        sb = sandbox()

        for test_file_path in test_files:
            tests_path = Path(test_file_path)
            if not tests_path.is_file():
                continue

            test_content = tests_path.read_text()

            # Prefix with 'sample_' to avoid overwriting existing workspace tests.
            # Files already prefixed are left as-is.
            filename = tests_path.name
            if not filename.startswith("sample_"):
                filename = f"sample_{filename}"

            # Write test file to workspace using sandbox API
            target_path = f"{workspace_path_str}/test/{filename}"
            await sb.write_file(target_path, test_content)

        return state

    return solve
