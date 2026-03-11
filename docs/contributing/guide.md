# Contributing

Welcome to the Dart/Flutter LLM evaluation project! This repository contains tools for running and analyzing AI model evaluations on Dart and Flutter tasks.

---

## Table of Contents

- [dash_evals](#dash_evals)
  - [Setup](#setup)
  - [Write a New Eval](#write-a-new-eval)
    - [Add Your Sample to the Dataset](#add-your-sample-to-the-dataset)
    - [Edit the Config to Run Only Your New Sample](#edit-the-config-to-run-only-your-new-sample)
    - [Verify the Sample Works](#verify-the-sample-works)
    - [What to Commit (and Not Commit!)](#what-to-commit-and-not-commit)
  - [Add Functionality to the Runner](#add-functionality-to-the-runner)
    - [Understand Tasks, Solvers, and Scorers](#understand-tasks-solvers-and-scorers)
    - [Add a New Task](#add-a-new-task)
    - [Test and Verify](#test-and-verify)
- [eval_explorer](#eval_explorer)

---

### Setup

1. **Prerequisites**
   - Python 3.13+
   - Podman or Docker (for sandbox execution)
   - API keys for the models you want to test

2. **Create and activate a virtual environment**

   ```bash
   cd packages/dash_evals
   python -m venv .venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   ```

3. **Install dependencies**

   ```bash
   pip install -e .          # Core dependencies
   pip install -e ".[dev]"   # Development dependencies (pytest, ruff, etc.)
   ```

4. **Configure API keys**

   You only need to configure the keys you plan on testing.

   ```bash
   export GEMINI_API_KEY=your_key_here
   export ANTHROPIC_API_KEY=your_key_here
   export OPENAI_API_KEY=your_key_here
   ```

5. **Verify installation**

   ```bash
   run-evals --help
   ```

---

### Write a New Eval

The most common contribution is adding new evaluation samples. Each sample tests a specific capability or scenario.

#### Add Your Sample to the Dataset

1. **Decide which task your sample belongs to**

   Review the available tasks in `dataset/tasks/` or run `devals create task` to see available task functions:

   | Task | Purpose |
   |------|---------| 
   | `question_answer` | Q&A evaluation for Dart/Flutter knowledge |
   | `bug_fix` | Agentic debugging of code in a sandbox |
   | `flutter_bug_fix` | Flutter-specific bug fix (wraps `bug_fix`) |
   | `code_gen` | Generate code from specifications |
   | `flutter_code_gen` | Flutter-specific code gen (wraps `code_gen`) |
   | `mcp_tool` | Test MCP tool usage |
   | `analyze_codebase` | Evaluate codebase analysis |
   | `skill_test` | Test skill file usage in sandboxes |

2. **Create your sample file**

   Use `devals create sample` for interactive sample creation, or add a sample inline in the task's `task.yaml` file under `dataset/tasks/<task_name>/task.yaml`:

   ```yaml
   id: dart_your_sample_id
   input: |
     Your prompt to the model goes here.
   target: |
     Criteria for grading the response. This is used by the scorer
     to determine if the model's output is acceptable.
   metadata:
     added: 2025-02-04
     tags: [dart, async]  # Optional categorization
   ```

   For agentic tasks (bug fix, code gen), you'll also need a workspace:

   ```yaml
   id: flutter_fix_some_bug
   input: |
     The app crashes when the user taps the submit button.
     Debug and fix the issue.
   target: |
     The fix should handle the null check in the onPressed callback.
   workspace:
     template: flutter_app   # Use a reusable template
     # OR
     path: ./project         # Custom project relative to sample directory
   ```

3. **Add your sample to the task's `task.yaml`**

   Add your sample inline in the appropriate task's `samples` list:

   ```yaml
   # dataset/tasks/dart_question_answer/task.yaml
   func: question_answer
   samples:
     - id: dart_your_sample_id
       input: |
         Your prompt to the model goes here.
       target: |
         Criteria for grading the response.
   ```

#### Edit the Config to Run Only Your New Sample

Before committing, test your sample by creating a job file. Use `devals create job` interactively, or manually create one in `dataset/jobs/`:

```yaml
# jobs/test_my_sample.yaml
name: test_my_sample

# Run only the task containing your sample
tasks:
  dart_question_answer:
    allowed_variants: [baseline]  # Start with baseline variant
    include-samples:
      - dart_your_sample_id  # Only run your specific sample

# Use a fast model for testing
models: [google/gemini-2.5-flash]
```

Then run with your job:

```bash
devals run test_my_sample
```

#### Verify the Sample Works

1. **Dry run first** — validates configuration without making API calls:

   ```bash
   devals run test_my_sample --dry-run
   ```

2. **Run the evaluation**:

   ```bash
   devals run test_my_sample
   ```

3. **Check the output** in the `logs/` directory. Verify:
   - The model received your prompt correctly
   - The scorer evaluated the response appropriately
   - No errors occurred during execution

#### What to Commit (and Not Commit!)

**Do commit:**
- Your updated task file(s) in `dataset/tasks/`
- Any new workspace templates or context files

**Do NOT commit:**
- Test job files in `dataset/jobs/` (if they were only for local testing)
- Log files in `logs/`
- API keys or `.env` files

Before submitting your PR, clean up any test job files you created:

```bash
git status  # Check for untracked/modified job files
```

---

### Add Functionality to the Runner

If you're adding new task types, scorers, or solvers, this section is for you.

#### Understand Tasks, Solvers, and Scorers

The dash_evals runner uses [Inspect AI](https://inspect.aisi.org.uk/) concepts:

| Component | Purpose | Location |
|-----------|---------|----------|
| **Task** | Defines what to evaluate — combines dataset, solver chain, and scorers | `runner/tasks/` |
| **Solver** | Processes inputs (e.g., injects context, runs agent loops) | `runner/solvers/` |
| **Scorer** | Evaluates outputs (e.g., model grading, dart analyze, flutter test) | `runner/scorers/` |

A typical task structure:

```python
from inspect_ai import Task, task
from inspect_ai.dataset import MemoryDataset

@task
def your_new_task(dataset: MemoryDataset, task_def: dict) -> Task:
    return Task(
        name=task_def.get("name", "your_new_task"),
        dataset=dataset,
        solver=[
            add_system_message("Your system prompt"),
            context_injector(task_def),
            # ... more solvers
        ],
        scorer=[
            model_graded_scorer(),
            dart_analyze_scorer(),
        ],
    )
```

#### Add a New Task

1. **Create your task file** at `src/dash_evals/runner/tasks/your_task.py`

2. **Export it** from `src/dash_evals/runner/tasks/__init__.py`:

   ```python
   from .your_task import your_new_task

   __all__ = [
       # ... existing tasks ...
       "your_new_task",
   ]
   ```

   Task functions are discovered dynamically via `importlib`. If the function name matches a module in `runner/tasks/`, it will be found automatically when referenced from a `task.yaml` file. No registry is needed.

3. **Create a task directory** in `dataset/tasks/`:

   ```
   dataset/tasks/your_task_id/
   └── task.yaml
   ```

   ```yaml
   # dataset/tasks/your_task_id/task.yaml
   func: your_new_task  # Must match the function name
   samples:
     - id: sample_001
       input: |
         Your prompt here.
       target: |
         Expected output or grading criteria.
   ```

#### Test and Verify

1. **Run the test suite**:

   ```bash
   cd packages/dash_evals
   pytest
   ```

2. **Run linting**:

   ```bash
   ruff check src/dash_evals
   ruff format src/dash_evals
   ```

3. **Test your task end-to-end**:

   ```bash
   devals run test_my_sample --dry-run  # Validate config
   devals run test_my_sample   # Run actual evaluation
   ```

---

## eval_explorer

A Dart/Flutter application for exploring evaluation results, built with [Serverpod](https://serverpod.dev/).

> [!NOTE]
> The eval_explorer is under active development. Contribution guidelines coming soon!

The package is located in `packages/eval_explorer/` and consists of:

| Package | Description |
|---------|-------------|
| `eval_explorer_client` | Dart client package |
| `eval_explorer_flutter` | Flutter web/mobile app |
| `eval_explorer_server` | Serverpod backend |
| `eval_explorer_shared` | Shared models |
