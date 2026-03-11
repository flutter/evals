"""Custom solvers for dash-evals tasks."""

from .add_system_message import add_system_message
from .context_injector import context_injector
from .extract_code import extract_code
from .inject_test_files import inject_test_files
from .setup_workspace import setup_workspace
from .write_to_sandbox import write_to_sandbox

__all__ = [
    "add_system_message",
    "context_injector",
    "extract_code",
    "inject_test_files",
    "setup_workspace",
    "write_to_sandbox",
]
