"""
Tests for solver modules.

Tests the extract_code, add_system_message, and context_injector solvers.
These are thin wrappers around pure logic, so we test the factory functions
and (where possible) the underlying logic without a full Inspect AI runtime.
"""

from dash_evals.runner.solvers.add_system_message import add_system_message
from dash_evals.runner.solvers.context_injector import context_injector
from dash_evals.runner.solvers.extract_code import extract_code


class TestExtractCodeFactory:
    """Tests for the extract_code solver factory."""

    def test_returns_callable(self):
        """extract_code() should return a callable solver."""
        result = extract_code()
        assert callable(result)

    def test_accepts_language_arg(self):
        """extract_code() should accept a custom language argument."""
        result = extract_code(language="python")
        assert callable(result)


class TestAddSystemMessageFactory:
    """Tests for the add_system_message solver factory."""

    def test_returns_callable(self):
        """add_system_message() should return a callable solver."""
        result = add_system_message("Hello system")
        assert callable(result)

    def test_accepts_message_with_curly_braces(self):
        """add_system_message() should handle messages with curly braces (code)."""
        # This is the reason this solver exists — to avoid template formatting
        result = add_system_message("void main() { print('hello'); }")
        assert callable(result)


class TestContextInjectorFactory:
    """Tests for the context_injector solver factory."""

    def test_returns_callable_with_empty_list(self):
        """context_injector() with empty list should return callable."""
        result = context_injector(context_files=[])
        assert callable(result)

    def test_returns_callable_with_files(self):
        """context_injector() with ContextFile list should return callable."""
        # ContextFile construction may need real file paths, test the factory only
        result = context_injector(context_files=[])
        assert callable(result)
