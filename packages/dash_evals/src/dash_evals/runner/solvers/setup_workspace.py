"""Solver to set up a clean workspace by copying template to temp directory.

CRITICAL: This solver MUST run first. It copies the template to a temp directory
to ensure we NEVER modify the original template. Other solvers should check for
'setup_error' in metadata and terminate early if set.
"""

import shutil
import tempfile
from pathlib import Path

from inspect_ai.solver import Solver, TaskState, solver
from inspect_ai.util import sandbox


def _get_sandbox_type(state: TaskState) -> str:
    """Determine sandbox type from workspace config in metadata.

    Returns:
        'git' if workspace_git is set (clone at runtime)
        'container' if workspace is /workspace (podman/docker)
        'local' if workspace is a host filesystem path
        'none' if no workspace is set
    """
    # Check for git workspace first
    if state.metadata.get("workspace_git"):
        return "git"

    workspace = state.metadata.get("workspace")
    if not workspace:
        return "none"
    if workspace == "/workspace":
        return "container"
    return "local"


async def _setup_container_workspace(state: TaskState) -> TaskState:
    """Handle container sandbox setup (podman/docker).

    For container sandboxes, Sample.files and Sample.setup already handle:
    - Copying workspace files to /workspace in container
    - Running flutter pub get

    This function just validates the setup is correct.
    """
    workspace = state.metadata.get("workspace")

    if workspace != "/workspace":
        state.metadata["setup_error"] = (
            f"Container workspace expected at /workspace, got: {workspace}"
        )

    # Nothing to do - Sample.files/Sample.setup handled everything
    return state


async def _setup_local_workspace(state: TaskState) -> TaskState:
    """Handle local sandbox setup.

    For local sandboxes:
    1. Copy template to temp directory (isolation)
    2. Run flutter pub get to resolve dependencies
    3. Update metadata['workspace'] to point to the copy
    """
    template_path_str = state.metadata.get("workspace")

    # This function is only called when sandbox_type is "local", meaning
    # workspace is set and is a host path (not None, not /workspace)
    assert template_path_str is not None

    template_path = Path(template_path_str)

    # Validate template exists
    if not template_path.exists():
        state.metadata["setup_error"] = f"Template not found: {template_path}"
        return state

    # Create temp directory and copy template into it
    # Ignore build artifacts and other generated files
    temp_dir = tempfile.mkdtemp(prefix="eval_workspace_")
    workspace_copy = Path(temp_dir) / template_path.name

    ignore_patterns = shutil.ignore_patterns(
        "build",  # Flutter/Dart build output
        ".dart_tool",  # Dart SDK internal
        ".packages",  # Legacy package resolution
        ".flutter-plugins*",  # Flutter plugin resolution
        "*.iml",  # IDE files
        ".idea",  # IntelliJ IDEA
        ".vscode",  # VS Code settings
        "*.g.dart",  # Generated code
        "*.freezed.dart",  # Freezed generated
        "*.mocks.dart",  # Mockito generated
    )
    shutil.copytree(template_path, workspace_copy, ignore=ignore_patterns)

    # Update metadata to point to the copy
    state.metadata["workspace"] = str(workspace_copy)
    state.metadata["workspace_template"] = template_path_str  # Keep original reference

    # Run dependency install command to resolve deps in the copied workspace.
    # This is required because the .dart_tool and .packages files contain
    # absolute paths that are invalid after copying to a new location.
    dep_cmd = state.metadata.get("dep_install_cmd", ["flutter", "pub", "get"])
    sb = sandbox()
    dep_result = await sb.exec(
        dep_cmd,
        cwd=str(workspace_copy),
    )

    if not dep_result.success:
        cmd_str = " ".join(dep_cmd)
        state.metadata["setup_error"] = f"{cmd_str} failed: {dep_result.stderr}"
        return state

    return state


@solver
def setup_workspace() -> Solver:
    """Copy workspace template to a temp directory for isolated execution.

    Dispatches to the appropriate setup handler based on sandbox type:
    - Git: Clone repository inside sandbox
    - Container (podman/docker): Sample.files handles provisioning, just validate
    - Local: Copy template to temp dir and run flutter pub get

    If setup fails, sets metadata['setup_error']. Subsequent solvers MUST
    check for this and terminate early to prevent writing to the original
    template directory.
    """

    async def solve(state: TaskState, generate) -> TaskState:
        sandbox_type = _get_sandbox_type(state)

        if sandbox_type == "none":
            # No workspace configured, nothing to do
            return state
        elif sandbox_type == "git":
            return await _setup_git_workspace(state)
        elif sandbox_type == "container":
            return await _setup_container_workspace(state)
        elif sandbox_type == "local":
            return await _setup_local_workspace(state)
        else:
            state.metadata["setup_error"] = f"Unknown sandbox type: {sandbox_type}"
            return state

    return solve


async def _setup_git_workspace(state: TaskState) -> TaskState:
    """Clone git repository inside sandbox.

    For git workspaces:
    1. git clone <url> /workspace
    2. git checkout <ref> (if specified)

    Dependency resolution (pub get) is left to the model, since git repos
    may be monorepos where the agent needs to navigate to the correct
    subdirectory before running pub get.
    """
    git_url = state.metadata.get("workspace_git")
    git_ref = state.metadata.get("workspace_git_ref")
    workspace = "/workspace"

    # Type guard: git_url should always be set when this function is called
    if not git_url or not isinstance(git_url, str):
        state.metadata["setup_error"] = "workspace_git not set or invalid"
        return state

    sb = sandbox()

    # Clone repository
    result = await sb.exec(["git", "clone", git_url, workspace])
    if not result.success:
        state.metadata["setup_error"] = f"git clone failed: {result.stderr}"
        return state

    # Checkout specific ref if provided
    if git_ref and isinstance(git_ref, str):
        result = await sb.exec(["git", "checkout", git_ref], cwd=workspace)
        if not result.success:
            state.metadata["setup_error"] = f"git checkout failed: {result.stderr}"
            return state

    # Set workspace path in metadata for downstream solvers/scorers
    state.metadata["workspace"] = workspace
    return state
