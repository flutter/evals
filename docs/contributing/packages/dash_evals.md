# dash_evals

Python package for running LLM evaluations on Dart and Flutter tasks using [Inspect AI](https://inspect.aisi.org.uk/). Located in `packages/dash_evals/`.

For setup instructions, see the [Quick Start](/guides/quick_start.md) or [Contributing Guide](../guide.md).

---

## Available Tasks

| Task | Description |
|------|-------------|
| `question_answer` | Q&A evaluation for Dart/Flutter knowledge |
| `bug_fix` | Agentic debugging of code in a sandbox |
| `flutter_bug_fix` | Flutter-specific bug fix (wraps `bug_fix`) |
| `code_gen` | Generate code from specifications |
| `flutter_code_gen` | Flutter-specific code gen (wraps `code_gen`) |
| `mcp_tool` | Evaluate MCP tool usage (pub.dev search, project creation, etc.) |
| `analyze_codebase` | Evaluate codebase analysis and comprehension |
| `skill_test` | Evaluate use of skill files in a sandbox |

---

## Architecture

```
src/dash_evals/
├── main.py              # CLI entry point (dual-mode)
├── runner/
│   ├── json_runner.py   # Mode 1: run from EvalSet JSON manifest
│   ├── args_runner.py   # Mode 2: run from direct CLI arguments
│   ├── tasks/           # @task functions (question_answer, bug_fix, code_gen, etc.)
│   ├── scorers/         # Scoring logic (model_graded, dart_analyze, flutter_test, etc.)
│   ├── solvers/         # Solver chains (context injection, system messages)
│   └── sandboxes/       # Sandbox environments (podman)
├── models/              # Data models
└── utils/               # Logging and helpers
```

### Data Flow

1. **Configure**: The Dart `dataset_config_dart` package parses dataset YAML and resolves it into an `EvalSet` JSON manifest
2. **Load**: The Python runner reads the JSON manifest via `json_runner.py`, resolving task functions dynamically with `importlib`
3. **Execute**: Each task function receives its dataset and task definition, producing an `inspect_ai.Task`
4. **Score**: Scorers evaluate model outputs against targets
5. **Log**: Results written to the configured `log_dir`

Alternatively, the runner can be invoked directly with `--task` and `--model` arguments (via `args_runner.py`), bypassing the Dart config pipeline.

---

## Usage

```bash
# Mode 1: Run from JSON manifest (produced by Dart CLI)
run-evals --json ./eval_set.json

# Mode 2: Run a single task directly
run-evals --task flutter_code_gen --model google/gemini-2.5-flash --dataset samples.jsonl

# Additional options (both modes)
run-evals --task bug_fix --model openai/gpt-4o \
  --log-dir ./logs \
  --sandbox podman compose.yaml \
  --max-connections 10
```

---

## Testing

```bash
# Run all tests
pytest

# Run with coverage
pytest --cov=dash_evals

# Run specific test
pytest tests/test_parsers.py -v
```

---

## Linting

```bash
# Run ruff
ruff check src/dash_evals
ruff format src/dash_evals
```
