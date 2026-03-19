# About the framework

You've been using built-in task functions like `bug_fix` and `question_answer`.
This page explains how they work — useful if you want to write custom eval logic
or just understand what happens when you run `devals run`.

---

## Architecture overview

When you run an eval, data flows through three layers:

```
YAML config → Dart resolver → JSON manifest → Python runner → Inspect AI
```

| Layer | Package | What it does |
|-------|---------|-------------|
| **YAML config** | — | Your `task.yaml` and `job.yaml` files |
| **Dart resolver** | `dataset_config_dart` | Parses YAML, resolves globs and references, produces a JSON manifest |
| **Python runner** | `dash_evals` | Reads the manifest, builds Inspect AI `Task` objects, calls `eval_set()` |
| **Inspect AI** | `inspect_ai` | Runs solver chains, sends prompts, collects responses, runs scorers |

The `devals` CLI (Dart) orchestrates steps 1–2, then hands off to `run-evals`
(Python) for steps 3–4.

---

## The `dash_evals` package

### Entry point

The Python CLI entry point is `run-evals`, defined in
`dash_evals/main.py`. It supports two modes:

```bash
# Mode 1: From a JSON manifest (what devals uses)
run-evals --json ./eval_set.json

# Mode 2: Direct CLI arguments (what you used in Part 1)
run-evals --task question_answer --model google/gemini-2.0-flash --dataset samples.json
```

### JSON runner

When using `--json` mode, `json_runner.py` does the heavy lifting:

1. Reads the manifest file
2. For each task definition, resolves the task function by name
3. Builds an Inspect AI `MemoryDataset` from the inline samples
4. Calls the task function with the dataset and config
5. Collects all `Task` objects and calls `inspect_ai.eval_set()`

### Task resolution

The `func` field in your `task.yaml` is resolved to a Python function. Three
formats are supported:

| Format | Example | How it resolves |
|--------|---------|----------------|
| **Short name** | `question_answer` | Looks up `dash_evals.runner.tasks.question_answer` |
| **Colon syntax** | `my_package.tasks:my_task` | Imports `my_package.tasks`, gets `my_task` |
| **Dotted path** | `my_package.tasks.my_task.my_task` | Last segment is the function name |

Short names work for all built-in tasks. Use colon syntax or dotted paths for
custom tasks in external packages.

---

## Anatomy of a task function

Every task function follows the same pattern. Here's `question_answer` —
the simplest built-in task:

```python
from inspect_ai import Task, task
from inspect_ai.dataset import Dataset
from inspect_ai.scorer import model_graded_fact
from inspect_ai.solver import chain_of_thought

@task
def question_answer(dataset: Dataset, config: dict) -> Task:
    system_msg = config.get("system_message") or DEFAULT_QA_SYSTEM_MESSAGE

    solver_chain = [
        add_system_message(system_msg),      # 1. Set the system prompt
        # context_injector(...)              # 2. Inject context files (if variant has them)
        chain_of_thought(),                   # 3. Ask for step-by-step reasoning
        # generate() or react(tools=...)     # 4. Get the model's response
    ]

    return Task(
        name=config["task_name"],
        dataset=dataset,
        solver=solver_chain,
        scorer=model_graded_fact(),
        time_limit=300,
    )
```

**Key ingredients:**

| Part | Purpose |
|------|---------|
| `@task` | Decorator that registers this function with Inspect AI |
| `dataset` | An Inspect `Dataset` built from your samples |
| `config` | A dict with everything from the JSON manifest — variant, system_message, sandbox_type, etc. |
| **Solver chain** | A list of steps that process the prompt and generate a response |
| **Scorer** | Evaluates the model's output against the `target` |

### Solver chain patterns

Most tasks build their solver chain from shared helpers in `task_helpers.py`:

