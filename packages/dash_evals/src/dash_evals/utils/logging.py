"""Logging utilities for the dash-evals runner.

Provides file and console logging for tracing runner execution.
"""

import logging
import sys
from contextlib import contextmanager
from datetime import datetime, timezone
from pathlib import Path
from typing import TextIO


class TeeStream:
    """A stream that writes to both the original stream and a file."""

    def __init__(self, original: TextIO, log_file: TextIO):
        self.original = original
        self.log_file = log_file

    def write(self, text: str) -> int:
        """Write to both streams."""
        self.original.write(text)
        # Strip ANSI codes for cleaner log file
        clean_text = _strip_ansi(text)
        self.log_file.write(clean_text)
        return len(text)

    def flush(self) -> None:
        """Flush both streams."""
        self.original.flush()
        self.log_file.flush()

    def fileno(self) -> int:
        """Return the file descriptor of the original stream."""
        return self.original.fileno()

    def isatty(self) -> bool:
        """Return whether the original stream is a tty."""
        return self.original.isatty()


def _strip_ansi(text: str) -> str:
    """Remove ANSI escape codes from text."""
    import re

    ansi_escape = re.compile(r"\x1B(?:[@-Z\\-_]|\[[0-?]*[ -/]*[@-~])")
    return ansi_escape.sub("", text)


@contextmanager
def capture_output(log_file_path: Path):
    """Context manager to capture stdout/stderr to a log file.

    Args:
        log_file_path: Path to the log file to append output to.

    Yields:
        None - stdout/stderr are captured during the context.
    """
    # Open log file in append mode
    log_file = open(log_file_path, "a", encoding="utf-8")

    # Save original streams
    original_stdout = sys.stdout
    original_stderr = sys.stderr

    try:
        # Replace with tee streams
        sys.stdout = TeeStream(original_stdout, log_file)  # type: ignore
        sys.stderr = TeeStream(original_stderr, log_file)  # type: ignore
        yield
    finally:
        # Restore original streams
        sys.stdout = original_stdout
        sys.stderr = original_stderr
        log_file.close()


def setup_logging(log_dir: Path, name: str = "dash_evals") -> tuple[logging.Logger, Path]:
    """Configure logging to both console and file.

    Args:
        log_dir: Directory to write log files
        name: Logger name (default: dash_evals)

    Returns:
        Tuple of (configured logger instance, log file path)
    """
    # Create logger
    logger = logging.getLogger(name)
    logger.setLevel(logging.DEBUG)
    logger.propagate = False  # Prevent duplicate output to root logger

    # Clear any existing handlers (avoid duplicates)
    logger.handlers.clear()

    # Console handler (INFO level)
    console_handler = logging.StreamHandler()
    console_handler.setLevel(logging.INFO)
    console_format = logging.Formatter(
        "%(asctime)s - %(levelname)s - %(message)s",
        datefmt="%H:%M:%S",
    )
    console_handler.setFormatter(console_format)
    logger.addHandler(console_handler)

    # File handler (DEBUG level - more verbose)
    log_dir.mkdir(parents=True, exist_ok=True)
    timestamp = datetime.now(timezone.utc).strftime("%Y-%m-%d_%H-%M-%S")
    log_file = log_dir / f"runner_{timestamp}.log"

    file_handler = logging.FileHandler(log_file, encoding="utf-8")
    file_handler.setLevel(logging.DEBUG)
    file_format = logging.Formatter(
        "%(asctime)s - %(name)s - %(levelname)s - %(funcName)s:%(lineno)d - %(message)s",
        datefmt="%Y-%m-%d %H:%M:%S",
    )
    file_handler.setFormatter(file_format)
    logger.addHandler(file_handler)

    logger.info(f"📝 Runner log: {log_file}")
    return logger, log_file
