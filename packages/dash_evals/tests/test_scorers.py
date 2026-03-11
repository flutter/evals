"""
Tests for scorer modules.

Tests the pure-function helpers and the scorer factory functions where possible
without spinning up an actual Inspect AI evaluation.

Covered:
- code_quality._parse_json_response
- mcp_tool_usage (DART_MCP_TOOLS constant, scorer factory)
- skill_usage (SKILL_TOOL_NAME constant)
"""

import json
from unittest.mock import MagicMock

import pytest

from dash_evals.runner.scorers.code_quality import _parse_json_response
from dash_evals.runner.scorers.mcp_tool_usage import DART_MCP_TOOLS, mcp_tool_usage
from dash_evals.runner.scorers.skill_usage import SKILL_TOOL_NAME, skill_usage_scorer


# ──────────────────────────────────────────────
#  _parse_json_response (code_quality helper)
# ──────────────────────────────────────────────
class TestParseJsonResponse:
    """Tests for the _parse_json_response helper."""

    def test_parse_plain_json(self):
        """Test parsing a plain JSON string."""
        text = '{"minimality": 3, "elegance": 2, "robustness": 1, "reasoning": "Good"}'
        result = _parse_json_response(text)
        assert result is not None
        assert result["minimality"] == 3
        assert result["reasoning"] == "Good"

    def test_parse_json_in_markdown_block(self):
        """Test extracting JSON from a markdown code block."""
        text = '```json\n{"minimality": 2, "elegance": 2, "robustness": 2, "reasoning": "OK"}\n```'
        result = _parse_json_response(text)
        assert result is not None
        assert result["minimality"] == 2

    def test_parse_json_in_generic_block(self):
        """Test extracting JSON from a generic code block."""
        text = '```\n{"minimality": 1, "elegance": 1, "robustness": 1, "reasoning": "Meh"}\n```'
        result = _parse_json_response(text)
        assert result is not None
        assert result["reasoning"] == "Meh"

    def test_parse_json_embedded_in_text(self):
        """Test extracting JSON object embedded in prose."""
        text = (
            "The code is decent. "
            '{"minimality": 2, "elegance": 3, "robustness": 2, "reasoning": "Solid"}'
        )
        result = _parse_json_response(text)
        assert result is not None
        assert result["elegance"] == 3

    def test_parse_invalid_json_returns_none(self):
        """Test that invalid/unparseable text returns None."""
        result = _parse_json_response("This is not JSON at all.")
        assert result is None

    def test_parse_empty_string_returns_none(self):
        """Test that empty string returns None."""
        result = _parse_json_response("")
        assert result is None

    def test_parse_json_with_whitespace(self):
        """Test parsing JSON with extra whitespace."""
        text = '  \n  {"minimality": 1, "elegance": 1, "robustness": 1, "reasoning": "OK"}  \n  '
        result = _parse_json_response(text)
        assert result is not None
        assert result["minimality"] == 1


# ──────────────────────────────────────────────
#  DART_MCP_TOOLS constant
# ──────────────────────────────────────────────
class TestDartMCPTools:
    """Tests for the DART_MCP_TOOLS constant."""

    def test_is_set(self):
        """DART_MCP_TOOLS should be a set."""
        assert isinstance(DART_MCP_TOOLS, set)

    def test_not_empty(self):
        """DART_MCP_TOOLS should not be empty."""
        assert len(DART_MCP_TOOLS) > 0

    def test_contains_known_tools(self):
        """Should contain well-known Dart MCP server tools."""
        expected = ["analyze_files", "pub", "run_tests", "hot_reload", "launch_app"]
        for tool in expected:
            assert tool in DART_MCP_TOOLS, f"Missing tool: {tool}"

    def test_all_entries_are_strings(self):
        """All tools should be string names."""
        for tool in DART_MCP_TOOLS:
            assert isinstance(tool, str)


# ──────────────────────────────────────────────
#  SKILL_TOOL_NAME constant
# ──────────────────────────────────────────────
class TestSkillUsageConstants:
    """Tests for skill_usage constants."""

    def test_skill_tool_name(self):
        """SKILL_TOOL_NAME should be 'skill'."""
        assert SKILL_TOOL_NAME == "skill"


# ──────────────────────────────────────────────
#  mcp_tool_usage scorer factory
# ──────────────────────────────────────────────
class TestMCPToolUsageScorerFactory:
    """Tests for the mcp_tool_usage scorer factory function."""

    def test_returns_callable(self):
        """mcp_tool_usage() should return a callable scorer."""
        result = mcp_tool_usage()
        assert callable(result)

    def test_accepts_custom_server_name(self):
        """mcp_tool_usage() should accept a custom MCP server name."""
        result = mcp_tool_usage(mcp_server_name="Firebase")
        assert callable(result)

    def test_accepts_custom_tool_names(self):
        """mcp_tool_usage() should accept a custom tool names list."""
        result = mcp_tool_usage(mcp_tool_names=["my_tool_1", "my_tool_2"])
        assert callable(result)


# ──────────────────────────────────────────────
#  skill_usage_scorer factory
# ──────────────────────────────────────────────
class TestSkillUsageScorerFactory:
    """Tests for the skill_usage_scorer factory function."""

    def test_returns_callable(self):
        """skill_usage_scorer() should return a callable scorer."""
        result = skill_usage_scorer()
        assert callable(result)
