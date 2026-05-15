# Sandboxing, Files & Workspaces Reference

Complete reference for Inspect AI sandbox environments, file provisioning, and workspace
configuration. Source: https://inspect.aisi.org.uk/sandboxing.html

---

## When to Use Sandboxes

Use sandboxing when your eval needs to:
- Execute arbitrary code (bash, Python) safely
- Provision per-sample filesystem resources (files the agent reads/writes)
- Set up complex networked environments (e.g. attacker/victim hosts for cybersecurity evals)

---

## Available Sandbox Types

| Type | Package | Dockerfile-compatible | Notes |
|---|---|---|---|
| `docker` | Built-in | Yes | Local Docker installation |
| `local` | Built-in | No | No isolation — runs in host process |
| `k8s` | `inspect-k8s-sandbox` | Yes | Kubernetes cluster |
| `daytona` | `inspect-sandboxes` | Yes | Daytona cloud sandbox |
| `modal` | `inspect-sandboxes` | Yes | Modal cloud sandbox |
| `ec2` | `inspect_ec2_sandbox` | No | AWS EC2 VMs |
| `proxmox` | `inspect_proxmox_sandbox` | No | Proxmox VMs |

Docker requires Docker Engine ≥ 24.0.7 installed.

---

## Specifying a Sandbox

Sandbox can be set at three levels (higher overrides lower, except per-sample config files
always take precedence when the sandbox type matches):

```python
# 1. Task level (most common)
Task(..., sandbox="docker")

# 2. Task level with explicit compose file
Task(..., sandbox=("docker", "attacker-compose.yaml"))

# 3. eval() level (overrides task)
eval(my_task(), sandbox="docker")

# 4. Per-sample (see Per-Sample Setup section below)
Sample(..., sandbox="docker")
```

---

## Quickstart: Minimal Docker Sandbox

Place a `compose.yaml` next to your eval `.py` file:

```yaml
# compose.yaml
services:
  default:
    image: python:3.12-bookworm
    init: true
    command: tail -f /dev/null
```

Then in your task:

```python
Task(
    dataset=dataset,
    solver=[use_tools([bash()]), generate()],
    scorer=match(),
    sandbox="docker",
)
```

- `init: true` enables the container to respond to shutdown requests.
- `command: tail -f /dev/null` keeps the container alive after startup.

If no `compose.yaml` is present, Inspect auto-generates one using the
`aisiuk/inspect-tool-support` image, **with internet access disabled by default**.

---

## Auto-Discovery of Config Files

| Files in task dir | Behaviour |
|---|---|
| Neither `Dockerfile` nor `compose.yaml` | Uses `aisiuk/inspect-tool-support` (no internet) |
| `Dockerfile` only | Builds that image |
| `compose.yaml` | Uses compose file |

---

## Common compose.yaml Patterns

### Basic resource-limited container

```yaml
services:
  default:
    build: .
    init: true
    command: tail -f /dev/null
    cpus: 1.0
    mem_limit: 0.5gb
    network_mode: none   # isolate from network
```

### Pre-built local image

```yaml
services:
  default:
    image: ctf-agent-environment
    x-local: true        # skip remote pull
    init: true
    command: tail -f /dev/null
```

If the image is tagged (e.g. `ctf-agent-environment:1.0.0`), `x-local: true` is not
required — tagged images are never pulled by default.

### Remote registry image

```yaml
services:
  default:
    image: python:3.12-bookworm
    init: true
    command: tail -f /dev/null
```

### Multiple sandboxes (attacker/victim pattern)

```yaml
services:
  default:
    image: ctf-agent-environment
    x-local: true
    init: true
    cpus: 1.0
    mem_limit: 0.5gb
  victim:
    image: ctf-victim-environment
    x-local: true
    init: true
    cpus: 1.0
    mem_limit: 1gb
```

Access named sandboxes in tools:

```python
from inspect_ai.util import sandbox

sandbox()           # default sandbox (named "default", or x-default: true, or first listed)
sandbox("victim")   # named sandbox
```

### Shared volumes between containers

