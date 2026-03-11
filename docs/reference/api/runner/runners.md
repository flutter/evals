# Runners

Core evaluation execution logic. The runner module provides two entry points:

---

## JSON Runner

Reads an `eval_set.json` manifest (emitted by the Dart CLI) and calls `eval_set()`.

```{eval-rst}
.. automodule:: dash_evals.runner.json_runner
   :members:
   :undoc-members:
   :show-inheritance:
```

---

## Args Runner

Runs a single task directly from CLI arguments (`--task`, `--model`, `--dataset`).

```{eval-rst}
.. automodule:: dash_evals.runner.args_runner
   :members:
   :undoc-members:
   :show-inheritance:
```
