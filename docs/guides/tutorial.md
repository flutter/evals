# Author evals

This tutorial picks up where [Get Started](quick_start.md) left off.
By the end, you'll have:

1. Authored a task file with two **code-generation** samples
2. Created a job file that targets your new task
3. Run the job and watched Inspect AI execute it
4. Opened the Inspect log viewer to review results

> [!NOTE]
> This guide assumes you've already completed the [Get Started](quick_start.md) guide and
> have a working `devals` installation with at least one model API key configured.

---

## 1. Create the task

A **task** tells the framework *what* to evaluate. Each task lives in its own subdirectory
under `evals/tasks/` and contains a `task.yaml` file.

### 1.1 Set up a workspace

Code-generation tasks need a **workspace** — a starter project the model writes code into
and where tests run. Create a minimal Dart package to use as a template:

```
evals/
└── workspaces/
    └── dart_package/
        ├── pubspec.yaml
        └── lib/
            └── main.dart
```

```{code-block} yaml
---
caption: evals/workspaces/dart_package/pubspec.yaml
---
name: dart_package_template
description: Minimal Dart package template
version: 1.0.0
publish_to: none

environment:
  sdk: '>=3.0.0 <4.0.0'

dev_dependencies:
  test: ^1.24.0
```

```{code-block} dart
---
caption: evals/workspaces/dart_package/lib/main.dart
---
// Starter file — the model will overwrite this.
```

> [!TIP]
> You can also point `workspace` at your existing project root, a Flutter app,
> or any directory that already has a `pubspec.yaml`.

### 1.2 Write a test file

Each sample can have its own test file that the scorer runs automatically. Create a
test for the first sample:

```
evals/
└── tasks/
    └── dart_code_gen/
        ├── task.yaml           ← (you'll create this next)
        └── tests/
            └── fizzbuzz_test.dart
```

```{code-block} dart
---
caption: evals/tasks/dart_code_gen/tests/fizzbuzz_test.dart
---
import 'package:test/test.dart';
import 'package:dart_package_template/main.dart';

void main() {
  test('fizzBuzz returns correct values', () {
    expect(fizzBuzz(3), 'Fizz');
    expect(fizzBuzz(5), 'Buzz');
    expect(fizzBuzz(15), 'FizzBuzz');
    expect(fizzBuzz(7), '7');
  });

  test('fizzBuzz handles 1', () {
    expect(fizzBuzz(1), '1');
  });
}
```

### 1.3 Write the task.yaml

Now create the task definition with two inline samples:

```{code-block} yaml
---
caption: evals/tasks/dart_code_gen/task.yaml
---
# ============================================================
# Task: Dart Code Generation
# ============================================================
# Uses the built-in `code_gen` task function which:
#   1. Sends the prompt to the model
#   2. Parses the structured code response
#   3. Writes the code into the sandbox workspace
#   4. Runs tests and scores the result

func: code_gen
workspace: ../../workspaces/dart_package

samples:
  inline:
    # ── Sample 1: FizzBuzz ──────────────────────────────────
    - id: fizzbuzz
      difficulty: easy
      tags: [dart, functions]
      input: |
        Write a top-level function called `fizzBuzz` that takes an
        integer `n` and returns a String:
        - "Fizz" if n is divisible by 3
        - "Buzz" if n is divisible by 5
        - "FizzBuzz" if divisible by both
        - The number as a string otherwise

        Write the complete lib/main.dart file.
      target: |
        The code must define a top-level `String fizzBuzz(int n)` function
        that returns the correct value for all cases.
        It must pass the tests in test/.
      tests:
        path: ./tests/fizzbuzz_test.dart

    # ── Sample 2: Stack implementation ──────────────────────
    - id: stack_class
      difficulty: medium
      tags: [dart, data-structures, classes]
      input: |
        Implement a generic Stack<T> class in Dart with the
        following methods:
        - push(T item) — adds an item to the top
        - T pop() — removes and returns the top item,
          throws StateError if empty
        - T peek() — returns the top item without removing it,
          throws StateError if empty
        - bool get isEmpty
        - int get length

        Write the complete lib/main.dart file.
      target: |
        The code must define a generic Stack<T> class with push,
        pop, peek, isEmpty, and length. pop and peek must throw
        StateError when the stack is empty.
```

