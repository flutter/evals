# Copyright 2025 The Flutter Authors. All rights reserved.
# Use of this source code is governed by a BSD-style license that can be
# found in the LICENSE file.

"""CLI entry point for running evaluations.

Usage:
    run-evals --json ./eval_set.json
    run-evals --task my_task --model openai/gpt-4o --dataset samples.jsonl
"""

import argparse
import logging
import sys
from pathlib import Path

from dotenv import load_dotenv

# Import sandbox environments to register them with InspectAI
# The @sandboxenv decorator registers the sandbox type when the module is imported
import dash_evals.runner.sandboxes.podman.podman  # noqa: F401  # Registers 'podman'
from dash_evals.runner.args_runner import _run_from_args
from dash_evals.runner.json_runner import run_from_json

# Basic console logger for early startup messages
logging.basicConfig(level=logging.INFO, format="%(message)s")
_startup_logger = logging.getLogger("startup")


def main():
    """Parse command-line arguments and run evaluations."""
    # Load .env from the repo root (walks up from cwd).
    # This populates os.environ with API keys, credentials, etc.
    # System env vars take precedence over .env values (python-dotenv default).
    load_dotenv(override=False)

    parser = argparse.ArgumentParser(
        description="Run Inspect AI evaluations for the Dart/Flutter plugin.",
        epilog="Example: run-evals --json ./eval_set.json",
    )

    # ---------- JSON mode (mutually exclusive with direct args) ----------
    parser.add_argument(
        "--json",
        type=Path,
        help="Path to eval_set.json (emitted by Dart CLI).",
    )

    # ---------- Direct-args mode ----------
    parser.add_argument(
        "--task",
        type=str,
        help="Task function name (e.g. 'flutter_code_gen' or dotted path).",
    )
    parser.add_argument(
        "--model",
        type=str,
        action="append",
        help="Model to evaluate (can be repeated). Example: openai/gpt-4o",
    )
    parser.add_argument(
        "--dataset",
        type=Path,
        help="Path to a dataset file (JSON/JSONL/CSV).",
    )
    parser.add_argument(
        "--log-dir",
        type=Path,
        help="Directory to write evaluation logs.",
    )
    parser.add_argument(
        "--sandbox",
        type=str,
        nargs=2,
        metavar=("TYPE", "CONFIG"),
        help="Sandbox type and config path. Example: podman compose.yaml",
    )
    parser.add_argument(
        "--max-connections",
        type=int,
        help="Maximum concurrent model connections.",
    )
    parser.add_argument(
        "--max-samples",
        type=int,
        help="Maximum concurrent samples per task.",
    )
    parser.add_argument(
        "--fail-on-error",
        type=float,
        help="Proportion of sample errors to tolerate (0.0-1.0).",
    )

    args = parser.parse_args()

    # Ensure either --json or direct args are provided, but not both.
    direct_args_provided = any([args.task, args.model, args.dataset])
    if args.json and direct_args_provided:
        parser.error(
            "Cannot combine --json with --task/--model/--dataset. Use one mode or the other."
        )
    if not args.json and not direct_args_provided:
        parser.error("Provide either --json or at least --task and --model.")

    try:
        if args.json:
            has_failures = run_from_json(args.json)
        else:
            has_failures = _run_from_args(args)
    except Exception as e:
        _startup_logger.error(f"Failed to run evaluation: {e}")
        sys.exit(1)

    sys.exit(1 if has_failures else 0)


if __name__ == "__main__":
    main()
