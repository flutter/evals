# Get started

A guide to using evals as a framework for the local development of your own evals.

## Prerequisites

| Tool | Version | Purpose |
|------|---------|---------| 
| [Dart SDK](https://dart.dev/get-dart) | 3.10+ | Runs the `devals` CLI |
| [Python](https://www.python.org/) | 3.13+ | Runs the `dash_evals` runner |

You'll also need an API key for at least one model provider (`GOOGLE_API_KEY`, `ANTHROPIC_API_KEY`, or `OPENAI_API_KEY`).

## 1. Install the packages

```bash
git clone https://github.com/flutter/evals.git
pip install -e <path-to-evals>/packages/dash_evals
dart pub global activate devals --source path <path-to-evals>/packages/devals_cli


## TODO: Integrate in the new repo. This is wrong for this repo
python3 -m venv .venv
source .venv/bin/activate
pip install -e "packages/dash_evals[dev]"
pip install -e "packages/dataset_config_python[dev]"
```

This installs two things:

- **`devals`** (Dart) — the CLI you'll use for every command. It resolves YAML configuration into a JSON manifest and delegates execution.
- **`dash_evals`** (Python) — the runtime that receives the manifest and drives [Inspect AI](https://inspect.aisi.org.uk/)'s `eval_set()` to actually run evaluations.

## 2. Check your environment

```bash
devals doctor
```

This runs a series of prerequisite checks — Dart SDK, Python version, whether `dash_evals` is installed, API keys, and optional tools like Podman and Flutter. Fix any errors it reports before continuing; warnings are safe to ignore for now.

## 3. Set up Podman (optional)

If your evals use containerized execution (`sandbox_type: podman` in a job YAML), you need Podman installed and a container image built. You can skip this step for basic evals that run locally.

**Install Podman** (macOS):

```bash
brew install podman
podman machine init
podman machine start
```

**Build the Flutter sandbox image:**

```bash
cd <path-to-evals>/examples/evals-dataset/evals/sandboxes/podman
podman build -t flutter-sandbox:latest .
```

This builds `localhost/flutter-sandbox:latest`, which includes Ubuntu 24.04 and the Flutter SDK. The build takes a few minutes.

> **Tip:** To target a different Flutter channel, pass `--build-arg FLUTTER_CHANNEL=beta` (or `main`).

## 4. Configure API keys

Make sure you have at least one model provider API key set as an environment variable. You can set them in your shell profile or in a `.env` file in your project root.

```bash
export GEMINI_API_KEY=your_key_here
```

## 5. Initialize your dataset

Run `devals init` from the root of the project you want to evaluate. This is typically a Dart or Flutter project — the scaffolded starter task will point back at your project as its workspace.

```bash
cd ~/my-flutter-app
devals init
```

This creates two things:

- **`devals.yaml`** in your project root — a marker file that tells the CLI where your eval dataset lives (defaults to `./evals`).
- **`evals/`** directory with the following structure:

```
my-flutter-app/
├── devals.yaml                          # ← marker file
└── evals/
    ├── tasks/
    │   └── get_started/
    │       └── task.yaml                # starter task + sample
    └── jobs/
        └── local_dev.yaml               # job ready to run
```

The starter task uses the `analyze_codebase` task function, which asks the model to
explore your project and suggest an improvement. It's a good smoke-test that
doesn't require a sandbox or any extra setup.


## 6. Run your first eval

```bash
devals run local_dev
```

Behind the scenes, this:

1. Resolves your YAML config (job + tasks + samples) into an EvalSet JSON manifest
2. Passes the manifest to the Python `dash_evals` runner
3. `dash_evals` calls Inspect AI's `eval_set()`, which sends prompts, collects responses, and scores results
4. Logs are written to a `logs/` directory (a sibling of `evals/`)

To preview the resolved configuration without actually making API calls:

```bash
devals run local_dev --dry-run
```

This prints every task × model × variant combination that would execute, so you can verify your setup before spending API credits.

## 7. View results

```bash
devals view
```

This launches the [Inspect AI log viewer](https://inspect.aisi.org.uk/log-viewer.html) — a local web UI where you can browse runs, inspect individual samples, view scores, and read full conversation transcripts. It automatically finds your `logs/` directory based on `devals.yaml`.

---

## Next steps

- **Add more samples** — `devals create sample`
- **Add tasks** — `devals create task`
- **Create targeted jobs** — `devals create job`
- **Interactive walkthrough** — `devals create pipeline` guides you through creating a sample, task, and job in one go
- **[Follow the tutorial](tutorial.md)** — a hands-on walkthrough of authoring a code-generation task from scratch
