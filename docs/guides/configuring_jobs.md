# Configure jobs

In {doc}`Part 1 <get_started>` and {doc}`Part 2 <write_your_first_eval>` you
wrote tasks and jobs by following a recipe. Now let's understand the full
configuration model so you can build your own from scratch.

This page walks through every piece of the YAML configuration — building
each file up incrementally.

---

## The three config files

Everything lives under your `evals/` directory:

| File | Purpose |
|------|---------|
| `tasks/<id>/task.yaml` | Defines **what** to evaluate — the task function, samples, workspace, prompt |
| `jobs/<name>.yaml` | Defines **how** to run it — models, variants, filters, sandbox, limits |
| Context files (optional) | Markdown files injected into the model's prompt via variants |

The `devals` CLI resolves these into a single JSON manifest and hands it to the
Python runner. Most of the time, you're just editing YAML.

---

## Building a task.yaml

Let's build a task file from scratch, adding one concept at a time.

### Start minimal

The only required field is the task function:

```yaml
func: question_answer
```

This is enough to define a task, but it has no samples — nothing to evaluate yet.

### Add a sample

Samples go under `samples.inline`. Each sample needs at minimum an `id`,
`input` (the prompt), and `target` (grading criteria):

```yaml
func: question_answer

samples:
  inline:
    - id: explain_null_safety
      input: |
        Explain Dart's sound null safety. How does it prevent
        null reference errors at compile time?
      target: |
        Should explain nullable vs non-nullable types, the `?`
        suffix, null-aware operators, and how the analyzer enforces
        null checks at compile time.
```

### Add a system message

A `system_message` customizes the prompt sent to the model before your sample input:

```yaml
func: question_answer
system_message: |
  You are an expert Dart developer. Answer questions with code
  examples where appropriate. Be concise.

samples:
  inline:
    - id: explain_null_safety
      # ...
```

### Add files and setup

For agentic tasks that run code in a sandbox, use `files` and `setup`:

```yaml
func: bug_fix

# Copy a project into the sandbox — key = destination, value = source
files:
  /workspace: ../../workspaces/my_dart_package
setup: "cd /workspace && dart pub get"

samples:
  inline:
    - id: fix_the_bug
      input: |
        The tests are failing. Find and fix the bug.
      target: |
        All tests should pass after the fix.
```

`files` and `setup` at the task level are **inherited by all samples**. A sample
can override them:

```yaml
samples:
  inline:
    - id: fix_the_bug
      files:
        /workspace: ./custom_project    # overrides task-level files
      setup: "cd /workspace && pub get"  # overrides task-level setup
      input: ...
```

> [!NOTE]
> File paths in `files` values are resolved **relative to the task directory**.
> Task-level `files` stack with sample-level `files` — on a key conflict, the
> sample wins.

### Add metadata for filtering

Samples can carry `metadata` with `tags` and `difficulty`. Jobs use these for filtering:

```yaml
samples:
  inline:
    - id: fix_the_bug
      metadata:
        difficulty: medium
        tags: [dart, bug-fix, async]
      input: ...
      target: ...
```

### Use external sample files

For large datasets, you can keep samples in separate files and reference them
with glob patterns:

```yaml
func: question_answer

samples:
  paths:
    - samples/*.yaml    # loads every .yaml in the samples/ subdirectory
```

Each external file contains a list of sample objects in the same format as
`samples.inline`.

---

## Building a job.yaml

Jobs control **how** tasks run. Let's build one up.

### Start with models and tasks

The bare minimum — which models and which tasks:

```yaml
models:
  - google/gemini-2.5-flash

tasks:
  inline:
    explain_null_safety: {}   # run all samples with default settings
```

### Add variants

Variants let you test the same task under different conditions. Each variant is a named
map — an empty map `{}` means "no extras" (the baseline):

