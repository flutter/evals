"""Sample model — mirrors Inspect AI's Sample."""

from __future__ import annotations

from typing import Any

from pydantic import BaseModel


class Sample(BaseModel):
    """A sample for an evaluation task.

    Maps to Inspect AI's ``Sample`` class.
    """

    input: str | list[Any]
    """The input to be submitted to the model.

    Can be a simple string or a list of ChatMessage-like objects.
    """

    target: str | list[str] = ""
    """Ideal target output.

    May be a literal value or narrative text to be used by a model grader.
    Can be a single string or a list of strings.
    """

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