```yaml
services:
  default:
    image: ctf-agent-environment
    x-local: true
    init: true
    volumes:
      - ctf-challenge-volume:/shared-data
  writer:
    image: ctf-challenge-writer
    x-local: true
    init: true
    volumes:
      - ctf-challenge-volume:/shared-data
volumes:
  ctf-challenge-volume:
```

---

## Programmatic (Dynamic) Compose Configuration

Use `ComposeConfig` when you need to vary container settings per-task or per-sample:

```python
from inspect_ai.util import ComposeConfig, ComposeService, SandboxEnvironmentSpec

@task
def my_task(cpus: float = 1.0, memory: str = "512m"):
    config = ComposeConfig(
        services={
            "default": ComposeService(
                image="python:3.12-bookworm",
                init=True,
                command="tail -f /dev/null",
                mem_limit=memory,
                cpus=cpus,
                network_mode="none",
            )
        }
    )
    return Task(
        dataset=dataset,
        solver=[use_tools([bash()]), generate()],
        scorer=match(),
        sandbox=SandboxEnvironmentSpec("docker", config),
    )
```

`ComposeService` supports: `image`, `build`, `command`, `environment`, `volumes`,
`ports`, `mem_limit`, `cpus`, `network_mode`, `init`, and extension fields (`x-*`).

---

## Per-Sample Setup

`Sample` has three fields for sandbox configuration:

```python
from inspect_ai.dataset import Sample

Sample(
    input="Is there a file named 'flag.txt'?",
    target="Yes",

    # 1. Per-sample sandbox (optional — overrides task-level type/config)
    sandbox=("docker", "custom-compose.yaml"),

    # 2. Files to copy into the sandbox before the sample runs
    files={
        "flag.txt": "secret_value_here",           # inline text
        "data.csv": "path/to/local/data.csv",      # local file path
        "image.png": "data:image/png;base64,...",  # base64 data URI
        "s3file.txt": "s3://my-bucket/file.txt",   # remote resource
        "victim:secret.txt": "only_in_victim",     # target named sandbox
    },

    # 3. Setup bash script — runs after files are copied
    setup="apt-get install -y netcat-openbsd",     # inline script
    # OR:
    setup="setup.sh",                              # path to script file
)
```

### File value formats

| Value | Behaviour |
|---|---|
| Plain string | Written as file contents |
| File path (relative) | Read from path relative to dataset file |
| `data:<mime>;base64,...` | Decoded from base64 and written |
| `s3://...` or other remote URI | Fetched and written |

### File key formats

| Key | Written to |
|---|---|
| `"filename.txt"` | Default sandbox environment |
| `"victim:filename.txt"` | Sandbox named `victim` |

### Setup script

The `setup` bash script runs *after* all files are copied into the default sandbox.
Use it for environment-specific initialization (e.g. installing packages, seeding
a database, setting permissions). Same value formats apply (inline text, file path,
base64 data URI).

### Using Sample metadata in compose.yaml

```yaml
# compose.yaml
services:
  default:
    image: ctf-agent-environment
    x-local: true
    init: true
    cpus: 1.0
    mem_limit: ${SAMPLE_METADATA_MEMORY_LIMIT-0.5gb}
```

All `Sample.metadata` keys are available with a `SAMPLE_METADATA_` prefix. Always
provide a default value using the `-default` suffix so the file is valid when read
outside of a sample context (e.g. during image pre-pull).

---

## SandboxEnvironment API

Access the sandbox from tools, solvers, or scorers:

```python
from inspect_ai.util import sandbox, sandbox_with

# Get default sandbox
sb = sandbox()

# Get named sandbox
sb = sandbox("victim")

# Get sandbox that has a specific file (useful in multi-sandbox setups)
sb = await sandbox_with("flag.txt")
```

### Full method reference

