"""Solver to write extracted code to the workspace filesystem."""

import tempfile
from pathlib import Path

from inspect_ai.solver import Generate, Solver, TaskState, solver
from inspect_ai.util import sandbox


def _get_sandbox_type(state: TaskState) -> str:
    """Determine sandbox type from workspace path in metadata.

    Returns:
        'container' if workspace is /workspace (podman/docker)
        'local' if workspace is a host filesystem path
        'none' if no workspace is set
    """
    workspace = state.metadata.get("workspace")
    if not workspace:
        return "none"
    if workspace == "/workspace":
        return "container"
    return "local"


async def _write_to_container(state: TaskState, code: str, target_path: str) -> TaskState:
    """Write code to container sandbox at /workspace.

    Container sandboxes are ephemeral, so writing to /workspace is safe.
    """
    sb = sandbox()
    full_path = f"/workspace/{target_path}"
    await sb.write_file(full_path, code)
    return state


async def _write_to_local(state: TaskState, code: str, target_path: str) -> TaskState:
    """Write code to local sandbox temp directory.

    SAFETY: Only writes to temp directories to prevent accidental
    modification of source templates.
    """
    workspace_path_str = state.metadata.get("workspace")

    # This function is only called when sandbox_type is "local", meaning
    # workspace is set and is a host path (not None, not /workspace)
    assert workspace_path_str is not None

    # SAFETY CHECK: Verify workspace is in temp directory
    temp_dir = tempfile.gettempdir()
    if not workspace_path_str.startswith(temp_dir):
        state.metadata["setup_error"] = (
            f"SAFETY: Refusing to write to non-temp directory: {workspace_path_str}. "
            f"Expected path starting with {temp_dir}"
        )
        return state

    sb = sandbox()
    full_path = f"{workspace_path_str}/{target_path}"
    await sb.write_file(full_path, code)
    return state


@solver
def write_to_sandbox(target_path: str = "lib/main.dart") -> Solver:
    """
    Write extracted code from state.store to the workspace.

    This solver reads the "extracted_code" from state.store (set by extract_code)
    and writes it to the specified path in the workspace directory using the sandbox API.

    Dispatches to the appropriate handler based on sandbox type:
    - Container (podman/docker): Write directly to /workspace (ephemeral)
    - Local: Write to temp directory (with safety validation)

    Args:
        target_path: Relative path within workspace to write the code.
                     Default is "lib/main.dart" for Flutter projects.

    Returns:
        A solver that writes extracted code to the workspace.
    """

    async def solve(state: TaskState, generate: Generate) -> TaskState:
        # Early termination if previous solver failed
        if state.metadata.get("setup_error"):
            return state

        # Get extracted code from store (set by extract_code solver)
        code = state.store.get("extracted_code", "")

        if not code:
            # Fallback to metadata for backward compatibility
            code = state.metadata.get("generated_code", "")

        if not code:
            return state

        sandbox_type = _get_sandbox_type(state)

        if sandbox_type == "none":
            # No workspace configured, nothing to do
            return state
        elif sandbox_type == "container":
            return await _write_to_container(state, code, target_path)
        elif sandbox_type == "local":
            return await _write_to_local(state, code, target_path)
        else:
            state.metadata["setup_error"] = f"Unknown sandbox type: {sandbox_type}"
            return state

    return solve
