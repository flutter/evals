"""
Code Generation Task (Generic)

Evaluates LLM ability to write working code from scratch. Language-specific
behavior (response schema, system message, target path) is controlled via
the config dict. Thin wrappers (e.g., `flutter_code_gen`) supply language defaults.

Evaluates by:
1. Generating code based on prompts
2. Executing code in a sandbox
3. Running tests
4. Analyzing code quality
5. Scoring based on test results and code metrics

Uses structured output to get clean code without regex extraction.
"""

from inspect_ai import Task, task
from inspect_ai.dataset import Dataset
from inspect_ai.model import GenerateConfig, ResponseSchema
from inspect_ai.solver import Generate, Solver, TaskState, chain_of_thought, solver
from inspect_ai.util import json_schema
from pydantic import BaseModel, Field

from dash_evals.runner.scorers import export_workspace, flutter_code_scorer
from dash_evals.runner.solvers import (
    add_system_message,
    inject_test_files,
    setup_workspace,
    write_to_sandbox,
)
from dash_evals.runner.tasks.task_helpers import validate_sandbox_tools

from .task_helpers import (
    append_context_injection,
    append_model_interaction,
    build_task_metadata,
)

# ============================================================================
# Structured Output Models
# ============================================================================


class FlutterCodeResponse(BaseModel):
    """Structured response for Flutter code generation."""

    main_dart: str = Field(
        description="Complete Dart code for lib/main.dart. Must include all imports and a MyApp class."
    )
    reasoning: str = Field(
        default="",
        description="Brief explanation of key implementation decisions (optional).",
    )


class GenericCodeResponse(BaseModel):
    """Generic structured response for code generation."""

    code: str = Field(description="Complete source code for the target file.")
    reasoning: str = Field(
        default="",
        description="Brief explanation of key implementation decisions (optional).",
    )


# Map of known response schemas by language
RESPONSE_SCHEMAS: dict[str, type[BaseModel]] = {
    "flutter": FlutterCodeResponse,
    "generic": GenericCodeResponse,
}


# ============================================================================
# Structured Output Solver
# ============================================================================


@solver
def parse_structured_code(
    code_field: str = "main_dart", response_model: type[BaseModel] | None = None
) -> Solver:
    """
    Parse structured JSON output and store extracted code.

    Reads the model's structured JSON response, extracts the code field,
    and stores it in state.store["extracted_code"] for write_to_sandbox.

    Args:
        code_field: The field name containing the code in the response model.
        response_model: Optional Pydantic model to validate against. If None,
                        attempts to use the raw output.
    """

    async def solve(state: TaskState, generate: Generate) -> TaskState:
        try:
            if response_model:
                response = response_model.model_validate_json(state.output.completion)
                code = getattr(response, code_field)
                state.store.set("extracted_code", code)
                state.metadata["generated_code"] = code
                reasoning = getattr(response, "reasoning", "")
                if reasoning:
                    state.metadata["model_reasoning"] = reasoning
            else:
                state.store.set("extracted_code", state.output.completion)
                state.metadata["generated_code"] = state.output.completion
        except Exception as e:
            # If parsing fails, try to use the raw output as code
            # This handles cases where the model ignores the schema
            state.store.set("extracted_code", state.output.completion)
            state.metadata["generated_code"] = state.output.completion
            state.metadata["structured_parse_error"] = str(e)
        return state

    return solve


# ============================================================================
# Default System Messages
# ============================================================================

DEFAULT_CODE_GEN_SYSTEM_MESSAGE = (
    "You are an expert developer. "
    "Generate complete, working code that follows best practices. "
    "Your code will be tested automatically, so ensure it compiles and runs correctly. "
    "Provide the complete code in your response."
)

