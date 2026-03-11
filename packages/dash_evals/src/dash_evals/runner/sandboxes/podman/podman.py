"""Simple Podman sandbox environment for inspect_ai.

This module provides a minimal PodmanSandboxEnvironment that uses the Podman CLI
directly (not podman-compose) for running containers.
"""

import asyncio
import base64
import logging
import os
import tempfile
from pathlib import Path
from typing import Literal, Union, overload

from inspect_ai.util._sandbox.environment import (
    SandboxConnection,
    SandboxEnvironment,
    SandboxEnvironmentConfigType,
)
from inspect_ai.util._sandbox.limits import SandboxEnvironmentLimits
from inspect_ai.util._sandbox.registry import sandboxenv
from inspect_ai.util._subprocess import ExecResult

logger = logging.getLogger(__name__)

# Default Flutter sandbox image (built from dataset/sandboxes/podman/Containerfile)
DEFAULT_IMAGE = "localhost/flutter-sandbox:latest"


@sandboxenv(name="podman")
class PodmanSandboxEnvironment(SandboxEnvironment):
    """Simple Podman-based sandbox environment."""

    def __init__(self, container_id: str, working_dir: str = "/workspace"):
        super().__init__()
        self.container_id = container_id
        self._working_dir = working_dir

    @classmethod
    def config_files(cls) -> list[str]:
        return ["compose.yaml", "Containerfile", "Dockerfile"]

    @classmethod
    def default_concurrency(cls) -> int | None:
        return (os.cpu_count() or 1) * 2

    @classmethod
    async def task_init(cls, task_name: str, config: SandboxEnvironmentConfigType | None) -> None:
        """Validate podman is available."""
        try:
            proc = await asyncio.create_subprocess_exec(
                "podman",
                "--version",
                stdout=asyncio.subprocess.PIPE,
                stderr=asyncio.subprocess.PIPE,
            )
            _, stderr = await proc.communicate()
            if proc.returncode != 0:
                raise RuntimeError(f"Podman check failed: {stderr.decode()}")
        except FileNotFoundError:
            raise RuntimeError(
                "Podman executable not found. Please ensure podman is installed and in your PATH."
            )

    @classmethod
    async def sample_init(
        cls,
        task_name: str,
        config: SandboxEnvironmentConfigType | None,
        metadata: dict[str, str],
    ) -> dict[str, SandboxEnvironment]:
        """Start a container for this sample."""
        # Determine image from config or use default
        image = DEFAULT_IMAGE
        if isinstance(config, str) and not config.endswith((".yaml", ".yml")):
            image = config

        # Start container (no TTY to avoid control chars, sleep to keep running)
        # Mount /tmp so workspace files copied by setup_workspace are accessible
        tmp_dir = tempfile.gettempdir()
        cmd = [
            "podman",
            "run",
            "-d",
            "--rm",
            "-v",
            f"{tmp_dir}:{tmp_dir}",  # Mount temp dir for workspace sharing
            image,
            "sleep",
            "infinity",
        ]

        try:
            proc = await asyncio.create_subprocess_exec(
                *cmd,
                stdout=asyncio.subprocess.PIPE,
                stderr=asyncio.subprocess.PIPE,
            )
            stdout, stderr = await proc.communicate()

            if proc.returncode != 0:
                raise RuntimeError(f"Failed to start podman container: {stderr.decode()}")
        except FileNotFoundError:
            raise RuntimeError(
                "Podman executable not found. Please ensure podman is installed and in your PATH."
            )

        container_id = stdout.decode().strip()
        logger.info(f"Started podman container: {container_id[:12]}")

        return {"default": cls(container_id=container_id)}

    @classmethod
    async def sample_cleanup(
        cls,
        task_name: str,
        config: SandboxEnvironmentConfigType | None,
        environments: dict[str, SandboxEnvironment],
        interrupted: bool,
    ) -> None:
        """Stop and remove containers."""
        for env in environments.values():
            if isinstance(env, PodmanSandboxEnvironment):
                logger.info(f"Cleaning up container: {env.container_id[:12]}")
                await asyncio.create_subprocess_exec(
                    "podman",
                    "rm",
                    "-f",
                    env.container_id,
                    stdout=asyncio.subprocess.DEVNULL,
                    stderr=asyncio.subprocess.DEVNULL,
                )

    @classmethod
    async def task_cleanup(
        cls, task_name: str, config: SandboxEnvironmentConfigType | None, cleanup: bool
    ) -> None:
        """No task-level cleanup needed - containers are removed per-sample."""
        pass

    @classmethod
    async def cli_cleanup(cls, id: str | None) -> None:
        """CLI cleanup for orphaned containers."""
        if id:
            await asyncio.create_subprocess_exec(
                "podman",
                "rm",
                "-f",
                id,
                stdout=asyncio.subprocess.DEVNULL,
                stderr=asyncio.subprocess.DEVNULL,
            )

    async def exec(
        self,
        cmd: list[str],
        input: str | bytes | None = None,
        cwd: str | None = None,
        env: dict[str, str] | None = None,
        user: str | None = None,
        timeout: int | None = None,
        timeout_retry: bool = True,
        concurrency: bool = True,
        truncate: bool = True,
    ) -> ExecResult[str]:
        """Execute command inside the container."""
        if env is None:
            env = {}
        podman_cmd = ["podman", "exec", "-i"]

        # Working directory
        final_cwd = cwd if cwd else self._working_dir
        podman_cmd.extend(["--workdir", final_cwd])

        # User
        if user:
            podman_cmd.extend(["--user", user])

        # Environment variables
        for k, v in env.items():
            podman_cmd.extend(["--env", f"{k}={v}"])

        podman_cmd.append(self.container_id)
        podman_cmd.extend(cmd)

        proc = await asyncio.create_subprocess_exec(
            *podman_cmd,
            stdin=asyncio.subprocess.PIPE,
            stdout=asyncio.subprocess.PIPE,
            stderr=asyncio.subprocess.PIPE,
        )

        try:
            stdin_data = input.encode() if isinstance(input, str) else input
            stdout, stderr = await asyncio.wait_for(
                proc.communicate(input=stdin_data),
                timeout=timeout,
            )
        except asyncio.TimeoutError:
            try:
                proc.kill()
            except ProcessLookupError:
                pass
            raise TimeoutError(f"Command timed out after {timeout}s") from None

        stdout_decoded = stdout.decode("utf-8", errors="replace")
        stderr_decoded = stderr.decode("utf-8", errors="replace")

        # Truncate if too large
        if truncate:
            limit = SandboxEnvironmentLimits.MAX_EXEC_OUTPUT_SIZE
            if len(stdout_decoded) > limit:
                stdout_decoded = stdout_decoded[:limit] + "...[TRUNCATED]"
            if len(stderr_decoded) > limit:
                stderr_decoded = stderr_decoded[:limit] + "...[TRUNCATED]"

        return ExecResult(
            success=(proc.returncode == 0),
            returncode=proc.returncode or 0,
            stdout=stdout_decoded,
            stderr=stderr_decoded,
        )

    async def write_file(self, file: str, contents: str | bytes) -> None:
        """Write file to container."""
        # Ensure directory exists
        dir_path = Path(file).parent.as_posix()
        if dir_path and dir_path != ".":
            await self.exec(["mkdir", "-p", dir_path])

        # Handle binary content with base64 encoding via stdin (not command line)
        if isinstance(contents, bytes):
            b64_content = base64.b64encode(contents).decode("ascii")
            result = await self.exec(
                ["sh", "-c", f'base64 -d > "{file}"'],
                input=b64_content,
            )
        else:
            result = await self.exec(
                ["sh", "-c", f'cat > "{file}"'],
                input=contents,
            )

        if not result.success:
            if "permission denied" in result.stderr.lower():
                raise PermissionError(f"Permission denied writing {file}")
            raise RuntimeError(f"Failed to write file {file}: {result.stderr}")

    @overload
    async def read_file(self, file: str, text: Literal[True] = True) -> str: ...

    @overload
    async def read_file(self, file: str, text: Literal[False]) -> bytes: ...

    async def read_file(self, file: str, text: bool = True) -> Union[str, bytes]:
        """Read file from container."""
        if text:
            # Text mode: use cat directly
            result = await self.exec(["cat", file], truncate=False)
            if not result.success:
                if "No such file" in result.stderr:
                    raise FileNotFoundError(f"File not found: {file}")
                if "permission denied" in result.stderr.lower():
                    raise PermissionError(f"Permission denied reading {file}")
                raise RuntimeError(f"Failed to read file {file}: {result.stderr}")

            if len(result.stdout) > SandboxEnvironmentLimits.MAX_READ_FILE_SIZE:
                raise RuntimeError(f"File {file} exceeds size limit")
            return result.stdout
        else:
            # Binary mode: use base64 to transfer safely (-w0 disables line wrapping)
            result = await self.exec(["sh", "-c", f'base64 -w0 "{file}"'], truncate=False)
            if not result.success:
                if "No such file" in result.stderr:
                    raise FileNotFoundError(f"File not found: {file}")
                if "permission denied" in result.stderr.lower():
                    raise PermissionError(f"Permission denied reading {file}")
                raise RuntimeError(f"Failed to read file {file}: {result.stderr}")

            decoded = base64.b64decode(result.stdout.strip())
            if len(decoded) > SandboxEnvironmentLimits.MAX_READ_FILE_SIZE:
                raise RuntimeError(f"File {file} exceeds size limit")
            return decoded

    async def connection(self, *, user: str | None = None) -> SandboxConnection:
        """Get connection info for debugging."""
        cmd_parts = ["podman", "exec", "-it"]
        if user:
            cmd_parts.extend(["--user", user])
        cmd_parts.extend([self.container_id, "/bin/bash"])

        return SandboxConnection(
            type="podman",
            command=" ".join(cmd_parts),
            vscode_command=None,
            ports=None,
            container=self.container_id,
        )

    def default_polling_interval(self) -> float:
        return 0.2
