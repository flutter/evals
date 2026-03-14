"""Tests for the dataset_config_python package."""

from __future__ import annotations

import json
import os

import pytest

from dataset_config_python import resolve, write_eval_sets
from dataset_config_python.models import (
    ContextFile,
    Dataset,
    EvalSet,
    JobTask,
    Sample,
    Task,
    Variant,
)
from dataset_config_python.parser import find_job_file, parse_job, parse_tasks

# ---------------------------------------------------------------------------
# Fixtures: create a minimal dataset directory structure
# ---------------------------------------------------------------------------


@pytest.fixture
def dataset_dir(tmp_path):
    """Create a minimal dataset directory with tasks and jobs."""
    # tasks/dart_qa/task.yaml
    task_dir = tmp_path / "tasks" / "dart_qa"
    task_dir.mkdir(parents=True)
    task_yaml = task_dir / "task.yaml"
    task_yaml.write_text(
        """
id: dart_qa
func: question_answer
system_message: "You are an expert."
samples:
  inline:
    - id: sample_1
      input: "What is Dart?"
      target: "A programming language."
      difficulty: easy
    - id: sample_2
      input: "What is Flutter?"
      target: "A UI framework."
      difficulty: medium
      tags: ui, framework
"""
    )

    # tasks/code_gen/task.yaml
    code_gen_dir = tmp_path / "tasks" / "code_gen"
    code_gen_dir.mkdir(parents=True)
    code_gen_yaml = code_gen_dir / "task.yaml"
    code_gen_yaml.write_text(
        """
id: code_gen
func: flutter_code_gen
time_limit: 600
allowed_variants:
  - baseline
  - context_only
samples:
  inline:
    - id: sample_1
      input: "Create a counter app."
      target: "A working counter app."
"""
    )

    # jobs/local_dev.yaml
    jobs_dir = tmp_path / "jobs"
    jobs_dir.mkdir()
    job_yaml = jobs_dir / "local_dev.yaml"
    job_yaml.write_text(
        """
logs_dir: ./logs
sandbox_type: local
max_connections: 5
models:
  - google/gemini-2.5-flash
variants:
  baseline: {}
  context_only:
    context_files: []
"""
    )

    return tmp_path


@pytest.fixture
def dataset_dir_with_sample_files(tmp_path):
    """Create a dataset directory with external sample files."""
    task_dir = tmp_path / "tasks" / "qa"
    task_dir.mkdir(parents=True)

    # External sample file
    samples_dir = task_dir / "samples"
    samples_dir.mkdir()
    sample_file = samples_dir / "basics.yaml"
    sample_file.write_text(
        """
id: basic_1
input: "Explain null safety."
target: "Null safety prevents null pointer exceptions."
---
id: basic_2
input: "What are isolates?"
target: "Isolates are Dart's concurrency model."
"""
    )

    task_yaml = task_dir / "task.yaml"
    task_yaml.write_text(
        """
id: qa
func: question_answer
samples:
  paths:
    - samples/basics.yaml
"""
    )

    jobs_dir = tmp_path / "jobs"
    jobs_dir.mkdir()
    (jobs_dir / "default.yaml").write_text(
        """
logs_dir: ./logs
"""
    )

    return tmp_path


# ---------------------------------------------------------------------------
# Model tests
# ---------------------------------------------------------------------------


class TestModels:
    def test_sample_creation(self):
        s = Sample(input="test", target="expected", id="s1")
        assert s.input == "test"
        assert s.target == "expected"
        assert s.id == "s1"

    def test_sample_defaults(self):
        s = Sample(input="test")
        assert s.target == ""
        assert s.id is None
        assert s.metadata is None

    def test_dataset_creation(self):
        samples = [Sample(input="a", target="b", id="1")]
        ds = Dataset(samples=samples, name="test_ds")
        assert len(ds.samples) == 1
        assert ds.name == "test_ds"

    def test_variant_defaults(self):
        v = Variant()
        assert v.name == "baseline"
        assert v.context_files == []
        assert v.mcp_servers == []
        assert v.skill_paths == []
        assert v.branch is None

    def test_job_task_from_yaml_none(self):
        jt = JobTask.from_yaml("my_task", None)
        assert jt.id == "my_task"
        assert jt.include_samples is None

    def test_job_task_from_yaml_with_data(self):
        jt = JobTask.from_yaml("my_task", {"include-samples": ["s1", "s2"]})
        assert jt.include_samples == ["s1", "s2"]

    def test_eval_set_serialization(self):
        es = EvalSet(
            tasks=[Task(name="test:baseline", func="qa")],
            log_dir="/tmp/logs",
            model=["google/gemini-2.5-flash"],
        )
        data = es.model_dump(exclude_none=True)
        assert data["log_dir"] == "/tmp/logs"
        assert len(data["tasks"]) == 1
        assert data["tasks"][0]["name"] == "test:baseline"


# ---------------------------------------------------------------------------
# Parser tests
# ---------------------------------------------------------------------------