```python
class SandboxEnvironment:

    # Execute a shell command
    async def exec(
        self,
        cmd: list[str],
        input: str | bytes | None = None,   # stdin
        cwd: str | None = None,             # working directory
        env: dict[str, str] = {},           # environment variables
        user: str | None = None,            # run as user
        timeout: int | None = None,         # seconds before TimeoutError
        timeout_retry: bool = True,         # retry on timeout (advisory)
        concurrency: bool = True,           # allow concurrent exec calls
    ) -> ExecResult[str]:
        ...

    # Execute a long-running or streaming remote command
    async def exec_remote(
        self,
        cmd: list[str],
        options: ExecRemoteStreamingOptions | ExecRemoteAwaitableOptions | None = None,
        *,
        stream: bool = True,
    ) -> ExecRemoteProcess | ExecResult[str]:
        ...

    # Write a file (creates parent dirs automatically)
    async def write_file(self, file: str, contents: str | bytes) -> None:
        ...

    # Read a file (limit: 100 MiB)
    async def read_file(self, file: str, text: bool = True) -> str | bytes:
        ...

    # Get connection info for interactive debugging
    async def connection(self, *, user: str | None = None) -> SandboxConnection:
        ...
```

### ExecResult fields

```python
result = await sandbox().exec(["ls", "-la"])
result.success    # bool — True if exit code == 0
result.stdout     # str — standard output (truncated to 10 MiB if exceeded)
result.stderr     # str — standard error
result.returncode # int
```

### Expected errors (reported to the model for recovery)

| Error | When raised |
|---|---|
| `TimeoutError` | `exec()` call exceeds `timeout` |
| `UnicodeDecodeError` | Output can't be decoded |
| `PermissionError` | User lacks permission |
| `FileNotFoundError` | File doesn't exist (read_file) |
| `IsADirectoryError` | Path is a directory, not a file |
| `OutputLimitExceededError` | exec output > 10 MiB, or read_file > 100 MiB |

Unexpected errors (network failures, container crashes) fail the sample outright and
are not reported to the model.

---

## Using Sandbox in Tools

```python
from inspect_ai.tool import ToolError, tool
from inspect_ai.util import sandbox

@tool
def list_files():
    async def execute(dir: str) -> str:
        """List the files in a directory.

        Args:
            dir: Directory path to list.

        Returns:
            File listing of the directory.
        """
        result = await sandbox().exec(["ls", "-la", dir])
        if result.success:
            return result.stdout
        else:
            raise ToolError(result.stderr)
    return execute
```

Key patterns:
- Always `raise ToolError(msg)` on failure — this reports the error to the model
- Use `sandbox()` (no args) to target the default sandbox
- The tool's docstring IS the tool description seen by the model — write it carefully

---

## Using Sandbox in Solvers and Scorers

The sandbox is also accessible from within solvers and scorers:

```python
from inspect_ai.solver import solver, TaskState, Generate
from inspect_ai.util import sandbox

@solver
def write_task_file(filename: str = "task.txt"):
    async def solve(state: TaskState, generate: Generate) -> TaskState:
        # Write a file before the agent runs
        await sandbox().write_file(filename, state.input_text)
        state = await generate(state)
        return state
    return solve
```

```python
from inspect_ai.scorer import scorer, Score, Scorer, Target
from inspect_ai.util import sandbox

@scorer(metrics=[accuracy(), stderr()])
def file_contents_scorer() -> Scorer:
    async def score(state: TaskState, target: Target) -> Score:
        # Read a file the agent was supposed to create
        try:
            contents = await sandbox().read_file("output.txt")
            correct = target.text.strip() in contents
            return Score(value=1 if correct else 0, answer=contents)
        except FileNotFoundError:
            return Score(value=0, explanation="output.txt not found")
    return score
```

---

## Multiple Sandboxes: Default Resolution

When multiple sandboxes are defined, the "default" is resolved as:
1. Any service named `default`
2. Any service with `x-default: true`
3. The first service listed

To temporarily redirect tools to a different sandbox:

```python
from inspect_ai.util import sandbox_default

with sandbox_default("victim"):
    # sandbox() calls inside here target "victim"
    result = await sandbox().exec(["cat", "/etc/passwd"])
```

---

## Sandbox Services (Callbacks into Inspect)

Run a lightweight service that sandboxed code can call back into the host process:

