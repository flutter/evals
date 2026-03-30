"""Tests for dataset_config_python.hydrate — config → Inspect AI object conversion."""

from __future__ import annotations

from unittest.mock import MagicMock, patch

import pytest
from inspect_ai.dataset import MemoryDataset

from dataset_config_python.hydrate import (
    build_dataset,
    build_task_metadata,
    create_mcp_servers,
    get_skill_tool,
)

# ===========================================================================
# build_dataset
# ===========================================================================


class TestBuildDatasetMemoryFormat:
    """Tests for inline MemoryDataset (format='memory')."""

    def test_no_dataset_returns_empty_memory_dataset(self):
        """Tasks without a dataset key produce an empty MemoryDataset."""
        task_def = {"name": "my_task:baseline", "func": "question_answer"}
        result = build_dataset(task_def)
        assert isinstance(result, MemoryDataset)
        assert len(result) == 0

    def test_empty_dataset_dict_returns_empty_memory_dataset(self):
        """An empty dataset dict produces an empty MemoryDataset."""
        task_def = {"name": "my_task:baseline", "dataset": {}}
        result = build_dataset(task_def)
        assert isinstance(result, MemoryDataset)
        assert len(result) == 0

    def test_memory_format_explicit(self):
        """Explicit format='memory' builds a MemoryDataset from inline samples."""
        task_def = {
            "name": "my_task:baseline",
            "dataset": {
                "format": "memory",
                "samples": [
                    {"id": "s1", "input": "What is Dart?", "target": "A language"},
                ],
            },
        }
        result = build_dataset(task_def)
        assert isinstance(result, MemoryDataset)
        assert len(result) == 1
        assert result[0].input == "What is Dart?"
        assert result[0].target == "A language"
        assert result[0].id == "s1"

    def test_memory_format_default_when_format_absent(self):
        """Omitting 'format' defaults to memory format."""
        task_def = {
            "name": "my_task:baseline",
            "dataset": {
                "samples": [
                    {"id": "s1", "input": "q", "target": "a"},
                ],
            },
        }
        result = build_dataset(task_def)
        assert isinstance(result, MemoryDataset)
        assert len(result) == 1

    def test_memory_format_preserves_optional_sample_fields(self):
        """Optional sample fields (metadata, files, setup, sandbox) are passed through."""
        task_def = {
            "name": "t:v",
            "dataset": {
                "samples": [
                    {
                        "id": "s1",
                        "input": "q",
                        "target": "a",
                        "metadata": {"difficulty": "hard"},
                        "files": {"/workspace": "./proj"},
                        "setup": "dart pub get",
                        "sandbox": "docker",
                    }
                ],
            },
        }
        result = build_dataset(task_def)
        sample = result[0]
        assert sample.metadata == {"difficulty": "hard"}
        assert sample.files == {"/workspace": "./proj"}
        assert sample.setup == "dart pub get"
        sandbox = sample.sandbox
        sandbox_type = sandbox.type if hasattr(sandbox, "type") else sandbox
        assert sandbox_type == "docker"

    def test_memory_format_dataset_name(self):
        """Dataset name falls back to task name when not set in dataset dict."""
        task_def = {
            "name": "dart_qa:baseline",
            "dataset": {
                "samples": [],
            },
        }
        result = build_dataset(task_def)
        assert isinstance(result, MemoryDataset)
        assert result.name == "dart_qa:baseline"

    def test_memory_format_explicit_dataset_name_wins(self):
        """Explicit dataset name takes precedence over task name."""
        task_def = {
            "name": "dart_qa:baseline",
            "dataset": {
                "name": "custom_name",
                "samples": [],
            },
        }
        result = build_dataset(task_def)
        assert result.name == "custom_name"


class TestBuildDatasetJsonFormat:
    """Tests for JSON file-backed dataset (format='json')."""

    def test_json_format_calls_json_dataset(self):
        """format='json' calls inspect_ai.dataset.json_dataset(source)."""
        task_def = {
            "name": "my_task:baseline",
            "dataset": {
                "format": "json",
                "source": "gs://bucket/data.jsonl",
            },
        }
        mock_ds = MagicMock(name="json_dataset_result")
        with patch("dataset_config_python.hydrate.json_dataset", return_value=mock_ds) as mock_fn:
            result = build_dataset(task_def)

        mock_fn.assert_called_once_with("gs://bucket/data.jsonl")
        assert result is mock_ds

    def test_json_format_passes_extra_args(self):
        """Extra args from dataset.args are passed as kwargs to json_dataset()."""
        task_def = {
            "name": "t:v",
            "dataset": {
                "format": "json",
                "source": "./data.jsonl",
                "args": {"auto_id": True, "shuffle": True},
            },
        }
        with patch("dataset_config_python.hydrate.json_dataset") as mock_fn:
            build_dataset(task_def)

        mock_fn.assert_called_once_with("./data.jsonl", auto_id=True, shuffle=True)

    def test_json_format_missing_source_raises(self):
        """format='json' without a source raises ValueError."""
        task_def = {
            "name": "my_task:baseline",
            "dataset": {"format": "json"},
        }
        with pytest.raises(ValueError, match="requires a 'source' field"):
            build_dataset(task_def)


