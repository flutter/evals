# Glossary

Key terminology for understanding the evals framework.

## Core Concepts

| Term | Definition |
|------|------------|
| **Model** | The LLM being evaluated (e.g., `google/gemini-2.5-pro`, `anthropic/claude-3-5-haiku`) |
| **Task** | An Inspect AI evaluation function that processes samples (e.g., `question_answer`, `bug_fix`, `code_gen`) |
| **Sample** | A single test case containing an input prompt and expected output (grading criteria) |
| **Variant** | Named configuration that modifies how a task runs — controls context injection, MCP tools, and skill availability |
| **Eval Run** | A complete execution of a task against one or more models, producing results for all samples |

## Configuration Files

| Term | Definition |
|------|------------|
| **task.yaml** | Task definition file specifying the task function, samples, and optional variant restrictions |
| **job.yaml** | Runtime configuration defining *what* to run — filters tasks, variants, and models for a specific run |
| **EvalSet JSON** | Resolved configuration produced by the Dart `dataset_config_dart` package and consumed by the Python runner |

## Resources

| Term | Definition |
|------|------------|
| **Context File** | Markdown file with YAML frontmatter providing additional context injected into prompts |
| **Workspace Template** | Reusable project scaffolds (Flutter app, Dart package) mounted in the sandbox |
| **Sandbox** | Containerized environment (Podman/Docker) for safe code execution during evaluations |
| **MCP Server** | Model Context Protocol server providing tools/context to the model during evaluation |

## Scoring

| Term | Definition |
|------|------------|
| **Scorer** | Logic that determines if a model's output is correct (e.g., model-graded semantic match) |
| **Accuracy** | Percentage of samples scored as correct in an eval run |

## Key Packages

| Package | Definition |
|---------|------------|
| **dataset_config_dart** | Dart package that parses dataset YAML and resolves it into EvalSet JSON via a layered Parser → Resolver → Writer pipeline |
| **dash_evals** | Python package that consumes EvalSet JSON (or direct CLI arguments) and executes evaluations using Inspect AI |
| **devals_cli** | Dart CLI (`devals`) for creating and managing tasks, samples, and jobs |

## Internal Classes

### Dart (dataset_config_dart)

| Class | Definition |
|-------|------------|
| **EvalSet** | Top-level container representing a fully resolved evaluation configuration, serialized to JSON for the runner |
| **Task** | Inspect domain task definition with a name, task function reference, dataset, and configuration |
| **Sample** | An input/target test case with optional metadata, workspace, and sandbox configuration |
| **Variant** | Named variant configuration with context files, MCP servers, and skills |
| **TaskInfo** | Lightweight task metadata (name and function reference) |
| **ParsedTask** | Intermediate representation produced by parsers, consumed by the resolver |
| **Job** | Parsed job file with runtime overrides and task/variant/model filters |
| **ConfigResolver** | Facade providing single-call convenience API for the full parse → resolve → write pipeline |

### Python (dash_evals)

| Class | Definition |
|-------|------------|
| **json_runner** | Module that reads EvalSet JSON, resolves task functions via `importlib`, builds `inspect_ai.Task` objects, and calls `eval_set()` |
| **args_runner** | Module that builds a single task from direct CLI arguments (`--task`, `--model`, `--dataset`) |

---

See the [Configuration Overview](./config/about.md) for detailed configuration file documentation.

[Learn more about Inspect AI](https://inspect.aisi.org.uk/)
