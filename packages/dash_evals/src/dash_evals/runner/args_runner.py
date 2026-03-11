import argparse
import logging
import sys
from pathlib import Path

logger = logging.getLogger(__name__)


def _run_from_args(args: argparse.Namespace) -> bool:
    """Build an eval_set call from individual CLI arguments.

    Returns:
        True if any tasks failed, False if all succeeded.
    """
    import inspect_ai

    from dash_evals.runner.json_runner import _resolve_task_func
    from dash_evals.utils.logging import setup_logging

    if not args.task:
        logger.error("--task is required in direct-args mode.")
        sys.exit(1)
    if not args.model:
        logger.error("--model is required in direct-args mode.")
        sys.exit(1)

    # Resolve task function
    task_func = _resolve_task_func(args.task)

    # Build dataset
    dataset = None
    if args.dataset:
        from inspect_ai.dataset import json_dataset

        dataset = json_dataset(str(args.dataset))

    # Build the task instance
    task_def = {"name": args.task}
    task_instance = task_func(dataset, task_def) if dataset else task_func(None, task_def)

    # Set up logging
    log_dir = args.log_dir or Path("./logs")
    log_dir.mkdir(parents=True, exist_ok=True)
    setup_logging(log_dir, name="dash_evals")

    # Build eval_set kwargs
    eval_kwargs: dict = {
        "log_dir": str(log_dir),
        "model": args.model,
    }
    if args.sandbox:
        eval_kwargs["sandbox"] = tuple(args.sandbox)
    if args.max_connections is not None:
        eval_kwargs["max_connections"] = args.max_connections
    if args.max_samples is not None:
        eval_kwargs["max_samples"] = args.max_samples
    if args.fail_on_error is not None:
        eval_kwargs["fail_on_error"] = args.fail_on_error

    logger.info(
        f"\n{'=' * 70}\n🚀 RUNNING task '{args.task}' with model(s): "
        f"{', '.join(args.model)}\n{'=' * 70}"
    )

    try:
        success, _ = inspect_ai.eval_set(
            tasks=[task_instance],
            **eval_kwargs,
        )
        return not success
    except Exception as e:
        logger.error(f"Evaluation failed: {e}")
        return True
