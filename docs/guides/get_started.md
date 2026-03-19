# Install and run evals

By the end of this page you'll have installed everything,
run an evaluation with Python and Inspect AI, and (optionally) seen how the
`devals` CLI wraps all of that into a single workflow.

## Prerequisites

| Tool | Details | Notes |
|------|---------|---------|
| [Dart SDK*](https://dart.dev/get-dart) | Ver. 3.10+ | Runs the `devals` CLI |
| [Python](https://www.python.org/) | Ver. 3.13+ | Runs the `dash_evals` evaluation runner |
| API keys | `GEMINI_API_KEY`, `ANTHROPIC_API_KEY`, or `OPENAI_API_KEY` | Requires at least one model provider key. |

\*Dart isn't required. It powers the CLI, which assists in authoring various YAML files
and hides some complexity of the framework. However, the framework is entirely useable 
without the CLI. 

---

## 1. Set up your project

Create a directory for your evals work and set up a Python virtual environment:

```bash
mkdir my-evals && cd my-evals
python3 -m venv .venv
source .venv/bin/activate
```

### Install `dash_evals` (Python — required)

Install the evaluation runner and its config library from git:

```bash
pip install "dash-evals @ git+https://github.com/flutter/evals.git#subdirectory=packages/dash_evals"
pip install "dataset-config-python @ git+https://github.com/flutter/evals.git#subdirectory=packages/dataset_config_python"
```

This gives you **`dash_evals`** — the runtime that drives
[Inspect AI](https://inspect.aisi.org.uk/) to run evaluations. Its CLI entry
point is `run-evals`.

### Install `devals` CLI (Dart — optional)

If you have the Dart SDK installed, you can also install the CLI, which automates some of the configuration and eval authoring.

```bash
dart pub global activate devals --source git https://github.com/flutter/evals.git --git-path packages/devals_cli
```

**`devals`** resolves YAML configuration, scaffolds new tasks and jobs, and
wraps `run-evals` and `inspect view` into a single workflow. It reduces the
learning curve but is entirely optional — everything it does can be done with
vanilla Python and Inspect AI commands.

## 2. Configure an API key

```bash
export GEMINI_API_KEY=your_key_here
```

Set at least one provider key. You can also add it to a `.env` file in your
project directory — `dash_evals` loads it automatically.

---

## 3. Create a minimal dataset

The basic unit of evals is the [*sample*](). A sample is a single 'test case', which includes, at a minimum, an prompt (called 'input') and a target, which is used to grade the evaluation.

Create a file called `my_first_sample.json` in your project directory:

```{code-block} json
---
caption: my-evals/my_first_sample.json
---
[
  {
    "input": "Explain the difference between `Future.then()` and `async/await` in Dart. When should you prefer one over the other?",
    "target": "The answer should explain that both are mechanisms for handling asynchronous code; async/await is syntactic sugar over Futures. It should note that async/await is generally preferred for readability, while .then() can be useful for simple one-off transformations."
  }
]
```

### 3.2 Run it

```bash
run-evals \
  --task question_answer \
  --model google/gemini-2.5-flash \
  --dataset ./my_first_sample.json
```

This runs that one sample. Here's what just happened:

1. `run-evals` loaded the `question_answer` [*task*]() function from `dash_evals`. A task
  is a Python function that desribes the logic required to run a sample. Tasks are the generic,
  reusable logic that know how to run your bespoke samples. Some other task examples are
  [`generate_code`][] and [`bug_fix`][].
2. Your dataset, or collection of samples, was passed to the task, which executes its *solver chain*, the 
    instructions given to the agent being evaluated.
3. Inspect AI drives the agent, collects the response, and scores it with a *scorer*. Scorers vary by task. 
  In this case, the scorer is [`model_graded_fact`][], a scorer provided by Inspect that asks a second agent
  to compare the generated response to our target response.
4. Finally, A log file was written to `./logs/`

### 3.3 View the results

Inspect AI ships with a robust log viewer. Launch it:

```bash
inspect view
```

This opens a local web UI where you can browse the run, see the full
conversation transcript, and check how the response was scored.

> [!TIP]
> `inspect view` finds logs in the current directory by default. Pass a path
> to point it elsewhere: `inspect view ./path/to/logs`.

---

## 4. That's what `devals` wraps

The commands above — `run-evals`, `inspect view` — are the raw building blocks.
The **`devals` CLI** wraps all of them, helps manage your runtime environment, 
and manages the YAML configuration layer we've put on top of Inspect AI, 
which replaces the Samples JSON and *many* configuration
options that are otherwise be passed in as CLI flags. All of the quality-of-life 
improvements provided by the CLI are described in the [Using the CLI guide][].

Importantly, you can still use the Yaml configuration layer without Dart and the CLI, 
it's just less automated and requires you writing a bit of python glue code.

Let's try the `devals` workflow now.

As a reminder, the install script is:

```bash
dart pub global activate devals --source git https://github.com/flutter/evals.git --git-path packages/devals_cli
```

### 4.1 Check your environment

```bash
devals doctor
```

This verifies Dart, Python, `dash_evals`, API keys, and optional tools like
Podman and Flutter. Fix any errors it reports; warnings are safe to ignore for now.

### 4.2 Initialize a dataset

Run `devals init` from your project directory (the `my-evals` directory you
created in step 1):

```bash
devals init
```

This creates:

```
my-evals/
├── devals.yaml                        # marker file
└── evals/
    ├── tasks/
    │   └── get_started/
    │       └── task.yaml              # starter task + sample
    └── jobs/
        └── local_dev.yaml             # ready-to-run job
```

The starter task uses the `analyze_codebase` task function — it asks the model
to explore your project and suggest an improvement. It's a good smoke test that
doesn't require a sandbox.

### 4.3 Run the eval

```bash
devals run local_dev
```

Behind the scenes, this:

1. Resolves your YAML config (job + tasks + samples) into a JSON manifest
2. Passes the manifest to `run-evals` (the Python `dash_evals` runner)
3. `dash_evals` calls Inspect AI's `eval_set()`, which sends prompts, scores results,
   and writes logs

To preview the resolved config without making API calls:

```bash
devals run local_dev --dry-run
```

### 4.4 View results

```bash
devals view
```

This is the same Inspect AI log viewer from before, but `devals` automatically
finds your `logs/` directory based on `devals.yaml`.

---

## Recap

You've now seen the two layers of the system:

| Layer | What it does |
|-------|-------------|
| **`dash_evals` + Inspect AI** | The engine. Runs tasks, sends prompts, scores responses. |
| **`devals` CLI** | The convenience layer. YAML config, scaffolding, log discovery. |


---

## Next steps

You're set up and you've seen the framework in action. In
{doc}`Part 2 <write_your_first_eval>`, you'll author a more complex, agentic
evaluation from scratch.
