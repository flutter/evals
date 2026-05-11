/// Agent framework: base classes, configuration, and implementations.
///
/// Provides [Agent], [AgentConfig], [AgentStatus], and [Result] as the
/// foundation for building AI agents, plus two ready-to-use implementations:
///
/// - [BasicAgent] — single-turn: sends the task, returns the response.
/// - [MiniSweAgent] — multi-turn: runs a full tool-calling loop.
///
/// For the core AI primitives ([Message], [Part], [Role], etc.), import
/// `package:ai/ai.dart`.
library;

export 'src/agent.dart';
export 'src/agent_config.dart';
export 'src/agent_status.dart';
export 'src/result.dart';

// Implementations
export 'src/agents/basic_agent.dart';
export 'src/agents/mini_swe_agent.dart';
