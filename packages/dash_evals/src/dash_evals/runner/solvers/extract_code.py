"""Solver to extract code from markdown responses."""

from inspect_ai.solver import Generate, Solver, TaskState, solver

from dash_evals.utils.markdown import extract_code_from_markdown


@solver
def extract_code(language: str = "dart") -> Solver:
    """
    Extract code from the model's markdown response and store it.

    This is a pure solver that extracts code and stores it in state.store
    without any filesystem side effects. Use write_to_sandbox() to write
    the extracted code to the sandbox.

    Args:
        language: The programming language to extract (default: "dart")

    Returns:
        A solver that extracts code and stores it in state.store["extracted_code"]
    """

    async def solve(state: TaskState, generate: Generate) -> TaskState:
        code = state.output.completion
        extracted = extract_code_from_markdown(code, language=language)

        # Store in both state.store and state.metadata for compatibility
        state.store.set("extracted_code", extracted)
        state.metadata["generated_code"] = extracted

        return state

    return solve
