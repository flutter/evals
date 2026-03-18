"""Job model — runtime configuration for an evaluation run."""

from __future__ import annotations

from typing import Any

from pydantic import BaseModel

from dataset_config_python.models.tag_filter import TagFilter


class JobTask(BaseModel):
    """Per-task configuration within a job."""

    id: str
    """Task identifier matching a task directory name."""

    include_samples: list[str] | None = None
    """Only run these sample IDs."""

    exclude_samples: list[str] | None = None
    """Exclude these sample IDs."""

    args: dict[str, Any] | None = None
    """Per-task argument overrides passed to the task function."""

    include_variants: list[str] | None = None
    """Only run these variant names for this task."""

    exclude_variants: list[str] | None = None
    """Exclude these variant names for this task."""

    @staticmethod
    def from_yaml(task_id: str, data: dict[str, Any] | None) -> JobTask:
        """Create from parsed YAML data."""
        if data is None:
            return JobTask(id=task_id)
        return JobTask(
            id=task_id,
            include_samples=data.get("include-samples"),
            exclude_samples=data.get("exclude-samples"),
            args=data.get("args"),
            include_variants=data.get("include-variants"),
            exclude_variants=data.get("exclude-variants"),
        )


class Job(BaseModel):
    """A job configuration defining what to run and how to run it."""

    # Core settings
    description: str | None = None
    log_dir: str
    max_connections: int = 10
    models: list[str] | None = None
    variants: dict[str, dict[str, Any]] | None = None
    task_paths: list[str] | None = None
    tasks: dict[str, JobTask] | None = None
    save_examples: bool = False

    # Sandbox configuration
    sandbox: dict[str, Any] | None = None
    """Sandbox config with keys: environment, parameters, image_prefix."""

    # Inspect eval arguments (passed through to eval_set())
    inspect_eval_arguments: dict[str, Any] | None = None
    """All Inspect AI eval_set() parameters, nested under one key."""

    # Tag-based filtering
    task_filters: TagFilter | None = None
    sample_filters: TagFilter | None = None
