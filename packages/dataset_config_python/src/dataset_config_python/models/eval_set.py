"""EvalSet model — the output shape consumed by dash_evals."""

from __future__ import annotations

from typing import Any

from pydantic import BaseModel, Field

from dataset_config_python.models.task import Task


class EvalSet(BaseModel):
    """Resolved evaluation set ready for JSON serialization.

    The ``.model_dump()`` output of this model matches the JSON shape
    that ``dash_evals.runner.json_runner.run_from_json()`` consumes.
    """

    tasks: list[Task]
    """Task(s) to evaluate with inline datasets."""

    log_dir: str
    """Output path for logging results."""

    model: list[str] | None = None
    """Model(s) for evaluation."""

    sandbox: Any | None = None
    """Sandbox environment type."""

    # Retry settings
    retry_attempts: int | None = None
    retry_wait: float | None = None
    retry_connections: float | None = None
    retry_cleanup: bool | None = None
    retry_on_error: int | None = None

    # Error handling
    fail_on_error: float | None = None
    continue_on_fail: bool | None = None
    debug_errors: bool | None = None

    # Concurrency
    max_samples: int | None = None
    max_tasks: int | None = None
    max_subprocesses: int | None = None
    max_sandboxes: int | None = None

    # Logging
    log_level: str | None = None
    log_level_transcript: str | None = None
    log_format: str | None = None
    log_samples: bool | None = None
    log_realtime: bool | None = None
    log_images: bool | None = None
    log_buffer: int | None = None
    log_shared: int | None = None
    log_dir_allow_dirty: bool | None = None

    # Model config
    model_base_url: str | None = None
    model_args: dict[str, Any] = Field(default_factory=dict)
    model_roles: dict[str, str] | None = None
    task_args: dict[str, Any] = Field(default_factory=dict)
    model_cost_config: dict[str, Any] | None = None

    # Sandbox
    sandbox_cleanup: bool | None = None

    # Sample control
    limit: Any | None = None
    sample_id: Any | None = None
    sample_shuffle: Any | None = None
    epochs: Any | None = None

    # Misc
    tags: list[str] | None = None
    metadata: dict[str, Any] | None = None
    trace: bool | None = None
    display: str | None = None
    approval: Any | None = None
    solver: Any | None = None
    score: bool = True

    # Limits
    message_limit: int | None = None
    token_limit: int | None = None
    time_limit: int | None = None
    working_limit: int | None = None
    cost_limit: float | None = None

    # Bundling
    bundle_dir: str | None = None
    bundle_overwrite: bool = False
    eval_set_id: str | None = None
