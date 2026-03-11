"""Writer — serializes EvalSet objects to JSON files."""

from __future__ import annotations

import json
import os

from dataset_config_python.models.eval_set import EvalSet


def write_eval_sets(eval_sets: list[EvalSet], output_dir: str) -> str:
    """Write EvalSet JSON for the given resolved configs.

    Files are written to *output_dir*. Returns the path to the JSON file.

    Single config → single JSON object; multiple → JSON array.
    """
    os.makedirs(output_dir, exist_ok=True)
    json_path = os.path.join(output_dir, "eval_set.json")

    if len(eval_sets) == 1:
        json_content = eval_sets[0].model_dump(exclude_none=True)
    else:
        json_content = [es.model_dump(exclude_none=True) for es in eval_sets]

    with open(json_path, "w") as f:
        json.dump(json_content, f, indent=2)

    return json_path
