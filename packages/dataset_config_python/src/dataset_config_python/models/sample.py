"""Sample model — mirrors Inspect AI's Sample."""

from __future__ import annotations

from typing import Any

from pydantic import BaseModel


class Sample(BaseModel):
    """A sample for an evaluation task.

    Maps to Inspect AI's ``Sample`` class.
    """

    input: str
    """The input to be submitted to the model."""

    target: str = ""
    """Ideal target output."""

    id: str | None = None
    """Unique identifier for the sample."""

    choices: list[str] | None = None
    """Available answer choices (multiple-choice evals only)."""

    metadata: dict[str, Any] | None = None
    """Arbitrary metadata associated with the sample."""

    sandbox: Any | None = None
    """Sandbox environment type and optional config file."""

    files: dict[str, str] | None = None
    """Files that go along with the sample (copied to SandboxEnvironment)."""

    setup: str | None = None
    """Setup script to run for sample."""
