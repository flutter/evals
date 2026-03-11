"""Scorer that exports the final workspace to the examples directory.

This scorer is a side-effect scorer: it copies the agent's finished workspace
to <log_dir>/examples/<task_id>:<variant>/<sample_id>/ so eval authors can
inspect the exact code produced during a run.

It is only added to a Task's scorer list when task_config.save_examples=True,
so it can assume it should always run — no runtime guard needed.

== How It Works ==

Scorers run while the sandbox container is still alive. We use the sandbox
API to create a tar archive of /workspace inside the container, read it out
via sandbox().read_file(), then extract it on the host into examples_dir.

This scorer must run LAST in the scorer list so it captures the final state
of the workspace after all code edits are complete.
"""

import io
import tarfile
from pathlib import Path

from inspect_ai.scorer import CORRECT, Score, Scorer, Target, scorer
from inspect_ai.solver import TaskState
from inspect_ai.util import sandbox

# Paths to exclude from the exported workspace copy (passed to tar --exclude).
_TAR_EXCLUDES = [
    "./build",
    "./.dart_tool",
    "./.packages",
    "./.flutter-plugins",
    "./.flutter-plugins-dependencies",
    "./.git",
    "./.idea",
    "./.vscode",
    "./pubspec.lock",
    # Generated Dart code
    "./**/*.g.dart",
    "./**/*.freezed.dart",
    "./**/*.mocks.dart",
]


@scorer(metrics=[])
def export_workspace() -> Scorer:
    """Copy the final workspace to the examples directory alongside logs.

    Reads ``examples_dir`` and ``save_examples`` from ``state.metadata``.
    Uses the sandbox API to tar the workspace inside the container and
    extract it on the host — works with any sandbox type (podman/docker).

    The destination path is::

        <examples_dir>/<task_id>:<variant>/<sample_id>/

    This scorer is only added to the Task scorer list when
    ``task_config.save_examples=True``, so it always runs unconditionally.
    """

    async def score(state: TaskState, target: Target) -> Score:
        workspace = state.metadata.get("workspace")
        examples_dir = state.metadata.get("examples_dir")

        if not examples_dir:
            return Score(
                value=CORRECT,
                explanation="examples_dir not set in metadata — skipping export",
            )

        if not workspace:
            return Score(
                value=CORRECT,
                explanation="No workspace in metadata — nothing to export",
            )

        # Build the destination path: examples/<task_variant>/<sample_id>/
        task_variant = state.metadata.get("task_variant", "unknown")
        sample_id = str(state.sample_id) if state.sample_id is not None else "unknown"
        dest = Path(examples_dir) / task_variant / sample_id

        try:
            dest.mkdir(parents=True, exist_ok=True)
            await _export_via_sandbox(workspace, dest)
        except Exception as e:
            return Score(
                value=CORRECT,
                explanation=f"Export failed (non-fatal): {e}",
                metadata={"export_error": str(e)},
            )

        return Score(
            value=CORRECT,
            explanation=f"Workspace exported to {dest}",
            metadata={"exported_to": str(dest)},
        )

    return score


async def _export_via_sandbox(workspace: str, dest: Path) -> None:
    """Archive workspace inside the container, read the tar, extract on host.

    Args:
        workspace: Absolute path to the workspace directory inside the container.
        dest: Host-side destination directory to extract into.

    Raises:
        RuntimeError: If the tar command fails inside the container.
    """
    exclude_args = []
    for pattern in _TAR_EXCLUDES:
        exclude_args.extend(["--exclude", pattern])

    # Create a tar archive of the workspace inside the container.
    # Write to a temp file inside the container so we can read_file() it.
    archive_path = "/tmp/_export_workspace.tar"
    result = await sandbox().exec(["tar", "-cf", archive_path, *exclude_args, "-C", workspace, "."])
    if not result.success:
        raise RuntimeError(f"tar failed inside container: {result.stderr}")

    # Read the tar bytes out through the sandbox API.
    tar_bytes = await sandbox().read_file(archive_path, text=False)

    # Extract on the host.
    with tarfile.open(fileobj=io.BytesIO(tar_bytes)) as tf:
        tf.extractall(dest, filter="data")

    # Clean up the temp archive inside the container (best-effort).
    await sandbox().exec(["rm", "-f", archive_path])
