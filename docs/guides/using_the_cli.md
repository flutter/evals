# Use the CLI

You've written tasks and jobs by hand. The `devals` CLI can generate most of
that configuration for you — this page shows how, and what you'll want to
customize afterward.

---

## Scaffolding commands

### `devals init`

Initializes a fresh project for evals:

```bash
cd ~/my-project
devals init
```

**What it creates:**

```
my-project/
├── devals.yaml                        # marker file
└── evals/
    ├── tasks/
    │   └── get_started/
    │       └── task.yaml              # starter task
    └── jobs/
        └── local_dev.yaml             # ready-to-run job
```

**What to customize:**

- The starter task uses `func: analyze_codebase` — fine for a smoke test, but
  you'll want to change `func` to match your eval type (`question_answer`,
  `bug_fix`, `code_gen`, etc.)
- The job defaults to `google/gemini-2.0-flash`. Update `models:` to the
  provider(s) you want to test.
- `files` points at `../../` (your project root). Update if your workspace
  lives elsewhere.

### `devals create pipeline`

An interactive walkthrough that creates a sample, task, and job in one go.
Great for first-timers:

```bash
devals create pipeline
```

It prompts you for:
1. A sample ID and prompt
2. Which task function to use
3. A job name and model selection

The result is a fully wired-up set of YAML files ready to `devals run`.

### `devals create task`

Creates a new task directory with a starter `task.yaml`:

```bash
devals create task
```

**Prompts for:**
- Task ID (becomes the directory name under `tasks/`)
- Task function (selected from the Python registry)
- Optional system message

**What to customize after:**
- Add your `samples` — the generated file is a skeleton
- Add `files` and `setup` if your task needs a workspace
- Add `metadata` with tags for filtering

### `devals create sample`

Adds a new sample interactively:

```bash
devals create sample
```

**Prompts for:**
- Sample ID (snake_case)
- Difficulty level
- Whether a workspace is needed

**What to customize after:**
- Write a specific `input` prompt — the generated placeholder is generic
- Write grading criteria in `target`
- Add `metadata.tags` for filtering

### `devals create job`

Creates a new job YAML file:

```bash
devals create job
```

**Prompts for:**
- Job name
- Which models, variants, and tasks to include

**What to customize after:**
- Add or refine `variants` — the generated file may only include `baseline: {}`
- Add `task_filters` or `sample_filters` if you want to target a subset
- Configure `inspect_eval_arguments` for retry, timeout, and limit settings

---

## Running evals

### Basic run

```bash
devals run <job_name>
```

The CLI:
1. Reads `devals.yaml` to find the `evals/` directory
2. Resolves your YAML config into a JSON manifest
3. Passes the manifest to `run-evals` (the Python `dash_evals` runner)
4. `dash_evals` calls Inspect AI's `eval_set()`
5. Logs are written to `logs/`

### Dry run

Preview the resolved configuration without making API calls:

```bash
devals run <job_name> --dry-run
```

This prints every task × model × variant combination that would execute.
Use it to verify your setup before spending API credits.

> [!TIP]
> Always dry-run after editing YAML config. It catches typos, missing files,
> and bad task references before they cost you money.

---

## Viewing results

```bash
devals view
```

Launches the [Inspect AI log viewer](https://inspect.aisi.org.uk/log-viewer.html)
— a local web UI. `devals` automatically finds your `logs/` directory from
`devals.yaml`.

To view logs from a specific location:

```bash
devals view /path/to/logs
```

**What to look for in the viewer:**

| Section | What it shows |
|---------|--------------|
| **Runs** | Each task × model × variant combination |
| **Transcript** | The full conversation, including every tool call |
| **Score** | Pass/fail, model-graded scores, test results |
| **Metadata** | Timing, token usage, cost |

---

## Troubleshooting

### `devals doctor`

Checks all prerequisites:

```bash
devals doctor
```

It verifies:
- **Dart SDK** — required for the CLI itself
- **Python 3.13+** — required for `dash_evals`
- **`dash_evals`** — the Python evaluation package
- **Podman/Docker** — container runtime for sandboxed tasks
- **Flutter SDK** — needed for Flutter-based eval tasks
- **API Keys** — checks for configured provider keys

Fix any errors before running evals. Warnings (like a missing Flutter SDK)
are safe to ignore if your evals don't need that tool.

---

## Quick reference

| Command | What it does |
|---------|-------------|
| `devals init` | Initialize a new dataset in the current directory |
| `devals doctor` | Check prerequisites |
| `devals create pipeline` | Interactive walkthrough: sample → task → job |
| `devals create task` | Create a new task directory |
| `devals create sample` | Create a new sample |
| `devals create job` | Create a new job file |
| `devals run <job>` | Run an evaluation |
| `devals run <job> --dry-run` | Preview without executing |
| `devals view [path]` | Launch the Inspect AI log viewer |

---

## Next steps

You now know the full CLI workflow. {doc}`Part 5 <about_the_framework>` looks
under the hood at the `dash_evals` Python package — useful if you ever want
to write custom task logic.