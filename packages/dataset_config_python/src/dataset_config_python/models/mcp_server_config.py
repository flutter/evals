"""MCP server configuration model — declarative or Python import ref."""

from __future__ import annotations

from typing import Any

from pydantic import BaseModel, Field, model_validator


class McpServerConfig(BaseModel):
    """MCP server configuration.

    Supports three modes:
    1. **Declarative stdio/sandbox** — specify command, args, env, etc.
    2. **Declarative HTTP** — specify url, and optionally headers/auth.
    3. **Python ref** — point to a pre-built MCPServer object via
       ``ref: "my_package.module:variable_name"``.

    When ``ref`` is set, all other fields are ignored.
    """

    # Declarative fields (stdio / sandbox)
    name: str | None = None
    """Human-readable server name (e.g. ``"dart"``)."""

    command: str | None = None
    """Executable to run (e.g. ``"dart"``). Required for stdio/sandbox transport."""

    args: list[str] = Field(default_factory=list)
    """Command-line arguments (e.g. ``["mcp-server"]``)."""

    env: dict[str, str] | None = None
    """Extra environment variables for the server process."""

    cwd: str | None = None
    """Working directory for the server process."""

    # Declarative fields (HTTP)
    url: str | None = None
    """URL endpoint for HTTP transport (e.g. ``"https://mcp.example.com/api"``)."""

    headers: dict[str, str] | None = None
    """HTTP headers to send with requests (e.g. for authentication)."""

    authorization: str | None = None
    """OAuth Bearer token for HTTP authentication.

    Maps to Inspect AI's ``authorization`` parameter on ``mcp_server_http``.
    """

    # Common
    transport: str | None = None
    """Transport type: ``"stdio"``, ``"sandbox"``, ``"http"``, or ``None`` (auto).

    Auto-selection logic:
    - If ``url`` is set → ``"http"``
    - If ``command`` is set and sandbox is non-local → ``"sandbox"``
    - If ``command`` is set and sandbox is local → ``"stdio"``
    """

    # Python import escape hatch
    ref: str | None = None
    """Python import path to a pre-built MCPServer object.

    Format: ``"module.path:variable_name"`` or ``"module.path:factory()"``.
    When set, all declarative fields above are ignored.
    """

    @model_validator(mode="after")
    def _validate_mode(self) -> McpServerConfig:
        if self.ref is None and self.command is None and self.url is None:
            raise ValueError(
                "McpServerConfig requires one of: 'ref' (Python import), "
                "'command' (stdio/sandbox), or 'url' (HTTP). "
                "None was provided."
            )
        if self.command is not None and self.url is not None:
            raise ValueError(
                "McpServerConfig cannot have both 'command' (stdio/sandbox) "
                "and 'url' (HTTP). Use one or the other."
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
