"""dataset_config_python — Configuration resolver for dash-evals.

Reads YAML config files (jobs, tasks, samples) and produces the
EvalSet JSON that dash_evals consumes.

No Dart SDK or Inspect AI dependency required.
"""

from dataset_config_python.resolver import resolve
from dataset_config_python.writer import write_eval_sets

__all__ = ["resolve", "write_eval_sets"]
