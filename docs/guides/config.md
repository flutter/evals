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
- job/ci.yaml (a job that runs as part of ci)
- job/local_dev.yaml (a job that is .gitignored, used for quick iteration)
