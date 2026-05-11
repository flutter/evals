# Agents, Tools & Sandboxing Reference

## Tools

### Built-in tools (import from `inspect_ai.tool`)
```python
from inspect_ai.tool import bash, python, web_search, web_browser, text_editor

Task(
    solver=[generate()],
    tools=[bash(timeout=30), python()],
    sandbox="docker",
)
```

Standard tools: `bash()`, `python()`, `web_search()`, `web_browser()`,
`text_editor()`, `computer()` (screenshot/click)

### Custom tools
```python
from inspect_ai.tool import tool, ToolCall

@tool
def calculator() -> Tool:
    async def run(expression: str) -> str:
        """Evaluate a mathematical expression.
        
        Args:
            expression: Python expression to evaluate, e.g. "2 + 2"
        """
        try:
            return str(eval(expression))
        except Exception as e:
            return f"Error: {e}"
    return run
```

The docstring is passed to the model as the tool description — write it carefully.

---

## Sandboxing

For complete sandboxing documentation — environment types, `compose.yaml` patterns,
per-sample files, the full `SandboxEnvironment` API, multi-sandbox setups, resource
management, and cleanup — read **`references/sandboxing.md`**.

Quick reference:

```python
Task(..., sandbox="docker")                      # use docker sandbox
Task(..., sandbox=("docker", "my-compose.yaml")) # explicit compose file

# In a tool/solver/scorer — access the sandbox
from inspect_ai.util import sandbox
result = await sandbox().exec(["python", "run.py"])
await sandbox().write_file("task.py", code)
contents = await sandbox().read_file("output.txt")
sandbox("victim")    # named sandbox in multi-sandbox setup
```

---

## ReAct Agent

The built-in ReAct (Reason + Act) agent loops until the model stops using tools
or a limit is reached.

```python
from inspect_ai.agent import react_agent

@task
def my_agent_eval():
    return Task(
        dataset=csv_dataset("tasks.csv"),
        solver=react_agent(
            tools=[bash(), python()],
            max_messages=50,
        ),
        sandbox="docker",
        scorer=my_scorer(),
    )
```

### ReAct customization
```python
react_agent(
    tools=[...],
    max_messages=30,           # stop after N messages
    message_limit=None,        # alias for max_messages
    agent_loop=None,           # supply custom loop function
    system_prompt="...",       # override system prompt
    on_complete=None,          # callback when agent stops
)
```

---

## Multi-Agent

### Handoff pattern — one agent spawns another
```python
from inspect_ai.agent import handoff

orchestrator = react_agent(
    tools=[
        bash(),
        handoff(subagent_task, name="subagent"),
    ]
)
```

### Subagent via `@subtask`
```python
from inspect_ai.agent import subtask

@subtask
async def verify_solution(state: TaskState) -> bool:
    # Isolated transcript scope — won't pollute parent's log
    model = get_model()
    result = await model.generate([...])
    return "PASS" in result.completion
```

`@subtask` creates its own transcript entry in Inspect View, enabling clean
observability of complex multi-step agent behavior.

---

## Custom Agents

For full control beyond ReAct, write a custom solver that manages the loop:

```python
from inspect_ai.solver import solver, TaskState, Generate
from inspect_ai.model import ChatMessageUser, ChatMessageAssistant

@solver
def my_agent(max_turns: int = 10):
    async def solve(state: TaskState, generate: Generate) -> TaskState:
        for turn in range(max_turns):
            state = await generate(state)
            
            # Check if the agent wants to stop
            last = state.output.completion
            if "DONE" in last:
                break
            
            # Inject follow-up based on output
            state.messages.append(
                ChatMessageUser(content=f"Continue. Turn {turn+1}/{max_turns}.")
            )
        
        return state
    return solve
```

### Agent Bridge (third-party agents)
Run external agent frameworks inside Inspect:
```python
from inspect_ai.agent import AgentBridge
from my_langchain_agent import MyAgent

@task
def bridged_eval():
    return Task(
        dataset=dataset,
        solver=AgentBridge(MyAgent()),
        scorer=scorer,
    )
```
Supports: OpenAI Agents SDK, LangChain, Pydantic AI, and others.

---

## Tool Approval

Human-in-the-loop or policy-based gating for sensitive tool calls:

```python
from inspect_ai.approval import approval_policy, bash_approval

Task(
    ...,
    approval=approval_policy(
        rules=[bash_approval(allow=["ls", "cat"], deny=["rm"])]
    )
)
```

Or use `human_approval()` to prompt a human before each tool call (useful for
building human baseline datasets).

---

## Observability Tips

- Use `@subtask` liberally to create named scopes in Inspect View transcripts
- Prefer `state.store.set(key, value)` over metadata for mutable per-sample state
- `transcript().info({"step": "planning"})` adds structured events to the trace log
- Set `INSPECT_LOG_LEVEL=debug` for verbose output during development