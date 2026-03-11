"""Tests for the export_workspace scorer.

These tests mock the sandbox API so that the scorer's tar-based export logic
can be exercised without a real container.
"""

import asyncio
import io
import tarfile
from pathlib import Path
from unittest.mock import AsyncMock, MagicMock, patch

from dash_evals.runner.scorers.export_workspace import export_workspace

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------


def _make_state(
    workspace: str | None,
    examples_dir: str | None,
    task_variant: str = "my-task:baseline",
) -> MagicMock:
    """Build a minimal mock TaskState for the scorer tests."""
    state = MagicMock()
    state.metadata = {
        k: v
        for k, v in {
            "workspace": workspace,
            "examples_dir": examples_dir,
            "save_examples": True,
            "task_variant": task_variant,
        }.items()
        if v is not None
    }
    state.sample_id = "sample-001"
    return state


def _build_mock_sandbox(workspace_path: str, excludes: list[str] | None = None):
    """Build a mock sandbox whose exec() creates a real tar from the host filesystem.

    This simulates what happens inside the container: tar -cf the workspace,
    then read_file returns the tar bytes.
    """
    mock_sb = AsyncMock()

    # The tar bytes produced by exec() — stored here so read_file() can return them.
    _tar_bytes: dict[str, bytes] = {}

    async def fake_exec(cmd: list[str]):
        """Simulate: tar -cf <archive> --exclude ... -C <workspace> ."""
        result = MagicMock()
        # Parse the command to find -C <dir> and the archive path.
        # Expected form: ["tar", "-cf", archive_path, ...excludes..., "-C", workspace, "."]
        if cmd[0] == "rm":
            result.success = True
            return result

        archive_path = cmd[2]
        # Find -C index
        try:
            c_idx = cmd.index("-C")
            src_dir = Path(cmd[c_idx + 1])
        except (ValueError, IndexError):
            result.success = False
            result.stderr = "could not parse -C from command"
            return result

        if not src_dir.exists():
            result.success = False
            result.stderr = f"tar: {src_dir}: No such file or directory"
            return result

        # Collect --exclude patterns
        excludes_set: set[str] = set()
        i = 0
        while i < len(cmd):
            if cmd[i] == "--exclude":
                excludes_set.add(cmd[i + 1])
                i += 2
            else:
                i += 1

        # Build a real tar in memory
        buf = io.BytesIO()
        with tarfile.open(fileobj=buf, mode="w") as tf:
            for p in sorted(src_dir.rglob("*")):
                rel = p.relative_to(src_dir)
                arc_name = f"./{rel}"
                # Check excludes (simple prefix match)
                skip = False
                for excl in excludes_set:
                    if arc_name.startswith(excl):
                        skip = True
                        break
                if skip:
                    continue
                tf.add(str(p), arcname=arc_name)

        _tar_bytes[archive_path] = buf.getvalue()
        result.success = True
        result.stderr = ""
        return result

    async def fake_read_file(path: str, text: bool = True):
        return _tar_bytes.get(path, b"")

    mock_sb.exec = fake_exec
    mock_sb.read_file = fake_read_file
    return mock_sb


async def _run_scorer(workspace, examples_dir, task_variant="my-task:baseline", mock_sb=None):
    """Helper: run the scorer with the given args and return the Score."""
    state = _make_state(workspace, examples_dir, task_variant)
    target = MagicMock()
    scorer = export_workspace()

    if mock_sb is not None:
        with patch(
            "dash_evals.runner.scorers.export_workspace.sandbox",
            return_value=mock_sb,
        ):
            return await scorer(state, target)
    else:
        # No sandbox mock — used for tests that don't reach _export_via_sandbox
        # (e.g. missing metadata keys). We still need to patch sandbox to avoid
        # real sandbox lookup errors on the off-chance execution reaches it.
        mock_fallback = AsyncMock()
        mock_fallback.exec = AsyncMock(side_effect=RuntimeError("no sandbox"))
        with patch(
            "dash_evals.runner.scorers.export_workspace.sandbox",
            return_value=mock_fallback,
        ):
            return await scorer(state, target)


# ---------------------------------------------------------------------------
# Factory tests
# ---------------------------------------------------------------------------


class TestExportWorkspaceFactory:
    """Tests for the export_workspace scorer factory."""

    def test_returns_callable(self):
        """export_workspace() should return a callable scorer."""
        result = export_workspace()
        assert callable(result)