FLUTTER_CODE_GEN_SYSTEM_MESSAGE = (
    "You are an expert Flutter developer. "
    "Generate complete, working Flutter code that follows best practices. "
    "IMPORTANT: Your main app class MUST be named 'MyApp'. "
    "Your code will be tested automatically, so ensure it compiles and runs correctly. "
    "Always include proper imports and use const constructors where appropriate. "
    "Provide the complete code in the main_dart field of your response."
)


# ============================================================================
# Solver Builder
# ============================================================================


def _build_solver_with_tools(config: dict, system_msg: str):
    """Build solver with optional MCP server tools and chain_of_thought."""
    solver_chain = [add_system_message(system_msg)]
    append_context_injection(solver_chain, config)
    solver_chain.append(chain_of_thought())
    append_model_interaction(solver_chain, config)

    return solver_chain


# ============================================================================
# Generic Task
# ============================================================================


@task
def code_gen(dataset: Dataset, config: dict) -> Task:
    """
    Generic task for evaluating LLM code generation.

    The config dict controls language-specific behavior:
    - system_message: Custom system prompt (optional)
    - target_path: Where to write generated code (default: "lib/main.dart")
    - response_schema_name: Key into RESPONSE_SCHEMAS (default: "generic")
    - response_schema_description: Description for the schema (optional)
    - code_field: Field name for code in structured output (default: "code")

    Args:
        dataset: Inspect dataset loaded from JSONL.
        config: Task manifest entry with variant, system_message, etc.
    """
    validate_sandbox_tools(config, ["bash_session", "text_editor"])

    system_msg = config.get("system_message") or DEFAULT_CODE_GEN_SYSTEM_MESSAGE
    target_path = config.get("target_path", "lib/main.dart")
    schema_name = config.get("response_schema_name", "generic")
    code_field = config.get("code_field", "code")

    response_model = RESPONSE_SCHEMAS.get(schema_name, GenericCodeResponse)

    solver_chain = _build_solver_with_tools(config, system_msg)

    # Use scorers from config or default
    scorers: list = config.get("scorers", [flutter_code_scorer()])
    if config.get("save_examples"):
        scorers.append(export_workspace())

    schema_description = config.get(
        "response_schema_description",
        f"Source code for {target_path}",
    )

    return Task(
        name=config["task_name"],
        dataset=dataset,
        setup=[
            setup_workspace(),
            inject_test_files(),
        ],
        solver=[
            *solver_chain,
            parse_structured_code(
                code_field=code_field,
                response_model=response_model,
            ),
            write_to_sandbox(target_path=target_path),
        ],
        scorer=scorers,
        config=GenerateConfig(
            response_schema=ResponseSchema(
                name="generated_code",
                json_schema=json_schema(response_model),
                description=schema_description,
            )
        ),
        time_limit=config.get("time_limit", 300),
        metadata=build_task_metadata(config),
    )


# ============================================================================
# Flutter Thin Wrapper
# ============================================================================


@task
def flutter_code_gen(dataset: Dataset, config: dict) -> Task:
    """
    Flutter-specific code generation task.

    Thin wrapper around code_gen() with Flutter defaults:
    - Flutter system message
    - FlutterCodeResponse schema
    - target_path = "lib/main.dart"
    - flutter_code_scorer

    Args:
        dataset: Inspect dataset loaded from JSONL.
        config: Task manifest entry with variant, system_message, etc.
    """
    # Apply Flutter defaults without overriding explicit config
    flutter_config = {
        "system_message": FLUTTER_CODE_GEN_SYSTEM_MESSAGE,
        "target_path": "lib/main.dart",
        "response_schema_name": "flutter",
        "response_schema_description": "Flutter application code for lib/main.dart",
        "code_field": "main_dart",
        **config,  # User config wins
    }
    # Ensure Flutter scorers are used unless explicitly overridden
    if "scorers" not in config:
        scorers: list = [flutter_code_scorer()]
        if config.get("save_examples"):
            scorers.append(export_workspace())
        flutter_config["scorers"] = scorers

    return code_gen(dataset, flutter_config)
