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

    system_message: str | None = None
    """Override system message for this task."""

    args: dict[str, Any] | None = None
    """Per-task argument overrides passed to the task function."""

    @staticmethod
    def from_yaml(task_id: str, data: dict[str, Any] | None) -> JobTask:
        """Create from parsed YAML data."""
        if data is None:
            return JobTask(id=task_id)
        return JobTask(
            id=task_id,
            include_samples=data.get("include-samples"),
            exclude_samples=data.get("exclude-samples"),
            system_message=data.get("system_message"),
            args=data.get("args"),
        )


class Job(BaseModel):
    """A job configuration defining what to run and how to run it."""

    # Core settings
    description: str | None = None
    image_prefix: str | None = None
    log_dir: str
    sandbox_type: str = "local"
    max_connections: int = 10
    models: list[str] | None = None
    variants: dict[str, dict[str, Any]] | None = None
    task_paths: list[str] | None = None
    tasks: dict[str, JobTask] | None = None
    save_examples: bool = False

    # Promoted eval_set() parameters
    retry_attempts: int | None = None
    max_retries: int | None = None
    retry_wait: float | None = None
    retry_connections: float | None = None
    retry_cleanup: bool | None = None
    fail_on_error: float | None = None
    continue_on_fail: bool | None = None
    retry_on_error: int | None = None
    debug_errors: bool | None = None
    max_samples: int | None = None
    max_tasks: int | None = None
    max_subprocesses: int | None = None
    max_sandboxes: int | None = None
    log_level: str | None = None
    log_level_transcript: str | None = None
    log_format: str | None = None
    tags: list[str] | None = None
    metadata: dict[str, Any] | None = None
    trace: bool | None = None
    display: str | None = None
    score: bool | None = None
    limit: Any | None = None
    sample_id: Any | None = None
    sample_shuffle: Any | None = None
    epochs: Any | None = None
    approval: Any | None = None
    solver: Any | None = None
    sandbox_cleanup: bool | None = None
    model_base_url: str | None = None
    model_args: dict[str, Any] | None = None
    model_roles: dict[str, str] | None = None
    task_args: dict[str, Any] | None = None
    message_limit: int | None = None
    token_limit: int | None = None
    time_limit: int | None = None
    working_limit: int | None = None
    cost_limit: float | None = None
    model_cost_config: dict[str, Any] | None = None
    log_samples: bool | None = None
    log_realtime: bool | None = None
    log_images: bool | None = None
    log_buffer: int | None = None
    log_shared: int | None = None
    bundle_dir: str | None = None
    bundle_overwrite: bool | None = None
    log_dir_allow_dirty: bool | None = None
    eval_set_id: str | None = None

    # Pass-through overrides
    eval_set_overrides: dict[str, Any] | None = None
    task_defaults: dict[str, Any] | None = None

    # Tag-based filtering
    task_filters: TagFilter | None = None
    sample_filters: TagFilter | None = None
