"""Tests for json_runner._build_dataset() — dataset format dispatch."""

from __future__ import annotations

from unittest.mock import MagicMock, patch

import pytest
from inspect_ai.dataset import MemoryDataset

from dash_evals.runner.json_runner import _build_dataset


class TestBuildDatasetMemoryFormat:
    """Tests for inline MemoryDataset (format='memory')."""

    def test_no_dataset_returns_empty_memory_dataset(self):
        """Tasks without a dataset key produce an empty MemoryDataset."""
        task_def = {"name": "my_task:baseline", "func": "question_answer"}
        result = _build_dataset(task_def)
        assert isinstance(result, MemoryDataset)
        assert len(result) == 0

    def test_empty_dataset_dict_returns_empty_memory_dataset(self):
        """An empty dataset dict produces an empty MemoryDataset."""
        task_def = {"name": "my_task:baseline", "dataset": {}}
        result = _build_dataset(task_def)
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
        result = _build_dataset(task_def)
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
        result = _build_dataset(task_def)
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
        result = _build_dataset(task_def)
        sample = result[0]
        assert sample.metadata == {"difficulty": "hard"}
        assert sample.files == {"/workspace": "./proj"}
        assert sample.setup == "dart pub get"
        # Inspect AI normalises string sandbox values to SandboxEnvironmentSpec
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
        result = _build_dataset(task_def)
        assert isinstance(result, MemoryDataset)
        # Name is set (MemoryDataset stores it)
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
        result = _build_dataset(task_def)
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
        with patch("dash_evals.runner.json_runner.json_dataset", return_value=mock_ds) as mock_fn:
            result = _build_dataset(task_def)

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
        with patch("dash_evals.runner.json_runner.json_dataset") as mock_fn:
            _build_dataset(task_def)

        mock_fn.assert_called_once_with("./data.jsonl", auto_id=True, shuffle=True)

    def test_json_format_missing_source_raises(self):
        """format='json' without a source raises ValueError."""
        task_def = {
            "name": "my_task:baseline",
            "dataset": {"format": "json"},
        }
        with pytest.raises(ValueError, match="requires a 'source' field"):
            _build_dataset(task_def)


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
        with patch("dash_evals.runner.json_runner.csv_dataset", return_value=mock_ds) as mock_fn:
            result = _build_dataset(task_def)

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
        with patch("dash_evals.runner.json_runner.csv_dataset") as mock_fn:
            _build_dataset(task_def)

        mock_fn.assert_called_once_with("./data.csv", delimiter="\t", encoding="utf-8")

    def test_csv_format_missing_source_raises(self):
        """format='csv' without a source raises ValueError."""
        task_def = {
            "name": "my_task:baseline",
            "dataset": {"format": "csv"},
        }
        with pytest.raises(ValueError, match="requires a 'source' field"):
            _build_dataset(task_def)


class TestBuildDatasetUnknownFormat:
    """Tests for unknown dataset formats."""

    def test_unknown_format_raises(self):
        """An unrecognized format string raises ValueError."""
        task_def = {
            "name": "my_task:baseline",
            "dataset": {
                "format": "parquet",
                "source": "./data.parquet",
            },
        }
        with pytest.raises(ValueError, match="unknown dataset format 'parquet'"):
            _build_dataset(task_def)