**Key fields explained:**

| Field | What it does |
|-------|-------------|
| `func` | The Python `@task` function that runs the evaluation. `code_gen` is a built-in generic code-generation task. |
| `workspace` | Path to the starter project (relative to the task directory). |
| `samples.inline` | A list of test cases, each with an `input` prompt and a `target` grading criteria. |
| `tests.path` | Path to test files the scorer runs against the generated code. |

> [!NOTE]
See [Tasks](../reference/configuration_reference.md#task-files) and [Samples](../reference/configuration_reference.md#sample-files) for the
> complete field reference.

---

## 2. Create the job

A **job** controls *how* to run your tasks — which models to use, how many
connections, and which tasks/variants to include.

Create `evals/jobs/tutorial.yaml`:

```{code-block} yaml
---
caption: evals/jobs/tutorial.yaml
---
# ============================================================
# Job: tutorial
# ============================================================
# A focused job for the tutorial walkthrough.

# Which model(s) to evaluate
models:
  - google/gemini-2.5-flash

# Only run the code-gen task we just created
tasks:
  inline:
    dart_code_gen: {}
```

That's the minimal job — it will:

- Evaluate `google/gemini-2.5-flash`
- Run every sample in the `dart_code_gen` task
- Use the default `baseline` variant (no extra tools or context)

> [!TIP]
> You can add **variants** to test the model with additional context or tools.
> For example:
> ```yaml
> variants:
>   baseline: {}
>   with_context:
>     context_files: [./context_files/dart_docs.md]
> ```
> See [Configuration Overview](../reference/configuration_reference.md#variants) for details.

---

## 3. Run the job

Make sure you're in your project directory (the one containing `devals.yaml`), then run:

```bash
devals run tutorial
```

What happens behind the scenes:

1. The Dart `dataset_config_dart` package resolves your YAML into an EvalSet JSON manifest
2. The Python `dash_evals` reads the manifest and calls Inspect AI's `eval_set()`
3. Inspect AI creates a sandbox, sets up the workspace, sends prompts, runs tests, and scores results
4. Logs are written to the `logs/` directory

### Dry run first

To preview the resolved configuration without making any API calls:

```bash
devals run tutorial --dry-run
```

This prints a summary of every task × model × variant combination that would
execute, so you can verify everything looks right before spending API credits.

### What to expect

When the eval runs, you'll see Inspect AI's interactive terminal display showing
progress for each sample. A typical run with two samples against one model takes
1–3 minutes, depending on the model's response time.

---

## 4. View the results

After the run completes, launch the Inspect AI log viewer:

```bash
devals view
```

This opens a local web UI (powered by Inspect AI) where you can:

- **Browse runs** — see each task × model × variant combination
- **Inspect samples** — view the model's generated code, scores, and any test output
- **Compare variants** — if you defined multiple variants, compare how they performed side-by-side

The viewer automatically points at your `logs/` directory. To view logs from a
specific directory:

```bash
devals view path/to/logs
```

---

## Next steps

Now that you've run your first custom evaluation, here are some things to try:

- **Add more samples** to your task: `devals create sample`
**Try different task types** — `question_answer`, `bug_fix`, or `flutter_code_gen`. See [all available task functions](../contributing/packages/dash_evals.md).
- **Add variants** to test how context files or MCP tools affect performance. See [Variants](config/about.md#variants).
- **Run multiple models** by adding more entries to the `models` list in your job file
- **Read the config reference** for [Jobs](../reference/configuration_reference.md#job-files), [Tasks](../reference/configuration_reference.md#task-files), and [Samples](../reference/configuration_reference.md#sample-files)