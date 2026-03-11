"""
Tests for task helpers.

Tests validate_sandbox_tools helper from the manifest-based task system.
"""

import pytest

from dash_evals.runner.tasks.task_helpers import validate_sandbox_tools


class TestValidateSandboxTools:
    """Tests for validate_sandbox_tools helper."""

    def _make_config(self, sandbox_type: str = "local") -> dict:
        """Create a minimal manifest config dict for testing."""
        return {
            "task_name": "test_task:baseline",
            "sandbox_type": sandbox_type,
        }

    def test_raises_for_local_with_injection_tools(self):
        """Local sandbox + bash_session/text_editor should raise ValueError."""
        config = self._make_config(sandbox_type="local")
        with pytest.raises(ValueError, match="cannot run on a local sandbox"):
            validate_sandbox_tools(config, ["bash_session", "text_editor"])

    def test_passes_for_docker(self):
        """Docker sandbox should never raise, regardless of tools."""
        config = self._make_config(sandbox_type="docker")
        validate_sandbox_tools(config, ["bash_session", "text_editor"])

    def test_passes_for_local_with_safe_tools(self):
        """Local sandbox with non-injection tools should not raise."""
        config = self._make_config(sandbox_type="local")
        validate_sandbox_tools(config, ["bash"])

    def test_raises_for_single_injection_tool(self):
        """Even one injection tool should be enough to raise."""
        config = self._make_config(sandbox_type="local")
        with pytest.raises(ValueError, match="bash_session"):
            validate_sandbox_tools(config, ["bash_session"])
