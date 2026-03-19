# Author your first eval

In {doc}`Part 1 <get_started>` you installed the tools and ran a pre-built eval.
Now you'll write one from scratch — an **agentic** evaluation where the model
explores a codebase, diagnoses a bug, and fixes it.

By the end of this page you'll have:

1. Created a workspace with a deliberate bug
2. Written a task file that uses the `bug_fix` task function
3. Run the eval and reviewed the model's fix
4. Added a **variant** to see how extra context changes the result

> [!NOTE]
> This guide assumes you've completed {doc}`Part 1 <get_started>` and have
> a working installation with at least one model API key configured.

---

## 1. Set up a workspace

Agentic tasks need a **workspace** — a project that gets copied into a sandbox
for the model to work with. Let's create a small Dart package with a deliberate bug.

Inside your project (the directory with `devals.yaml`), create:

```
evals/
└── workspaces/
    └── buggy_dart_package/
        ├── pubspec.yaml
        ├── lib/
        │   └── math_utils.dart
        └── test/
            └── math_utils_test.dart
```

```{code-block} yaml
---
caption: evals/workspaces/buggy_dart_package/pubspec.yaml
---
name: buggy_dart_package
description: A Dart package with a deliberate bug for eval testing.
version: 1.0.0
publish_to: none

environment:
  sdk: '>=3.0.0 <4.0.0'

dev_dependencies:
  test: ^1.24.0
```

```{code-block} dart
---
caption: evals/workspaces/buggy_dart_package/lib/math_utils.dart
---
/// Returns the factorial of [n].
///
/// Throws [ArgumentError] if [n] is negative.
int factorial(int n) {
  if (n < 0) throw ArgumentError('n must be non-negative');
  if (n <= 1) return 1;
  // BUG: should be n * factorial(n - 1)
  return n + factorial(n - 1);
}

/// Returns true if [n] is a prime number.
bool isPrime(int n) {
  if (n < 2) return false;
  for (var i = 2; i * i <= n; i++) {
    if (n % i == 0) return false;
  }
  return true;
}
```

```{code-block} dart
---
caption: evals/workspaces/buggy_dart_package/test/math_utils_test.dart
---
import 'package:test/test.dart';
import 'package:buggy_dart_package/math_utils.dart';

void main() {
  group('factorial', () {
    test('factorial(0) = 1', () => expect(factorial(0), 1));
    test('factorial(1) = 1', () => expect(factorial(1), 1));
    test('factorial(5) = 120', () => expect(factorial(5), 120));
    test('factorial(10) = 3628800', () => expect(factorial(10), 3628800));
    test('negative throws', () {
      expect(() => factorial(-1), throwsArgumentError);
    });
  });

  group('isPrime', () {
    test('2 is prime', () => expect(isPrime(2), true));
    test('4 is not prime', () => expect(isPrime(4), false));
    test('17 is prime', () => expect(isPrime(17), true));
  });
}
```

The bug is in `factorial` — it uses `+` instead of `*`. The tests will catch it.

---

## 2. Write the task

Create a task directory with a `task.yaml`:

```
evals/
└── tasks/
    └── fix_math_utils/
        └── task.yaml
```

```{code-block} yaml
---
caption: evals/tasks/fix_math_utils/task.yaml
---
# Task: Fix a buggy Dart package
#
# Uses the built-in `bug_fix` task function, which:
#   1. Copies the workspace into a sandbox
#   2. Gives the model bash and text-editor access
#   3. Lets it explore, edit, and test until it calls submit()
#   4. Scores based on test results and code quality

func: bug_fix

# Copy the workspace into /workspace in the sandbox
files:
  /workspace: ../../workspaces/buggy_dart_package
setup: "cd /workspace && dart pub get"

samples:
  inline:
    - id: fix_factorial
      metadata:
        difficulty: easy
        tags: [dart, math, bug-fix]
      input: |
        The `factorial` function in `lib/math_utils.dart` is returning
        wrong values. Tests are failing. Find and fix the bug.

        Run the tests with `dart test` to verify your fix.
      target: |
        The fix should change the `+` operator to `*` in the factorial
        function's recursive case. All tests should pass after the fix.
```

