"""MCP server configuration model — declarative or Python import ref."""

from __future__ import annotations

from typing import Any

from pydantic import BaseModel, Field, model_validator


class McpServerConfig(BaseModel):
    """MCP server configuration.

    Supports two modes:
    1. **Declarative** — specify command, args, env, etc. directly.
    2. **Python ref** — point to a pre-built MCPServer object via
       ``ref: "my_package.module:variable_name"``.

    When ``ref`` is set, all other fields are ignored.
    """

    # Declarative fields
    name: str | None = None
    """Human-readable server name (e.g. ``"dart"``)."""

    command: str | None = None
    """Executable to run (e.g. ``"dart"``)."""

    args: list[str] = Field(default_factory=list)
    """Command-line arguments (e.g. ``["mcp-server"]``)."""

    env: dict[str, str] | None = None
    """Extra environment variables for the server process."""

    cwd: str | None = None
    """Working directory for the server process."""

    transport: str | None = None
    """Transport type: ``"stdio"``, ``"sandbox"``, or ``None`` (auto-select)."""

    # Python import escape hatch
    ref: str | None = None
    """Python import path to a pre-built MCPServer object.

    Format: ``"module.path:variable_name"`` or ``"module.path:factory()"``.
    When set, all declarative fields above are ignored.
    """

    @model_validator(mode="after")
    def _validate_mode(self) -> McpServerConfig:
        if self.ref is None and self.command is None:
            raise ValueError(
                "McpServerConfig requires either 'ref' (Python import) "
                "or 'command' (declarative). Neither was provided."
            )
        return self

    @staticmethod
    def from_yaml(raw: Any) -> McpServerConfig:
        """Parse from YAML — accepts a dict or a string shorthand.

        String shorthand is treated as a ref:
            ``"my_package.mcp:server"`` → ``McpServerConfig(ref=...)``
        """
        if isinstance(raw, str):
            return McpServerConfig(ref=raw)
        if isinstance(raw, dict):
            return McpServerConfig(**raw)
        raise ValueError(f"Invalid MCP server config: {raw!r}")
