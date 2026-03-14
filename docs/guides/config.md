# Config guide

Evals uses a layered YAML configuration system. You define **what** to evaluate (tasks and samples), **how** to run it (jobs), and **where** code executes (sandboxes). The CLI resolves these files into a single manifest and hands it to the Python runner — so most of the time you're just editing YAML.

This page walks through the main concepts and how they connect.

## **Dataset**

The Dataset is the collection of Tasks and Samples that are run through the python tool. A
Sample is, at a minimum, an input and target. These are essentially test cases.

In evals, the definition of dataset is expanded to include all fixtures of running evals, and all of these definitions exist in the dataset directory of the github.

| 🗒️ Note!  The following diagrams provide a mental model. (They also provide a literal representation of how it works, but…) A lot of this is hidden from you, the user or sample author, so don’t let it overwhelm! |
| :---- |

![A](/_static/images/evals-dataset.png)

* **Samples** - individual eval case
* **Models** we run against
* **Variants** - Different configurations for the agent being evaluated, e.g. with Dart MCP, with or without skills, with and without rules files, and every combination of those things.
* **Tasks** - A task is a Python function entrypoint for one “type” of evals. For example, “question_answer”, “code_gen”, “mcp_create_project” are a few of the tasks we support. Each task generally takes a list of specific samples that are configured to run for that task.
* **Workspaces** (The codebase that the agent is tinkering with in an eval)
* **Sandbox definitions** (host machine, podman, docker)
* **Default runtime configurations**

### **Tasks are the basic unit of defining eval runs.**

![A](/_static/images/task.png)

### **Job files are run configuration**

![A](/_static/images/job.png)

### **Then evals run based on that job file:**

![A](/_static/images/eval-set.png)

This means you care about job files and task files. Job files might look like this:

- job/main.yaml (runs the whole thing)
- job/ci.yaml (a job that is run as part of ci)
- job/local_dev.yaml (a job that is .gitignored, used for quick iteration)

## Tag-based filtering

Jobs can filter which tasks and samples run using tags. Tasks and samples define tags in their `metadata`, and jobs reference them via `task_filters` and `sample_filters`:

```yaml
# job.yaml
task_filters:
  include_tags: [code_gen]      # only tasks tagged "code_gen"
  exclude_tags: [deprecated]    # skip deprecated tasks
sample_filters:
  include_tags: [flutter]       # only samples tagged "flutter"
```

- **`include_tags`** — an item must have *all* listed tags to be included
- **`exclude_tags`** — an item is excluded if it has *any* listed tag

Tag filters work alongside ID-based filtering (`tasks.<id>.include-samples` / `exclude-samples`).

## Task function references

The `func` field in task YAML identifies the Python `@task` function to run. Three formats are supported:

| Format | Example | Resolution |
|---|---|---|
| Short name | `question_answer` | Looks up `dash_evals.runner.tasks.question_answer` |
| Colon syntax | `my_package.tasks:my_task` | Imports `my_package.tasks`, gets `my_task` |
| Dotted path | `my_package.tasks.my_task.my_task` | Last segment is the function name |

## Sandbox configuration

The sandbox registry is **configurable** — the resolver accepts a registry mapping names to compose files. The default registry is empty; the `devals_cli` passes the Flutter-specific registry:

```yaml
# job.yaml
sandbox_type: podman          # looks up "podman" in the registry
image_prefix: us-central1-docker.pkg.dev/my-project/repo/
```

The `image_prefix` is prepended to image names during sandbox resolution (useful for private registries).

## Workspace setup

When `workspace` is specified on a sample and the sandbox is a container (`docker` or `podman`), the resolver maps it to `Sample.files['/workspace']`. The setup command (e.g. `cd /workspace && flutter pub get`) is **not** auto-generated — specify it explicitly in your sample or task YAML via the `setup` field.

For the full field reference, see {doc}`/reference/yaml_config`.
