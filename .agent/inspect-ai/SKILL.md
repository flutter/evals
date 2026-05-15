---
name: inspect-ai
description: >
  Expert guidance for building LLM evaluations with the Inspect AI framework
  (inspect-ai, UK AI Security Institute). Use this skill whenever the user is
  writing, running, debugging, or designing anything with Inspect AI — including
  defining Task objects, building datasets (CSV/JSON/HuggingFace), writing or
  chaining Solvers, writing custom Scorers, model-graded scoring, custom metrics,
  agentic evals, sandboxing, running evals via CLI or Python API, and reading
  eval logs. Also trigger when the user mentions @task, @solver, @scorer,
  TaskState, inspect eval, inspect view, chain_of_thought, model_graded_qa,
  model_graded_fact, or inspect_ai imports.
---

# Inspect AI Skill

Inspect AI is the open-source LLM evaluation framework from the UK AI Security
Institute. Docs live at https://inspect.aisi.org.uk/. This skill covers the
full authoring + execution workflow for experienced users.

## Core Mental Model

Every Inspect eval is:

```
Dataset → [Solver chain] → Scorer → Metrics
```

All of this is wrapped in a `Task`, decorated with `@task`, and run via
`inspect eval <file>.py --model <provider>/<model>`.

---

## 1. Tasks & Datasets

### Minimal task skeleton

```python
from inspect_ai import Task, task
from inspect_ai.dataset import csv_dataset
from inspect_ai.solver import generate
from inspect_ai.scorer import match

@task
def my_eval():
    return Task(
        dataset=csv_dataset("data.csv"),   # columns: input, target
        solver=generate(),
        scorer=match(),
    )
```

### Dataset loaders

| Function | Source |
|---|---|
| `csv_dataset(path)` | CSV with `input` / `target` columns |
| `json_dataset(path)` | JSONL with `input` / `target` fields |
| `hf_dataset(repo, split)` | HuggingFace datasets |
| `example_dataset(name)` | Built-in examples (e.g. `"theory_of_mind"`) |
| `MemoryDataset([Sample(...)])` | Constructed in-code |

### Sample fields

```python
from inspect_ai.dataset import Sample

Sample(
    input="Prompt text or list[ChatMessage]",
    target="Expected answer or rubric",
    id="optional-id",
    metadata={"key": "value"},   # accessible in solvers/scorers via state.metadata
)
```

### Filtering / shuffling

```python
csv_dataset("data.csv", shuffle=True, limit=100)
```

---

## 2. Solvers

Solvers transform `TaskState`. They can be chained or composed.

### Built-in solvers (import from `inspect_ai.solver`)

| Solver | What it does |
|---|---|
| `generate()` | Calls the model; appends assistant message; sets `state.output` |
| `system_message(text_or_file)` | Prepends a system message |
| `user_message(text_or_file)` | Appends a user message |
| `prompt_template(template)` | Rewrites the user prompt using `{prompt}` placeholder |
| `chain_of_thought()` | Adds CoT instruction to user message |
| `self_critique()` | Adds a self-critique round after `generate()` |
| `multiple_choice()` | Formats MCQ prompts; use with `choice()` scorer |
| `chain(*solvers)` | Composes a sequence of solvers |

### Writing a custom solver

```python
from inspect_ai.solver import solver, TaskState, Generate

@solver
def my_solver(config_param: str = "default"):
    async def solve(state: TaskState, generate: Generate) -> TaskState:
        # Modify state.messages or call generate
        state.messages.append(ChatMessageUser(content=config_param))
        state = await generate(state)
        return state
    return solve
```

Key points:
- `@solver` decorator is required so Inspect can discover it
- The inner function is `async`
- Use `state.store` (not `state.metadata`) for mutable per-sample data within solvers
- Calling `generate(state)` returns an updated state with `state.output` set
- Use `state.completed = True` to short-circuit remaining solvers early

### Accessing / mutating messages

```python
from inspect_ai.model import ChatMessageUser, ChatMessageSystem, ChatMessageAssistant

state.messages.append(ChatMessageUser(content="Follow-up question"))
last_assistant = [m for m in state.messages if isinstance(m, ChatMessageAssistant)][-1]
```

---

## 3. Scorers

See `references/scorers.md` for detailed scorer reference. Summary:

### Built-in scorers

| Scorer | Use when |
|---|---|
| `exact()` | Exact string match (normalized) |
| `match()` | Target at start/end of output |
| `includes()` | Target appears anywhere in output |
| `pattern(regex)` | Extract answer with regex |
| `answer(format)` | Output prefixed with "ANSWER:" |
| `model_graded_qa()` | Open-ended answers, rubric in `target` |
| `model_graded_fact()` | Factual claim buried in longer output |
| `choice()` | Multiple-choice; use with `multiple_choice()` solver |
| `math()` | Mathematical expressions (requires `sympy`) |

### Custom scorer skeleton

