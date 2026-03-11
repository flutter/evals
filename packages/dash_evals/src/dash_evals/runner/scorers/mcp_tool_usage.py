"""Scorer for verifying MCP tool usage during evaluations."""

from inspect_ai.scorer import Score, Scorer, Target, accuracy, scorer
from inspect_ai.solver import TaskState

# Complete list of Dart MCP server tools from:
# https://github.com/dart-lang/ai/tree/main/pkgs/dart_mcp_server
DART_MCP_TOOLS: set[str] = {
    "add_roots",
    "analyze_files",
    "connect_dart_tooling_daemon",
    "create_project",
    "dart_fix",
    "dart_format",
    "flutter_driver",
    "get_active_location",
    "get_app_logs",
    "get_runtime_errors",
    "get_selected_widget",
    "get_widget_tree",
    "hot_reload",
    "hot_restart",
    "hover",
    "launch_app",
    "list_devices",
    "list_running_apps",
    "pub",
    "pub_dev_search",
    "read_package_uris",
    "remove_roots",
    "resolve_workspace_symbol",
    "rip_grep_packages",
    "run_tests",
    "set_widget_selection_mode",
    "signature_help",
    "stop_app",
}


@scorer(metrics=[accuracy()])
def mcp_tool_usage(
    mcp_server_name: str = "Dart",
    mcp_tool_names: list[str] | None = None,
    required_tools: list[str] | None = None,
) -> Scorer:
    """
    Scorer that checks if an MCP tool from the specified server was called.

    This scorer examines the message history to determine whether the model
    actually used an MCP tool (vs. answering from its training data).

    Args:
        mcp_server_name: The name prefix of the MCP server tools. Tools matching
                         "{mcp_server_name}_*" pattern will be identified as
                         MCP tools.
        mcp_tool_names: Optional list of specific tool names to identify as MCP
                        tools. If not provided and mcp_server_name is "Dart",
                        defaults to the full DART_MCP_TOOLS list.
        required_tools: Optional list of specific MCP tool names that MUST have
                        been called for a passing score. If provided, the scorer
                        checks that every tool in this list was used. If not
                        provided, any MCP tool usage counts as a pass.

    Returns:
        A Scorer that returns "C" if MCP tool(s) were used as required, "I" otherwise.

    Example::

        from dash_evals.scorers import mcp_tool_usage

        Task(
            dataset=my_dataset,
            solver=react(),
            tools=[dart_mcp_server],
            scorer=[
                includes(ignore_case=True),  # Check answer correctness
                mcp_tool_usage(),             # Uses DART_MCP_TOOLS by default
                # Or check specific tools:
                # mcp_tool_usage(required_tools=["create_project"]),
            ],
        )
    """
    # Default to DART_MCP_TOOLS for Dart server, otherwise use provided list
    if mcp_tool_names is not None:
        known_mcp_tools = set(mcp_tool_names)
    elif mcp_server_name == "Dart":
        known_mcp_tools = DART_MCP_TOOLS
    else:
        known_mcp_tools = set()

    async def score(state: TaskState, target: Target) -> Score:
        # Track all tools called and whether MCP tool was used
        tools_called: list[str] = []
        mcp_tool_used = False
        mcp_tools_called: list[str] = []

        # Look through all messages for tool calls
        for message in state.messages:
            # Check if message has tool_calls attribute (assistant messages with tool use)
            if hasattr(message, "tool_calls") and message.tool_calls:
                for tool_call in message.tool_calls:
                    tool_name = tool_call.function
                    tools_called.append(tool_name)

                    # Check if this is an MCP tool:
                    # 1. Prefixed with server name (e.g., "Dart_search_packages")
                    # 2. OR in the explicit list of known MCP tool names
                    is_mcp_tool = tool_name.startswith(f"{mcp_server_name}_") or (
                        tool_name in known_mcp_tools
                    )
                    if is_mcp_tool:
                        mcp_tool_used = True
                        mcp_tools_called.append(tool_name)

        # Check required_tools if specified
        if required_tools:
            mcp_tools_called_set = set(mcp_tools_called)
            missing_tools = [t for t in required_tools if t not in mcp_tools_called_set]
            if missing_tools:
                explanation = (
                    f"Required MCP tool(s) NOT used: {missing_tools}. "
                    f"MCP tools called: {mcp_tools_called if mcp_tools_called else 'none'}. "
                    f"All tools called: {tools_called if tools_called else 'none'}"
                )
                return Score(
                    value="I",
                    answer=", ".join(mcp_tools_called) if mcp_tools_called else "none",
                    explanation=explanation,
                    metadata={
                        "mcp_server_name": mcp_server_name,
                        "mcp_tool_used": mcp_tool_used,
                        "mcp_tools_called": mcp_tools_called,
                        "all_tools_called": tools_called,
                        "required_tools": required_tools,
                        "missing_tools": missing_tools,
                    },
                )

        # Build explanation
        if mcp_tool_used:
            explanation = (
                f"MCP tool(s) from '{mcp_server_name}' server were used: {mcp_tools_called}"
            )
        else:
            explanation = (
                f"MCP tool from '{mcp_server_name}' server was NOT used. "
                f"All tools called: {tools_called if tools_called else 'none'}"
            )

        return Score(
            value="C" if mcp_tool_used else "I",
            answer=", ".join(mcp_tools_called) if mcp_tools_called else "none",
            explanation=explanation,
            metadata={
                "mcp_server_name": mcp_server_name,
                "mcp_tool_used": mcp_tool_used,
                "mcp_tools_called": mcp_tools_called,
                "all_tools_called": tools_called,
            },
        )

    return score