```python
def _build_solver(config, system_msg):
    chain = [add_system_message(system_msg)]

    # Inject context files from the variant
    append_context_injection(chain, config)

    # Add chain-of-thought reasoning
    chain.append(chain_of_thought())

    # If the variant has MCP servers → use react() agent
    # Otherwise → use plain generate()
    append_model_interaction(chain, config)

    return chain
```

This means that variants automatically affect the solver chain — if a variant
defines `mcp_servers`, the task switches from a simple generate call to a
full ReAct agent loop with tool access.

### Agentic vs. non-agentic tasks

| Pattern | Tasks that use it | What happens |
|---------|-------------------|-------------|
| **Non-agentic** | `question_answer`, `code_gen` | System message → chain of thought → single generate |
| **Agentic** | `bug_fix`, `analyze_codebase`, `mcp_tool` | System message → ReAct loop with tools (bash, text editor, MCP) |

Agentic tasks give the model tools (`bash_session()`, `text_editor()`, MCP servers)
and run in a `react()` loop where the model can take multiple actions before
calling `submit()`.

---

## Shared helpers

The `task_helpers.py` module contains functions used across all tasks:

| Helper | What it does |
|--------|-------------|
| `append_context_injection(chain, config)` | Adds a `context_injector` solver if the variant has `files` |
| `append_model_interaction(chain, config)` | Adds `react()` (if tools exist) or `generate()` (if not) |
| `get_skill_tool(config)` | Creates a skill tool if the variant has `skills` configured |
| `build_task_metadata(config)` | Builds the metadata dict for the `Task` object |
| `create_mcp_servers(configs, sandbox_type)` | Creates MCP server objects from variant config |
| `validate_sandbox_tools(config, tool_names)` | Checks that sandbox-requiring tools aren't used on local |

These helpers mean that most of the variant logic (context injection, MCP tools,
skills) is handled **automatically**. You just need to define the core solver
pattern for your task.

---

## Writing your own task

1. **Create a file** at `packages/dash_evals/src/dash_evals/runner/tasks/your_task.py`

2. **Write the task function:**

   ```python
   from inspect_ai import Task, task
   from inspect_ai.dataset import Dataset
   from inspect_ai.scorer import model_graded_fact

   from .task_helpers import (
       append_context_injection,
       append_model_interaction,
       build_task_metadata,
   )
   from ..solvers import add_system_message

   @task
   def your_task(dataset: Dataset, config: dict) -> Task:
       chain = [add_system_message("You are a helpful assistant.")]
       append_context_injection(chain, config)
       append_model_interaction(chain, config)

       return Task(
           name=config["task_name"],
           dataset=dataset,
           solver=chain,
           scorer=model_graded_fact(),
           metadata=build_task_metadata(config),
       )
   ```

3. **Export it** from `runner/tasks/__init__.py`:

   ```python
   from .your_task import your_task
   ```

4. **Reference it** in `task.yaml`:

   ```yaml
   func: your_task
   ```

   That's it — the JSON runner resolves the short name automatically.

---

## Built-in tasks

| Task function | Type | What it evaluates |
|--------------|------|-------------------|
| `question_answer` | Non-agentic | Q&A knowledge and reasoning |
| `code_gen` | Non-agentic | Code generation with structured output |
| `flutter_code_gen` | Non-agentic | Flutter-specific code gen (wraps `code_gen`) |
| `bug_fix` | Agentic | Diagnosing and fixing bugs with bash + editor |
| `flutter_bug_fix` | Agentic | Flutter-specific bug fix (wraps `bug_fix`) |
| `analyze_codebase` | Agentic | Exploring and answering questions about code |
| `mcp_tool` | Agentic | Testing MCP tool usage |
| `skill_test` | Agentic | Testing skill file usage in sandboxes |

---

## Further reading

- {doc}`/reference/yaml_config` — complete field-by-field YAML reference
- {doc}`/reference/configuration_reference` — directory structure and examples
- {doc}`/reference/cli` — full CLI command reference
- [Inspect AI documentation](https://inspect.aisi.org.uk/) — the underlying
  evaluation framework