**What's new here compared to Part 1:**

| Field | What it does |
|-------|-------------|
| `func: bug_fix` | An *agentic* task. The model gets `bash_session()` and `text_editor()` tools and runs in a `react()` loop — it can explore, edit, and test code autonomously. |
| `files` | Copies a local directory into the sandbox filesystem. The key (`/workspace`) is the destination path inside the sandbox. |
| `setup` | A shell command run *before* the model gets control. Use it to install dependencies. |

> [!IMPORTANT]
> The `bug_fix` task requires a container sandbox (Docker or Podman) because
> `bash_session()` and `text_editor()` inject helper scripts that only work on
> Linux. We'll configure this in the job file.

---

## 3. Create a job

```{code-block} yaml
---
caption: evals/jobs/tutorial_bugfix.yaml
---
# Job: tutorial bug fix
#
# Runs our fix_math_utils task in a Podman sandbox.

models:
  - google/gemini-2.5-flash

sandbox: podman

tasks:
  inline:
    fix_math_utils: {}
```

If you don't have Podman set up yet:

```bash
brew install podman
podman machine init
podman machine start
```

> [!TIP]
> If you'd rather use Docker, change `sandbox: podman` to `sandbox: docker`.
> The task functions work identically with either runtime.

---

## 4. Run it

Dry run first to check your config:

```bash
devals run tutorial_bugfix --dry-run
```

Then run for real:

```bash
devals run tutorial_bugfix
```

The `bug_fix` task uses a ReAct agent loop. You'll see the model:

1. Explore the project structure (`ls`, `cat`)
2. Read the failing test output (`dart test`)
3. Edit `math_utils.dart` to fix the bug
4. Re-run tests to verify the fix
5. Call `submit()` with an explanation

A typical run takes 1–3 minutes.

---

## 5. View results

```bash
devals view
```

In the Inspect log viewer, open the run and look at:

- **Transcript** — the full conversation, including every tool call the model made
- **Score** — whether the fix passed `dart analyze` and `dart test`
- **Metadata** — timing, token usage, and tool call counts

---

## 6. Add a variant

What if we gave the model some context about Dart best practices? Would it
produce a better fix, or fix it faster? **Variants** let you test this.

First, create a context file:

```{code-block} markdown
---
caption: evals/context_files/dart_best_practices.md
---
---
title: "Dart Best Practices"
version: "1.0.0"
description: "Common Dart patterns and debugging tips"
---

## Debugging Tips

- Always run `dart test` after making changes to verify your fix.
- Use `dart analyze` to catch static errors.
- Read test expectations carefully — they tell you what the correct behavior should be.
- Check operator precedence when arithmetic results look wrong.
```

Now update your job to define two variants:

```{code-block} yaml
---
caption: evals/jobs/tutorial_bugfix.yaml (updated)
---
models:
  - google/gemini-2.5-flash

sandbox: podman

# Test with and without context
variants:
  baseline: {}
  with_context:
    files: [./context_files/dart_best_practices.md]

tasks:
  inline:
    fix_math_utils: {}
```

Run again:

```bash
devals run tutorial_bugfix
```

This time, the framework runs *two* evaluations:

- `fix_math_utils` × `baseline` — no extra context
- `fix_math_utils` × `with_context` — the context file is injected into the prompt

In `devals view`, you can compare the two runs side by side. Did the context
help? Did the model find the bug faster?

---

## Recap

You've now written an agentic eval from scratch. Here's what you learned:

| Concept | What it means |
|---------|---------------|
| **Workspace** | A project directory copied into the sandbox for the model to work with |
| **`files` + `setup`** | How to get code into the sandbox and prepare it |
| **`bug_fix` (agentic task)** | A task where the model gets tools and runs in a ReAct loop |
| **Variants** | Different configurations for the *same* task — great for A/B testing |

---

## Next steps

Now that you've written tasks and jobs by hand, {doc}`Part 3 <configuring_jobs>`
dives deeper into the configuration model — every field in `task.yaml` and
`job.yaml`, and how they all fit together.
