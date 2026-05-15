# Scorers Reference

Full reference for Inspect AI scorers, metrics, and epoch reducers.

## Built-In Scorer Details

### `exact()`
Normalizes whitespace/case/punctuation before comparing. Returns `CORRECT` if the
answer matches any of the targets.

### `match(location="end")`
- `location`: `"begin"` | `"end"` | `"any"` | `"exact"`
- Options: `ignore_case=True`, `ignore_punctuation=True`, `ignore_whitespace=True`

### `pattern(pattern: str, ignore_case=True)`
Extracts the first capture group from the regex. Use when the model is asked to
format its final answer in a specific way (e.g., `"Answer: (.*?)$"`).

### `model_graded_qa()` — full signature
```python
model_graded_qa(
    template: str | None = None,       # override the grading prompt template
    instructions: str | None = None,   # override just the instructions section
    grade_pattern: str | None = None,  # regex to extract grade (default: GRADE: [CI])
    include_history: bool | Callable = False,  # include full chat history in grading prompt
    partial_credit: bool = False,      # allow scores between 0 and 1
    model: str | Model | list | None = None,
    model_role: str | None = "grader",
)
```

Model selection precedence:
1. `model=` argument
2. Model bound to `model_role` via `eval(..., model_roles={"grader": "openai/gpt-4o"})`
3. The model currently being evaluated

### `model_graded_fact()`
Narrower than `model_graded_qa`. Good for: "does the response contain this fact?"
rather than holistic quality assessment.

---

## Custom Scorer Patterns

### Score object fields
```python
Score(
    value: int | float | str | bool,  # 1/0 for accuracy, float for mean, "C"/"I" for strings
    answer: str | None,               # extracted answer (shown in log viewer)
    explanation: str | None,          # reasoning (shown in log viewer)
    metadata: dict | None,            # arbitrary extra data stored in the log
)
```

### Accessing sandbox in a scorer
```python
@scorer(metrics=[accuracy(), stderr()])
def file_exists_scorer() -> Scorer:
    async def score(state: TaskState, target: Target) -> Score:
        sandbox = state.sandbox          # available when Task has sandbox=
        result = await sandbox.exec(["test", "-f", target.text])
        return Score(value=1 if result.returncode == 0 else 0)
    return score
```

---

## Multiple Scorers

### List of scorers — each runs independently
```python
Task(..., scorer=[exact(), model_graded_fact()])
```
Both scores appear in logs and metrics. Metrics are namespaced by scorer.

### Scorer returning multiple values
```python
@scorer(metrics={"precision": mean(), "recall": mean()})
def multi_value_scorer() -> Scorer:
    async def score(state, target):
        return Score(value={"precision": 0.8, "recall": 0.6})
    return score
```

### Reducing multiple scores to one
```python
from inspect_ai.scorer import max_score, at_least

Task(..., scorer=at_least(2, [exact(), match(), model_graded_qa()]))
# CORRECT if at least 2 of the 3 scorers agree
```

---

## Custom Metrics

```python
from inspect_ai.scorer import metric, Metric, Score

@metric
def pass_at_k(k: int = 5) -> Metric:
    """pass@k: did at least one of k attempts succeed?"""
    def calculate(scores: list[Score]) -> float:
        return 1.0 if any(s.value >= 1 for s in scores[:k]) else 0.0
    return calculate
```

Built-in metrics: `accuracy()`, `mean()`, `stderr()`, `bootstrap_stderr()`

### Metric grouping by metadata
```python
Task(..., scorer=match(), metrics=[accuracy(), mean()])
# Group metrics by a metadata field:
Task(..., scorer=match(), metrics=accuracy(groups=["difficulty", "category"]))
```

---

## Epoch Reducers

When `epochs > 1`, a reducer aggregates multiple scores per sample into one.

```python
from inspect_ai.scorer import mean, max_score, mode, at_least

Task(..., epochs=5, epochs_reducer=mean())      # average of all runs
Task(..., epochs=5, epochs_reducer=max_score()) # best run wins
Task(..., epochs=5, epochs_reducer=mode())      # majority vote
Task(..., epochs=5, epochs_reducer=at_least(3)) # pass if 3+ runs pass
```

### Custom reducer
```python
from inspect_ai.scorer import reducer, SampleScore

@reducer
def my_reducer() -> EpochReducer:
    def reduce(scores: list[SampleScore]) -> SampleScore:
        best = max(scores, key=lambda s: s.score.value)
        return best
    return reduce
```

---

## Re-scoring Without Re-running

You can re-score a completed eval from the log file:

```bash
inspect score eval.py --log-dir ./logs/<log-id>
```

Or from Python:
```python
from inspect_ai import score
from inspect_ai.log import read_eval_log
from my_evals import new_scorer

log = read_eval_log("logs/my-eval.json")
scored_log = score(log, scorer=new_scorer())
```

This is extremely useful when iterating on scorer logic without burning model tokens.