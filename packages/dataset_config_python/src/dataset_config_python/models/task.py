"""Task model — mirrors Inspect AI's Task configuration."""

from __future__ import annotations

from typing import Any

from pydantic import BaseModel

from dataset_config_python.models.dataset import Dataset


class Task(BaseModel):
    """A single evaluation task with inline dataset.

    Maps to the task definitions in the EvalSet JSON consumed by
    ``dash_evals.runner.json_runner``.
    """

    name: str = ""
    """Task name (e.g. ``"dart_qa:baseline"``)."""

    task_func: str | None = None
    """Task function identifier for hydration (e.g. ``"question_answer"``)."""

    dataset: Dataset | None = None
    """Inline dataset with samples."""

    sandbox: Any | None = None
    """Sandbox environment type."""

    metadata: dict[str, Any] | None = None
    """Task-level metadata (variant config, system message, etc.)."""

    model: str | None = None
    """Default model for this task."""

    config: dict[str, Any] | None = None
    """Model generation config."""

    model_roles: dict[str, str] | None = None
    """Named roles for use in get_model()."""

    approval: Any | None = None
    """Tool use approval policies."""

    epochs: Any | None = None
    """Epochs to repeat samples for."""

    fail_on_error: Any | None = None
    """Fail on sample errors."""

    continue_on_fail: bool | None = None
    """Continue running if fail_on_error condition is met."""

    message_limit: int | None = None
    """Limit on total messages per sample."""

    token_limit: int | None = None
    """Limit on total tokens per sample."""

    time_limit: int | None = None
    """Limit on clock time (in seconds) per sample."""

    working_limit: int | None = None
    """Limit on working time (in seconds) per sample."""

    cost_limit: float | None = None
    """Limit on total cost (in dollars) per sample."""

    early_stopping: Any | None = None
    """Early stopping callbacks."""

    display_name: str | None = None
    """Task display name."""

    version: Any = 0
    """Version of task."""