```python
from inspect_ai.util import sandbox_service

async def my_solver_with_service(state, generate):
    done_event = anyio.Event()

    async def handle_done():
        done_event.set()

    # Start service (accessible at /var/tmp/sandbox-services/myservice/)
    await sandbox_service(
        name="myservice",
        methods={"done": handle_done},
        until=lambda: done_event.is_set(),
        sandbox=sandbox(),
    )
    return state
```

Inside the sandbox, call the service:
```python
import sys
sys.path.append("/var/tmp/sandbox-services/myservice")
import myservice
myservice.done()
```

---

## Environment Cleanup

```bash
# Automatic cleanup happens after each task by default.

# Disable cleanup (for interactive debugging):
inspect eval ctf.py --no-sandbox-cleanup
# Or in Python:
eval("ctf.py", sandbox_cleanup=False)

# After --no-sandbox-cleanup, get a shell in the container:
docker exec -it inspect-task-ielnkhh-default-1 bash -l

# Manual cleanup:
inspect sandbox cleanup docker                              # all docker environments
inspect sandbox cleanup docker inspect-task-ielnkhh-default-1  # single environment
```

---

## Resource Management

### Max sandboxes (parallel containers)

```bash
inspect eval ctf.py --max-sandboxes 8
```

Docker default: `2 * os.cpu_count()`. When the limit is hit, new samples wait.
Effectively caps `max_samples` at `max_sandboxes`.

### Max subprocesses (parallel exec calls)

```bash
inspect eval ctf.py --max-subprocesses 16
```

Default: `os.cpu_count()`.

### Max samples (overall concurrency)

```bash
inspect eval ctf.py --max-samples 20
```

Default: `max_connections + 1` (typically 11). Raise when samples spend time in
the sandbox rather than waiting for model responses.

---

## Troubleshooting Sandboxes

Enable tracing to see all subprocess and container lifecycle events:

```bash
inspect eval ctf.py --trace
inspect trace anomalies   # show commands that didn't terminate, timed out, or errored
```

Set `INSPECT_LOG_LEVEL=debug` for verbose output:
```bash
INSPECT_LOG_LEVEL=debug inspect eval ctf.py --model anthropic/claude-sonnet-4-0
```

Check the `exec()` return for failures — `result.success` and `result.stderr` are your first
diagnostic tools. Use `timeout_retry=False` for non-idempotent commands.

---

## Full End-to-End Example (CTF Pattern)

```python
# ctf_eval.py
from inspect_ai import task, Task
from inspect_ai.dataset import Sample
from inspect_ai.solver import generate, use_tools
from inspect_ai.tool import bash
from inspect_ai.scorer import scorer, Score, accuracy, stderr
from inspect_ai.util import sandbox

@scorer(metrics=[accuracy(), stderr()])
def flag_scorer():
    async def score(state, target):
        try:
            flag = await sandbox().read_file("/root/flag.txt")
            correct = flag.strip() == target.text.strip()
            return Score(value=1 if correct else 0, answer=flag.strip())
        except FileNotFoundError:
            return Score(value=0, explanation="flag.txt not found")
    return score

DATASET = [
    Sample(
        input="Find and read the flag file hidden somewhere on this system.",
        target="FLAG{secret_value}",
        files={
            # Inline file injected into the default sandbox
            "/root/hint.txt": "The flag is in /root/flag.txt",
            # Actual flag — agent shouldn't find this directly but scorer reads it
            "/root/flag.txt": "FLAG{secret_value}",
        },
        setup="chmod 600 /root/flag.txt",  # hide from ls -la
    )
]

@task
def ctf():
    return Task(
        dataset=DATASET,
        solver=[
            use_tools([bash(timeout=30)]),
            generate(),
        ],
        sandbox="docker",
        scorer=flag_scorer(),
    )
```

```yaml
# compose.yaml (next to ctf_eval.py)
services:
  default:
    image: python:3.12-bookworm
    init: true
    command: tail -f /dev/null
    cpus: 1.0
    mem_limit: 0.5gb
    network_mode: none
```

```bash
inspect eval ctf_eval.py --model anthropic/claude-sonnet-4-0
```