# ---------------------------------------------------------------------------
# Scorer behaviour tests
# ---------------------------------------------------------------------------


class TestExportWorkspaceScorer:
    """Tests for the export_workspace scorer inner logic."""

    def test_copies_workspace_to_examples_dir(self, tmp_path: Path):
        """Should copy workspace contents to examples_dir/<task_variant>/<sample_id>/."""
        workspace = tmp_path / "eval_workspace_abc123" / "my_flutter_app"
        workspace.mkdir(parents=True)
        (workspace / "pubspec.yaml").write_text("name: my_app")
        (workspace / "lib").mkdir()
        (workspace / "lib" / "main.dart").write_text("void main() {}")

        examples_dir = tmp_path / "logs" / "examples"
        mock_sb = _build_mock_sandbox(str(workspace))

        score = asyncio.run(_run_scorer(str(workspace), str(examples_dir), mock_sb=mock_sb))

        assert score is not None

        dest = examples_dir / "my-task:baseline" / "sample-001"
        assert dest.exists()
        assert (dest / "pubspec.yaml").exists()
        assert (dest / "lib" / "main.dart").exists()

    def test_returns_score_when_no_examples_dir(self):
        """Should return a score gracefully when examples_dir is not in metadata."""
        score = asyncio.run(_run_scorer(workspace="/tmp/some_workspace", examples_dir=None))

        assert score is not None
        assert "examples_dir not set" in (score.explanation or "")

    def test_returns_score_when_no_workspace(self, tmp_path: Path):
        """Should return a score gracefully when workspace is not in metadata."""
        score = asyncio.run(_run_scorer(workspace=None, examples_dir=str(tmp_path / "examples")))

        assert score is not None
        assert "No workspace" in (score.explanation or "")

    def test_returns_score_when_workspace_path_missing(self, tmp_path: Path):
        """Should return a score gracefully when workspace path doesn't exist on disk."""
        mock_sb = _build_mock_sandbox(str(tmp_path / "nonexistent_workspace"))
        score = asyncio.run(
            _run_scorer(
                workspace=str(tmp_path / "nonexistent_workspace"),
                examples_dir=str(tmp_path / "examples"),
                mock_sb=mock_sb,
            )
        )

        assert score is not None
        assert "failed" in (score.explanation or "").lower() or "No such file" in (
            score.explanation or ""
        )

    def test_excludes_build_artifacts(self, tmp_path: Path):
        """Build artifacts should not be copied to the examples directory."""
        workspace = tmp_path / "eval_workspace_abc" / "workspace"
        workspace.mkdir(parents=True)
        (workspace / "pubspec.yaml").write_text("name: app")
        (workspace / "build").mkdir()
        (workspace / "build" / "big_artifact.txt").write_text("should be excluded")
        (workspace / ".dart_tool").mkdir()
        (workspace / ".dart_tool" / "config.json").write_text("{}")

        examples_dir = tmp_path / "examples"
        mock_sb = _build_mock_sandbox(str(workspace))

        asyncio.run(_run_scorer(str(workspace), str(examples_dir), mock_sb=mock_sb))

        dest = examples_dir / "my-task:baseline" / "sample-001"
        assert not (dest / "build").exists()
        assert not (dest / ".dart_tool").exists()
        assert (dest / "pubspec.yaml").exists()

    def test_multiple_samples_get_separate_dirs(self, tmp_path: Path):
        """Each sample should land in its own subdirectory under the task_variant dir."""
        workspace = tmp_path / "eval_workspace" / "my_app"
        workspace.mkdir(parents=True)
        (workspace / "main.dart").write_text("// code")

        examples_dir = tmp_path / "examples"
        mock_sb = _build_mock_sandbox(str(workspace))

        for sample_id in ["sample-001", "sample-002"]:
            state = _make_state(str(workspace), str(examples_dir))
            state.sample_id = sample_id
            target = MagicMock()
            scorer = export_workspace()
            with patch(
                "dash_evals.runner.scorers.export_workspace.sandbox",
                return_value=mock_sb,
            ):
                asyncio.run(scorer(state, target))

        assert (examples_dir / "my-task:baseline" / "sample-001").exists()
        assert (examples_dir / "my-task:baseline" / "sample-002").exists()
