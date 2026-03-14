"""Thin shim: read InspectEvalSet JSON, build Tasks, call eval_set().

The JSON file maps ~1:1 to eval_set() kwargs. The 'tasks' key contains
task definitions with inline datasets (InspectDataset with InspectSample
objects).
"""

import importlib
import json
import logging
from pathlib import Path

import inspect_ai
from inspect_ai.dataset import MemoryDataset, Sample

from dash_evals.utils.logging import capture_output, setup_logging

logger = logging.getLogger(__name__)

# Keys in the JSON that are NOT eval_set() kwargs.
# They are consumed separately to build Task objects.
_NON_EVAL_SET_KEYS = {"tasks"}


def _resolve_task_func(name: str):
    """Resolve a task function by name using importlib.

    Supports:
    - Short names: "flutter_code_gen" → dash_evals.runner.tasks.flutter_code_gen
    - Colon syntax: "my_package.tasks:my_task" → import my_package.tasks, get my_task
    - Dotted paths: "dash_evals.runner.tasks.flutter_code_gen.flutter_code_gen"

    For short names, first tries to import a module with the same name.
    If that fails, falls back to looking up the function in the tasks
    package's __init__ (e.g., flutter_bug_fix is exported from bug_fix.py
    via __init__.py).

    Returns the callable task function.
    """
    # Colon syntax: "module.path:function_name"
    if ":" in name:
        module_path, func_name = name.split(":", 1)
        try:
            module = importlib.import_module(module_path)
        except ModuleNotFoundError:
            raise ValueError(
                f"Could not find module '{module_path}' for task function '{name}'. "
                f"Check that the module exists and is importable."
            )
        func = getattr(module, func_name, None)
        if func is None:
            raise ValueError(f"Module '{module_path}' does not have a function '{func_name}'.")
        return func

    if "." not in name:
        # Short name: try module with the same name first
        module_path = f"dash_evals.runner.tasks.{name}"
        func_name = name
        try:
            module = importlib.import_module(module_path)
            func = getattr(module, func_name, None)
            if func is not None:
                return func
        except ModuleNotFoundError:
            pass

        # Fall back to the tasks package __init__ (handles re-exports
        # like flutter_bug_fix from bug_fix.py)
        package = importlib.import_module("dash_evals.runner.tasks")
        func = getattr(package, func_name, None)
        if func is not None:
            return func

        raise ValueError(
            f"Could not find task function '{name}'. "
            f"Check that the function exists in dash_evals.runner.tasks "
            f"and is exported in __init__.py."
        )
    else:
        # Dotted path: last segment is the function name
        module_path, _, func_name = name.rpartition(".")

        try:
            module = importlib.import_module(module_path)
        except ModuleNotFoundError:
            raise ValueError(
                f"Could not find module '{module_path}' for task function '{name}'. "
                f"Check that the module exists and is importable."
            )

        func = getattr(module, func_name, None)
        if func is None:
            raise ValueError(f"Module '{module_path}' does not have a function '{func_name}'.")
        return func


def _build_dataset_from_inline(task_def: dict) -> MemoryDataset:
    """Build an Inspect AI MemoryDataset from inline dataset in the task def.

    The task_def["dataset"]["samples"] contains a list of InspectSample dicts.
    """
    dataset_def = task_def.get("dataset")
    if not dataset_def:
        return MemoryDataset([], name=task_def.get("name", ""))

    raw_samples = dataset_def.get("samples", [])
    samples = []
    for raw in raw_samples:
        sample = Sample(
            input=raw["input"],
            target=raw.get("target", ""),
            id=raw.get("id"),
            metadata=raw.get("metadata"),
            files=raw.get("files"),
            setup=raw.get("setup"),
            sandbox=raw.get("sandbox"),
        )
        samples.append(sample)

    return MemoryDataset(
        samples,
        name=dataset_def.get("name", task_def.get("name", "")),
    )


def run_from_json(manifest_path: str | Path) -> bool:
    """Load an InspectEvalSet JSON, build Tasks, and call eval_set().

    Args:
        manifest_path: Path to eval_set.json emitted by the Dart CLI.

    Returns:
        True if any tasks failed, False if all succeeded.
    """
    manifest_path = Path(manifest_path)

    with open(manifest_path) as f:
        raw = json.load(f)

    # Support single eval_set or list (one per flutter channel)
    manifests = raw if isinstance(raw, list) else [raw]

    any_failures = False
    for manifest in manifests:
        if _run_single_manifest(manifest):
            any_failures = True

    return any_failures


def _run_single_manifest(manifest: dict) -> bool:
    """Run a single InspectEvalSet entry.

    Returns True if any tasks failed.
    """
    log_dir = manifest["log_dir"]
    Path(log_dir).mkdir(parents=True, exist_ok=True)
    job_logger, log_file_path = setup_logging(Path(log_dir), name="dash_evals")

    # Build Task objects from inline datasets
    task_defs = manifest["tasks"]
    task_instances: list[inspect_ai.Task] = []

    for task_def in task_defs:
        task_func_name = task_def.get("func")
        task_name = task_def.get("name", task_func_name or "(unknown)")

        if not task_func_name:
            # Mode 2: hydrate directly from JSON (future)
            job_logger.warning(
                f"  ⚠ {task_name}: no func — Mode 2 hydration not yet supported"
            )
            continue

        try:
            task_func = _resolve_task_func(task_func_name)
        except ValueError as e:
            job_logger.warning(f"  ✗ {task_name}: {e}")
            continue

        # Build inline dataset
        dataset = _build_dataset_from_inline(task_def)

        # Inject task_name into the config for task functions that expect it.
        # The Dart CLI emits "name" but task functions use "task_name".
        if "task_name" not in task_def and "name" in task_def:
            task_def["task_name"] = task_def["name"]

        # Inject sandbox_type for task functions that check it.
        # The Dart CLI emits "sandbox" as ["type", "path"] or a string,
        # but task functions check "sandbox_type".
        if "sandbox_type" not in task_def:
            sandbox = task_def.get("sandbox") or manifest.get("sandbox")
            if isinstance(sandbox, list) and len(sandbox) >= 1:
                task_def["sandbox_type"] = sandbox[0]
            elif isinstance(sandbox, str) and sandbox != "local":
                task_def["sandbox_type"] = sandbox

        try:
            task_instance = task_func(dataset, task_def)
            task_instances.append(task_instance)
            job_logger.info(f"  ✓ {task_name} ({len(dataset)} samples)")
        except Exception as e:
            job_logger.error(f"  ✗ {task_name}: {e}")

    if not task_instances:
        job_logger.warning("No valid tasks to run")
        return True

    # Build eval_set kwargs from remaining manifest keys
    eval_set_kwargs = {k: v for k, v in manifest.items() if k not in _NON_EVAL_SET_KEYS}

    # Convert sandbox list to tuple (eval_set expects tuple for ("type", "path"))
    sandbox = eval_set_kwargs.get("sandbox")
    if isinstance(sandbox, list) and len(sandbox) == 2:
        eval_set_kwargs["sandbox"] = tuple(sandbox)

    job_logger.info(f"\n{'=' * 70}\n🚀 RUNNING {len(task_instances)} TASKS\n{'=' * 70}")

    try:
        with capture_output(log_file_path):
            success, _ = inspect_ai.eval_set(
                tasks=task_instances,
                **eval_set_kwargs,
            )
        return not success
    except Exception as e:
        job_logger.error(f"Evaluation failed: {e}")
        return True