class TestBuildDatasetCsvFormat:
    """Tests for CSV file-backed dataset (format='csv')."""

    def test_csv_format_calls_csv_dataset(self):
        """format='csv' calls inspect_ai.dataset.csv_dataset(source)."""
        task_def = {
            "name": "my_task:baseline",
            "dataset": {
                "format": "csv",
                "source": "./data.csv",
            },
        }
        mock_ds = MagicMock(name="csv_dataset_result")
        with patch("dataset_config_python.hydrate.csv_dataset", return_value=mock_ds) as mock_fn:
            result = build_dataset(task_def)

        mock_fn.assert_called_once_with("./data.csv")
        assert result is mock_ds

    def test_csv_format_passes_extra_args(self):
        """Extra args from dataset.args are passed as kwargs to csv_dataset()."""
        task_def = {
            "name": "t:v",
            "dataset": {
                "format": "csv",
                "source": "./data.csv",
                "args": {"delimiter": "\t", "encoding": "utf-8"},
            },
        }
        with patch("dataset_config_python.hydrate.csv_dataset") as mock_fn:
            build_dataset(task_def)

        mock_fn.assert_called_once_with("./data.csv", delimiter="\t", encoding="utf-8")

    def test_csv_format_missing_source_raises(self):
        """format='csv' without a source raises ValueError."""
        task_def = {
            "name": "my_task:baseline",
            "dataset": {"format": "csv"},
        }
        with pytest.raises(ValueError, match="requires a 'source' field"):
            build_dataset(task_def)


class TestBuildDatasetUnknownFormat:
    """Tests for unknown dataset formats."""

    def test_unknown_format_raises(self):
        """An unrecognised format string raises ValueError."""
        task_def = {
            "name": "my_task:baseline",
            "dataset": {
                "format": "parquet",
                "source": "./data.parquet",
            },
        }
        with pytest.raises(ValueError, match="unknown dataset format 'parquet'"):
            build_dataset(task_def)


# ===========================================================================
# create_mcp_servers
# ===========================================================================


class TestCreateMcpServers:
    """Tests for MCP server creation from config dicts."""

    def test_empty_list_returns_empty(self):
        result = create_mcp_servers([])
        assert result == []

    def test_stdio_server_local(self):
        """Local sandbox defaults to stdio transport."""
        cfg = [{"command": "dart", "args": ["mcp-server"], "name": "Dart"}]
        servers = create_mcp_servers(cfg, sandbox_type="local")
        assert len(servers) == 1

    def test_sandbox_server_non_local(self):
        """Non-local sandbox defaults to sandbox transport."""
        cfg = [{"command": "dart", "args": ["mcp-server"], "name": "Dart"}]
        servers = create_mcp_servers(cfg, sandbox_type="podman")
        assert len(servers) == 1

    def test_http_server(self):
        """URL-based config produces an HTTP server."""
        cfg = [{"url": "http://localhost:8080", "name": "test"}]
        servers = create_mcp_servers(cfg)
        assert len(servers) == 1

    def test_ref_server(self):
        """Ref mode imports a pre-built MCPServer."""
        mock_server = MagicMock()
        with patch(
            "dataset_config_python.hydrate._resolve_mcp_ref",
            return_value=mock_server,
        ):
            servers = create_mcp_servers([{"ref": "my_pkg:my_server"}])
        assert len(servers) == 1
        assert servers[0] is mock_server

    def test_missing_command_and_url_raises(self):
        """Config without command or url raises ValueError."""
        with pytest.raises(ValueError, match="missing 'command' or 'url'"):
            create_mcp_servers([{"name": "broken"}])

    def test_unknown_transport_raises(self):
        """Unknown transport value raises ValueError."""
        with pytest.raises(ValueError, match="Unknown MCP transport"):
            create_mcp_servers([{"command": "dart", "name": "test", "transport": "quantum"}])


# ===========================================================================
# get_skill_tool
# ===========================================================================


class TestGetSkillTool:
    """Tests for skill tool creation from config."""

    def test_no_variant_returns_none(self):
        assert get_skill_tool({}) is None

    def test_no_skills_returns_none(self):
        assert get_skill_tool({"variant": {}}) is None

    def test_empty_skills_returns_none(self):
        assert get_skill_tool({"variant": {"skills": []}}) is None

    def test_skills_returns_tool(self):
        with patch("dataset_config_python.hydrate.skill") as mock_skill:
            mock_skill.return_value = MagicMock()
            result = get_skill_tool({"variant": {"skills": ["/path/to/skill"]}})
        assert result is not None
        mock_skill.assert_called_once_with(["/path/to/skill"])

    def test_old_skill_paths_key(self):
        """Supports the legacy 'skill_paths' key."""
        with patch("dataset_config_python.hydrate.skill") as mock_skill:
            mock_skill.return_value = MagicMock()
            result = get_skill_tool({"variant": {"skill_paths": ["/path/to/skill"]}})
        assert result is not None
        mock_skill.assert_called_once_with(["/path/to/skill"])


# ===========================================================================
# build_task_metadata
# ===========================================================================


class TestBuildTaskMetadata:
    """Tests for task metadata construction."""

    def test_empty_config(self):
        result = build_task_metadata({})
        assert result == {}

    def test_variant_included(self):
        result = build_task_metadata({"variant": {"files": ["a.md"]}})
        assert "variant_config" in result
        assert result["variant_config"] == {"files": ["a.md"]}

    def test_save_examples(self):
        result = build_task_metadata(
            {
                "save_examples": True,
                "examples_dir": "/logs/examples",
                "task_name": "my_task:v1",
            }
        )
        assert result["save_examples"] is True
        assert result["examples_dir"] == "/logs/examples"
        assert result["task_variant"] == "my_task:v1"

    def test_save_examples_without_dir_omits(self):
        """save_examples without examples_dir does not add metadata."""
        result = build_task_metadata({"save_examples": True})
        assert "save_examples" not in result