```yaml
models:
  - google/gemini-2.5-flash

variants:
  baseline: {}
  context_only:
    files: [./context_files/dart_docs.md]
  mcp_only:
    mcp_servers:
      - name: dart
        command: dart
        args: [mcp-server]
  full:
    files: [./context_files/dart_docs.md]
    mcp_servers:
      - name: dart
        command: dart
        args: [mcp-server]

tasks:
  inline:
    explain_null_safety: {}
```

This produces 4 runs per sample (one per variant) × however many models you list.

**Variant sub-fields:**

| Field | What it does |
|-------|-------------|
| `files` | Context files injected into the prompt |
| `mcp_servers` | MCP tool servers the model can call (stdio, HTTP, or Python ref) |
| `skills` | Skill directories copied into the sandbox |
| `task_parameters` | Extra parameters merged into the task config at runtime |

### Filter tasks and samples

Use `task_filters` and `sample_filters` to select subsets by tag:

```yaml
task_filters:
  include_tags: [dart]          # only tasks tagged "dart"
  exclude_tags: [deprecated]    # skip deprecated tasks

sample_filters:
  include_tags: [bug-fix]       # only samples tagged "bug-fix"
```

- **`include_tags`** — an item must have *all* listed tags to be included
- **`exclude_tags`** — an item is excluded if it has *any* listed tag

You can also filter per-task using `include-samples` and `exclude-samples`:

```yaml
tasks:
  inline:
    fix_math_utils:
      include-samples: [fix_factorial]   # only run this sample
      include-variants: [baseline]       # only run this variant
```

### Add sandbox configuration

For tasks that need container execution:

```yaml
sandbox: podman    # or "docker"
```

You can also pass additional sandbox parameters:

```yaml
sandbox:
  environment: podman
  image_prefix: us-central1-docker.pkg.dev/my-project/repo/
```

### Add Inspect AI parameters

The `inspect_eval_arguments` section passes settings through to Inspect AI's
`eval_set()`:

```yaml
inspect_eval_arguments:
  retry_attempts: 20
  fail_on_error: 0.05
  log_level: info

  # Defaults applied to every task in this job
  task_defaults:
    time_limit: 600
    message_limit: 50
```

---

## Putting it all together

Here's a complete job file using everything above:

```{code-block} yaml
---
caption: evals/jobs/full_example.yaml
---
models:
  - google/gemini-2.5-flash
  - anthropic/claude-sonnet-4-20250514

sandbox: podman
max_connections: 15

variants:
  baseline: {}
  context_only:
    files: [./context_files/dart_docs.md]
  with_mcp:
    mcp_servers:
      - name: dart
        command: dart
        args: [mcp-server]

task_filters:
  include_tags: [dart]

tasks:
  inline:
    fix_math_utils:
      exclude-variants: [with_mcp]   # MCP not relevant for this task
    dart_question_answer: {}

inspect_eval_arguments:
  retry_attempts: 10
  task_defaults:
    time_limit: 300
    message_limit: 30
```

This will run:

- 2 models × 2 applicable variants × all matching samples in `fix_math_utils`
- 2 models × 3 variants × all matching samples in `dart_question_answer`

---

## Summary

| Concept | Where it lives | What it controls |
|---------|---------------|-----------------|
| **Task** | `tasks/<id>/task.yaml` | What to evaluate: function, prompt, workspace, samples |
| **Job** | `jobs/<name>.yaml` | How to run: models, variants, filters, sandbox, limits |
| **Variant** | Inside job YAML | Different configurations for the agent being evaluated |
| **Sample** | Inside task YAML (or external files) | Individual test cases with input/target pairs |
| **Context file** | Referenced by variants | Extra information injected into the model's prompt |

For the complete field-by-field reference, see {doc}`/reference/yaml_config`.

---

## Next steps

Now that you understand the configuration model, {doc}`Part 4 <using_the_cli>`
shows how the `devals` CLI can **generate** most of this config for you — and
what you need to customize in the output.