```python
from inspect_ai.scorer import scorer, Score, Scorer, Target, accuracy, stderr
from inspect_ai.solver import TaskState

@scorer(metrics=[accuracy(), stderr()])
def my_scorer() -> Scorer:
    async def score(state: TaskState, target: Target) -> Score:
        output = state.output.completion
        correct = target.text.lower() in output.lower()
        return Score(
            value=1 if correct else 0,
            answer=output,
            explanation=f"Looking for: {target.text}",
        )
    return score
```

### Model-graded custom scorer

```python
from inspect_ai.model import get_model, ChatMessageUser, ChatMessageSystem

@scorer(metrics=[accuracy(), stderr()])
def llm_rubric_scorer(model: str = "anthropic/claude-sonnet-4-20250514") -> Scorer:
    async def score(state: TaskState, target: Target) -> Score:
        grader = get_model(model)
        result = await grader.generate([
            ChatMessageSystem("You are a grader. Reply GRADE: C or GRADE: I only."),
            ChatMessageUser(
                f"Question: {state.input_text}\n"
                f"Ideal: {target.text}\n"
                f"Response: {state.output.completion}"
            ),
        ])
        text = result.completion
        correct = "GRADE: C" in text
        return Score(value=1 if correct else 0, explanation=text)
    return score
```

### Multiple scorers on one task

```python
Task(
    dataset=dataset,
    solver=generate(),
    scorer=[exact(), model_graded_qa()],   # both run; both appear in logs
)
```

### Custom metrics

```python
from inspect_ai.scorer import metric, Metric, Score

@metric
def my_metric() -> Metric:
    def calculate(scores: list[Score]) -> float:
        return sum(s.value for s in scores if s.value > 0.5) / len(scores)
    return calculate
```

---

## 4. End-to-End Workflow

### Running evals

```bash
# CLI (most common)
inspect eval eval.py --model anthropic/claude-sonnet-4-0

# Multiple tasks in one file
inspect eval eval.py@task_name --model openai/gpt-4o

# Pass task parameters
inspect eval eval.py -T temperature=0.5 -T max_tokens=1024

# Limit samples for quick iteration
inspect eval eval.py --limit 20 --model openai/gpt-4o

# Retry / resume a failed run
inspect eval eval.py --log-dir ./logs --resume-eval <log-id>
```

### Running from Python

```python
from inspect_ai import eval
from .my_evals import my_task

logs = eval(my_task(), model="anthropic/claude-sonnet-4-0")
log = logs[0]
print(log.results)   # EvalResults with metrics
```

### Viewing logs

```bash
inspect view           # opens browser-based log viewer (auto-refreshes)
inspect view --port 9999  # custom port
```

Or use the VS Code Extension for integrated log browsing.

### Log structure (Python API)

```python
from inspect_ai.log import read_eval_log

log = read_eval_log("logs/my-eval-xxx.json")
log.results          # overall metrics
log.samples          # list of EvalSample
log.samples[0].scores       # per-sample scores
log.samples[0].messages     # full chat transcript
log.samples[0].metadata     # dataset metadata
```

---

## 5. Agentic Evals & Advanced Patterns

For agent evals (tools, sandboxing, ReAct loops), read `references/agents.md`.
For full sandboxing, files, and workspace details, read `references/sandboxing.md`.

Quick reference:

- **Tools**: import from `inspect_ai.tool` or define with `@tool`
- **Sandboxing**: add `sandbox="docker"` to `Task()`; define `compose.yaml` alongside eval file; access sandbox in tools/solvers/scorers via `sandbox()` from `inspect_ai.util`
- **Per-sample files**: pass `files={"filename": "contents_or_path"}` to `Sample()` — copied into sandbox before sample runs; prefix key with `"servicename:"` to target a named sandbox
- **Setup script**: pass `setup="bash script"` (or file path) to `Sample()` — runs after files are copied
- **ReAct agent**: `from inspect_ai.agent import react_agent` — use as a solver
- **Subtask isolation**: `@subtask` decorator wraps a function with its own transcript scope
- **`TaskState.store`**: preferred mutable key-value store within a sample's lifetime

---

## 6. Common Patterns & Pitfalls

**Use `state.store` not `state.metadata`** inside solvers for mutable data — metadata is read-only input from the dataset.

**Don't call `generate()` twice accidentally** when chaining — each call consumes tokens and appends to history.

**Model grading uses the eval model by default.** Specify `model=` in `model_graded_qa()` to use a separate grader.

**Scorer `target` is a `Target` object.** Access the string with `target.text` or iterate `target.target` for multi-value targets.

**`@task` is required** for `inspect eval` CLI to discover your task. Without it, the eval file won't run.

**Epochs / multiple runs per sample:**
```python
Task(..., epochs=3, epochs_reducer=mean())   # run each sample 3x, reduce scores
```

---

## Reference Files

- `references/scorers.md` — Full scorer API, custom metrics, multi-scorer patterns, epoch reducers
- `references/agents.md` — Tools, ReAct agent, multi-agent, custom agents, @subtask, tool approval, observability
- `references/sandboxing.md` — **Complete sandboxing reference**: environment types, compose.yaml patterns, per-sample files & setup scripts, full SandboxEnvironment API (exec/read_file/write_file), multi-sandbox setups, programmatic config, resource management, cleanup, troubleshooting

Read these when you need depth on those topics.