"""Variant model — evaluation variant configuration."""

from __future__ import annotations

from pydantic import BaseModel, Field

from dataset_config_python.models.context_file import ContextFile


class Variant(BaseModel):
    """A configuration variant for running evaluations.

    Variants define different testing configurations to compare model
    performance with and without specific tooling or context.

    Features are implied by field presence:
    - context_files populated → context injection enabled
    - mcp_servers populated → MCP tools enabled
    - skill_paths populated → agent skills enabled
    - all empty → baseline variant
    """

    name: str = "baseline"
    """User-defined variant name."""

    context_files: list[ContextFile] = Field(default_factory=list)
    """Loaded context files (paths resolved by config resolver)."""

    mcp_servers: list[str] = Field(default_factory=list)
    """MCP server keys to enable (e.g. ``['dart']``)."""

    skill_paths: list[str] = Field(default_factory=list)
    """Resolved paths to agent skill directories."""

    branch: str | None = None
    """SDK branch/channel to use (e.g. 'stable', 'beta', 'main')."""
