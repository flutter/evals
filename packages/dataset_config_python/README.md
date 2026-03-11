# dataset_config_python

Configuration resolver for [dash-evals](../dash_evals/). Reads YAML config
files (jobs, tasks, samples) and produces the EvalSet JSON that `dash_evals`
consumes.

**No Dart SDK or Inspect AI dependency required** — install this package alone
to resolve configs from Python.

## Quick start

```python
from dataset_config_python import resolve, write_eval_sets

eval_sets = resolve(dataset_path="./my_dataset", job_names=["local_dev"])
write_eval_sets(eval_sets, output_dir=".devals-tool/local_dev")
```