class TestParser:
    def test_parse_tasks(self, dataset_dir):
        tasks = parse_tasks(str(dataset_dir))
        assert len(tasks) == 2
        task_ids = {t.id for t in tasks}
        assert "dart_qa" in task_ids
        assert "code_gen" in task_ids

    def test_parse_tasks_samples(self, dataset_dir):
        tasks = parse_tasks(str(dataset_dir))
        dart_qa = next(t for t in tasks if t.id == "dart_qa")
        assert len(dart_qa.samples) == 2
        assert dart_qa.samples[0].id == "sample_1"

    def test_parse_tasks_metadata(self, dataset_dir):
        tasks = parse_tasks(str(dataset_dir))
        dart_qa = next(t for t in tasks if t.id == "dart_qa")
        # Check tags normalization
        s2 = next(s for s in dart_qa.samples if s.id == "sample_2")
        assert s2.metadata is not None
        assert s2.metadata["tags"] == ["ui", "framework"]
        assert s2.metadata["difficulty"] == "medium"

    def test_parse_tasks_allowed_variants(self, dataset_dir):
        tasks = parse_tasks(str(dataset_dir))
        code_gen = next(t for t in tasks if t.id == "code_gen")
        assert code_gen.allowed_variants == ["baseline", "context_only"]

    def test_parse_tasks_time_limit(self, dataset_dir):
        tasks = parse_tasks(str(dataset_dir))
        code_gen = next(t for t in tasks if t.id == "code_gen")
        assert code_gen.time_limit == 600

    def test_parse_job(self, dataset_dir):
        job_path = os.path.join(str(dataset_dir), "jobs", "local_dev.yaml")
        job = parse_job(job_path, str(dataset_dir))
        assert job.sandbox_type == "local"
        assert job.max_connections == 5
        assert job.models == ["google/gemini-2.5-flash"]

    def test_find_job_file(self, dataset_dir):
        path = find_job_file(str(dataset_dir), "local_dev")
        assert path.endswith("local_dev.yaml")

    def test_find_job_file_not_found(self, dataset_dir):
        with pytest.raises(FileNotFoundError):
            find_job_file(str(dataset_dir), "nonexistent")

    def test_parse_tasks_with_sample_files(self, dataset_dir_with_sample_files):
        """Test parsing tasks with external sample files (multi-doc YAML)."""
        tasks = parse_tasks(str(dataset_dir_with_sample_files))
        assert len(tasks) == 1
        qa = tasks[0]
        assert qa.id == "qa"
        assert len(qa.samples) == 2
        assert qa.samples[0].id == "basic_1"
        assert qa.samples[1].id == "basic_2"

    def test_parse_tasks_empty_dir(self, tmp_path):
        tasks = parse_tasks(str(tmp_path))
        assert tasks == []


# ---------------------------------------------------------------------------
# Resolver tests
# ---------------------------------------------------------------------------


class TestResolver:
    def test_resolve_basic(self, dataset_dir):
        eval_sets = resolve(dataset_path=str(dataset_dir), job_names=["local_dev"])
        assert len(eval_sets) == 1
        es = eval_sets[0]
        assert es.model == ["google/gemini-2.5-flash"]
        assert es.log_level == "info"

    def test_resolve_task_variant_expansion(self, dataset_dir):
        eval_sets = resolve(dataset_path=str(dataset_dir), job_names=["local_dev"])
        es = eval_sets[0]
        # dart_qa has 2 variants (baseline, context_only), code_gen has 2 allowed
        task_names = [t.name for t in es.tasks]
        assert "dart_qa:baseline" in task_names
        assert "dart_qa:context_only" in task_names
        assert "code_gen:baseline" in task_names
        assert "code_gen:context_only" in task_names

    def test_resolve_inline_datasets(self, dataset_dir):
        eval_sets = resolve(dataset_path=str(dataset_dir), job_names=["local_dev"])
        es = eval_sets[0]
        dart_qa_baseline = next(t for t in es.tasks if t.name == "dart_qa:baseline")
        assert dart_qa_baseline.dataset is not None
        assert len(dart_qa_baseline.dataset.samples) == 2

    def test_resolve_sandbox_local(self, dataset_dir):
        eval_sets = resolve(dataset_path=str(dataset_dir), job_names=["local_dev"])
        es = eval_sets[0]
        assert es.sandbox is None  # 'local' serializes to None


# ---------------------------------------------------------------------------
# Writer tests
# ---------------------------------------------------------------------------


class TestWriter:
    def test_write_single(self, dataset_dir, tmp_path):
        eval_sets = resolve(dataset_path=str(dataset_dir), job_names=["local_dev"])
        output_dir = str(tmp_path / "output")
        json_path = write_eval_sets(eval_sets, output_dir)
        assert os.path.isfile(json_path)

        with open(json_path) as f:
            data = json.load(f)
        assert isinstance(data, dict)
        assert "tasks" in data
        assert "log_dir" in data

    def test_write_multiple(self, tmp_path):
        es1 = EvalSet(
            tasks=[Task(name="t1:baseline", func="qa")],
            log_dir="/tmp/logs1",
        )
        es2 = EvalSet(
            tasks=[Task(name="t2:baseline", func="qa")],
            log_dir="/tmp/logs2",
        )
        output_dir = str(tmp_path / "output")
        json_path = write_eval_sets([es1, es2], output_dir)

        with open(json_path) as f:
            data = json.load(f)
        assert isinstance(data, list)
        assert len(data) == 2


# ---------------------------------------------------------------------------
# Context file tests
# ---------------------------------------------------------------------------


class TestContextFile:
    def test_load(self, tmp_path):
        cf = tmp_path / "context.md"
        cf.write_text(
            """---
title: Flutter Guide
version: "1.0"
description: A guide to Flutter
---
# Content starts here

Some markdown content.
"""
        )
        loaded = ContextFile.load(str(cf))
        assert loaded.metadata.title == "Flutter Guide"
        assert loaded.metadata.version == "1.0"
        assert "Content starts here" in loaded.content

    def test_load_not_found(self):
        with pytest.raises(FileNotFoundError):
            ContextFile.load("/nonexistent/file.md")

    def test_load_no_frontmatter(self, tmp_path):
        cf = tmp_path / "bad.md"
        cf.write_text("No frontmatter here")
        with pytest.raises(ValueError):
            ContextFile.load(str(cf))
