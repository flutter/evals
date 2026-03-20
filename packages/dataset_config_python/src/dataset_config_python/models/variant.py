"""Variant model — evaluation variant configuration."""

from __future__ import annotations

from typing import Any

from pydantic import BaseModel, Field

from dataset_config_python.models.context_file import ContextFile
from dataset_config_python.models.mcp_server_config import McpServerConfig


class Variant(BaseModel):
    """A configuration variant for running evaluations.

    Variants define different testing configurations to compare model
    performance with and without specific tooling or context.

    Features are implied by field presence:
    - files populated → context injection enabled
    - mcp_servers populated → MCP tools enabled
    - skills populated → agent skills enabled
    - all empty → baseline variant
    """

    name: str = "baseline"
    """User-defined variant name."""

    files: list[ContextFile] = Field(default_factory=list)
    """Loaded context files (paths resolved by config resolver)."""

    mcp_servers: list[McpServerConfig] = Field(default_factory=list)
    """MCP server configurations (declarative or Python import refs)."""

    skills: list[str] = Field(default_factory=list)
    """Resolved paths to agent skill directories."""

    task_parameters: dict[str, Any] = Field(default_factory=dict)
    """Optional parameters merged into the task config dict at runtime."""
