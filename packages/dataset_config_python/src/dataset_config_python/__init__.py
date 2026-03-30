"""dataset_config_python — Configuration resolver for dash-evals.

Reads YAML config files (jobs, tasks, samples) and produces the
EvalSet JSON that dash_evals consumes.
"""

from dataset_config_python.hydrate import (
    build_dataset,
    build_task_metadata,
    create_mcp_servers,
    get_skill_tool,
)
from dataset_config_python.parser import ParsedTask, find_job_file, parse_job, parse_tasks
from dataset_config_python.resolver import (
    DEFAULT_SANDBOX_REGISTRY,
    SandboxConfig,
    resolve,
    resolve_from_parsed,
)
from dataset_config_python.writer import write_eval_sets

__all__ = [
    "DEFAULT_SANDBOX_REGISTRY",
    "ParsedTask",
    "SandboxConfig",
    "build_dataset",
    "build_task_metadata",
    "create_mcp_servers",
    "find_job_file",
    "get_skill_tool",
    "parse_job",
    "parse_tasks",
    "resolve",
    "resolve_from_parsed",
    "write_eval_sets",
]

