"""Thin CLI wrapper that resolves a dataset + job using dataset_config_python
and prints the resulting EvalSet JSON to stdout.

Usage:
    python tool/bin/resolve_python.py <dataset_path> <job_name>
"""

from __future__ import annotations

import json
import sys

from dataset_config_python import resolve  # pyrefly: ignore


def main() -> None:
    if len(sys.argv) != 3:
        raise SystemExit(
            "Usage: python tool/bin/resolve_python.py <dataset_path> <job_name>"
        )

    dataset_path = sys.argv[1]
    job_name = sys.argv[2]

    eval_sets = resolve(dataset_path=dataset_path, job_names=[job_name])

    # Match the writer's convention: single → object, multiple → array
    if len(eval_sets) == 1:
        json_content = eval_sets[0].model_dump(exclude_none=True)
    else:
        json_content = [es.model_dump(exclude_none=True) for es in eval_sets]

    # Sort keys for stable comparison
    print(json.dumps(json_content, indent=2, sort_keys=True))


if __name__ == "__main__":
    main()
