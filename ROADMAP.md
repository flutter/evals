# dart-evals Roadmap: Closing the Gap

> **Context**: After evaluating [Inspect AI](https://inspect.aisi.org.uk/) and
> [Harbor](https://www.harborframework.com/) against our current framework,
> we identified five critical gaps that prevent us from running production-grade
> agentic evals. This document describes each gap, why it matters, what the
> prior art looks like, and a concrete implementation plan against our
> existing codebase.
>
> **Goal**: Close these gaps so that dart-evals is competitive with Inspect
> and Harbor for our specific use case — testing MCP servers, Skills, and
> Dart/Flutter tooling with complex, hill-climbing, agentic evals — while
> keeping the DX advantage of authoring everything in Dart.

---

## Table of Contents

1. [LLM-as-Judge Evaluator](#1-llm-as-judge-evaluator)
2. [Context Compaction](#2-context-compaction)
3. [Multi-Step Eval Orchestration](#3-multi-step-eval-orchestration)
4. [Parallel Matrix Execution](#4-parallel-matrix-execution)
5. [Richer Scoring Primitives](#5-richer-scoring-primitives)

---

## 1. LLM-as-Judge Evaluator

**Priority**: P0  
**Effort**: ~1 week  
**Unblocks**: Nuanced scoring for code quality, correctness in open-ended tasks

### The Gap

Our evaluators today are deterministic: `ExecEvaluator` checks an exit code,
`IncludesEvaluator` checks a substring, `FileChangedEvaluator` diffs a file.
This works for binary pass/fail tasks but can't evaluate:

- Did the agent produce *idiomatic* Dart code?
- Did the agent's explanation *actually answer* the user's question?
- Did the agent use the MCP tools *appropriately* (not just *at all*)?

Both Inspect (`model_graded_qa`, `model_graded_fact`) and Harbor (RewardKit
`llm_as_judge` criteria) solve this with LLM-graded scoring.

### Prior Art

**Inspect AI** provides `model_graded_qa()`:
- Sends the question, target answer, and model output to a grader model
- Custom prompt templates (`question`, `criterion`, `answer`, `instructions`)
- Partial credit support
- Multi-model majority voting (send to 3 models, take the mode)

**Harbor RewardKit** provides `llm_as_judge`:
- Supports binary (yes/no), likert (1-5), and rubric-based grading
- Multi-dimensional: separate criteria in separate subdirectories
- `agent_as_judge`: gives the grading LLM sandbox access to *run* the code

### Implementation Plan

Create `ModelGradedEvaluator` in `packages/framework/lib/src/evaluators/`:

```dart
/// Uses an LLM to grade the agent's output against a rubric.
///
/// The evaluator sends the eval's input, target, and the agent's output
/// to a grading model and parses a structured score from the response.
///
/// ```dart
/// ModelGradedEvaluator(
///   grader: graderAgent,          // an Agent configured with a grading model
///   rubric: 'Is this idiomatic Dart? Consider naming, null safety, and docs.',
///   partialCredit: true,          // allow 0.0–1.0 scores
/// )
/// ```
class ModelGradedEvaluator extends Evaluator {
  final Agent grader;
  final String rubric;
  final bool partialCredit;

  @override
  Future<Score> evaluate(EvalState state) async {
    // 1. Build the grading prompt from a template:
    //    - Question: state.context.eval.input
    //    - Target:   state.context.eval.target
    //    - Answer:   state.outputText
    //    - Rubric:   this.rubric

    // 2. Call grader.run(task: gradingPrompt)

    // 3. Parse structured output:
    //    - Extract GRADE: <C|I|P> and EXPLANATION: ...
    //    - Map to Score.correct / .incorrect / .partial

    // 4. Return Score with answer, explanation, and metadata
    //    containing the raw grader response for debugging.
  }
}
```

**Key decisions:**
- The grader uses our existing `Agent` interface — it's just a model call.
  No special infrastructure needed.
- The prompt template should be a `String Function(...)` parameter so teams
  can customize it, but we provide a sensible default.
- Structured output parsing (GRADE/EXPLANATION) should be regex-based to
  start, with optional JSON schema enforcement later.
- Multi-model voting can be a wrapper: `MajorityVoteEvaluator` that runs
  N `ModelGradedEvaluator`s and takes the mode.

**Files to create/modify:**

| File | Action |
|:---|:---|
| `packages/framework/lib/src/evaluators/model_graded_evaluator.dart` | **New** — core implementation |
| `packages/framework/lib/src/evaluators/grading_templates.dart` | **New** — default prompt templates |
| `packages/framework/lib/src/evaluators/majority_vote_evaluator.dart` | **New** — multi-model wrapper |
| `packages/framework/lib/framework.dart` | **Modify** — export new evaluators |

---

## 2. Context Compaction

**Priority**: P0  
**Effort**: ~2 weeks  
**Unblocks**: Long-horizon agentic evals (10+ turns hit context limits today)

### The Gap

`MiniSweAgent` accumulates the full message history on every turn. On
complex tasks requiring 20+ steps, this will exceed the model's context
window and crash. There is no mechanism to trim, summarize, or edit the
conversation.

### Prior Art

**Inspect AI** offers three strategies:
- `CompactionEdit`: Remove tool outputs from old turns, keep structure.
  Configurable `keep_tool_uses` (default: 3).
- `CompactionSummary`: Use a model to summarize history, replacing it
  with a compressed version. Preserves system + input messages.
- `CompactionTrim`: Drop oldest N% of messages.
- All strategies integrate with a `memory()` tool that lets the agent
  save critical discoveries before compaction.

**Harbor's Terminus-2** uses a 3-step summarization:
1. Summary subagent condenses history
2. Question subagent identifies gaps in the summary
3. Answer subagent fills the gaps from the original history
Plus proactive summarization when free tokens drop below a threshold.

### Implementation Plan

Add compaction as a composable strategy in `packages/ai/`:

```dart
/// Strategy for compacting conversation history when it grows too large.
abstract class CompactionStrategy {
  const CompactionStrategy();

  /// Returns a compacted version of [messages].
  ///
  /// The strategy may remove, rewrite, or summarize messages.
  /// [systemMessages] are the messages that must be preserved at
  /// the start (system prompt, user task).
  Future<List<Message>> compact(
    List<Message> messages, {
    required List<Message> systemMessages,
    required int contextWindowTokens,
    required int currentTokenCount,
  });
}
```

**Phase 1 — Token counting + `CompactionTrim`** (1 week):
- Add a `TokenCounter` interface to `packages/ai/` with a
  `Future<int> countTokens(List<Message>)` method.
- Implement `TiktokenCounter` as a default (using a Dart tiktoken port or
  character-based estimation as a fallback).
- Implement `CompactionTrim` — drops oldest messages to stay under
  `threshold * contextWindowTokens`, always keeping system + user messages.
- Wire into `MiniSweAgent`: check token count before each `ai.generate()`
  call; if over threshold, run the compaction strategy.

**Phase 2 — `CompactionEdit`** (+3 days):
- Walk messages in reverse; strip `ToolResponsePart` outputs from turns
  older than `keepToolUses` turns back.
- Preserves message structure (the model sees that tools were called, but
  not the full output).

**Phase 3 — `CompactionSummary`** (+3 days):
- Use a (potentially cheaper) model to summarize the droppable portion.
- Replace the middle of the conversation with a single system message
  containing the summary.
- Optional: implement question-answer refinement (Harbor's approach) as an
  enhancement later.

**Integration into `MiniSweAgent`:**

```dart
class MiniSweAgent extends Agent {
  // ...existing fields...

  /// Optional compaction strategy for managing context length.
  final CompactionStrategy? compaction;

  /// Fraction of context window that triggers compaction (default: 0.9).
  final double compactionThreshold;

  @override
  Future<Result> run({...}) async {
    // ...existing setup...

    while (status == AgentStatus.running) {
      // NEW: check if compaction is needed before generating
      if (compaction != null) {
        final tokenCount = await tokenCounter.countTokens(messages);
        if (tokenCount > compactionThreshold * contextWindowTokens) {
          messages = await compaction!.compact(
            messages,
            systemMessages: [messages.first, messages[1]], // system + user
            contextWindowTokens: contextWindowTokens,
            currentTokenCount: tokenCount,
          );
        }
      }

      // ...existing generate→execute loop...
    }
  }
}
```

**New `AgentConfig` fields:**

```dart
class AgentConfig extends Equatable {
  // ...existing fields...

  /// Context window size for the model (used for compaction thresholds).
  final int contextWindowTokens;

  /// Fraction of context window that triggers compaction.
  final double compactionThreshold;
}
```

**Files to create/modify:**

| File | Action |
|:---|:---|
| `packages/ai/lib/src/compaction/compaction_strategy.dart` | **New** — abstract interface |
| `packages/ai/lib/src/compaction/compaction_trim.dart` | **New** — simplest strategy |
| `packages/ai/lib/src/compaction/compaction_edit.dart` | **New** — structure-preserving |
| `packages/ai/lib/src/compaction/compaction_summary.dart` | **New** — model-based |
| `packages/ai/lib/src/compaction/token_counter.dart` | **New** — token counting interface + impl |
| `packages/ai/lib/src/agents/mini_swe_agent.dart` | **Modify** — add compaction hook |
| `packages/ai/lib/src/agent_config.dart` | **Modify** — add context window fields |

---

## 3. Multi-Step Eval Orchestration

**Priority**: P0  
**Effort**: ~1.5 weeks  
**Unblocks**: Hill-climbing evals ("scaffold → implement → test → refine")

### The Gap

Each `Eval` today is a single input → single run → single set of scores.
There's no way to express:

- "First scaffold the app, then implement a feature, then add tests"
- "Stop early if the scaffold step scored below 0.5"
- "Score each step independently, then aggregate"

This is what we mean by "hill-climbing" evals — multi-step tasks where
each step builds on the previous one's environment state.

### Prior Art

**Harbor** has first-class multi-step tasks:
- `[[steps]]` array in `task.toml` with per-step instruction, tests, setup
- `min_reward` for early stopping between steps
- `multi_step_reward_strategy`: `"mean"` or `"final"`
- Shared environment (container) across steps — files persist

**Inspect AI** achieves this compositionally:
- Solvers can be chained: `plan=[system_message(), generate(), ...]`
- `on_continue` callbacks can implement retry-until-correct
- Multi-agent workflows (`run()`) pass state sequentially
- No built-in "step" primitive, but solvers compose to the same effect

### Implementation Plan

Add a `MultiStepEval` subclass to `packages/framework/`:

```dart
/// A multi-step evaluation where each step builds on the previous.
///
/// Steps share the same sandbox — files created in step 1 are visible
/// in step 2. Each step has its own input, evaluators, and optional
/// minimum score threshold for early stopping.
///
/// ```dart
/// class BuildAndTestEval extends MultiStepEval {
///   @override
///   String get name => 'build_and_test';
///
///   @override
///   List<EvalStep> get steps => [
///     EvalStep(
///       name: 'scaffold',
///       input: 'Create a Flutter counter app.',
///       evaluators: [FileChangedEvaluator(...)],
///       minScore: 1.0,  // must pass — next steps depend on it
///     ),
///     EvalStep(
///       name: 'add_feature',
///       input: 'Add a reset button to the counter.',
///       evaluators: [FileChangedEvaluator(...), ExecEvaluator(...)],
///       minScore: 0.5,
///     ),
///     EvalStep(
///       name: 'add_tests',
///       input: 'Write widget tests for the reset button.',
///       evaluators: [ExecEvaluator(command: 'flutter test')],
///     ),
///   ];
/// }
/// ```
abstract class MultiStepEval extends Eval {
  List<EvalStep> get steps;

  /// How to aggregate per-step scores into a final score.
  /// Default: mean of all step scores.
  ScoreAggregation get aggregation => ScoreAggregation.mean;
}

class EvalStep {
  final String name;
  final String input;
  final String systemMessage;
  final List<Evaluator> evaluators;

  /// Minimum average score to continue. If the step scores below this,
  /// remaining steps are skipped.
  final double? minScore;

  /// Optional setup callback — runs before the agent, after the previous
  /// step's environment state is in place.
  final Future<void> Function(EvalState state)? setUp;
}

enum ScoreAggregation { mean, last, weightedMean }
```

**How it works:**

1. `MultiStepEval.execute()` overrides the base `Eval.execute()` lifecycle.
2. For each `EvalStep`:
   - Run optional `step.setUp(state)` (e.g., reset a file, install a dep)
   - Update `state.messages` with the new step's input
   - Call `state.agent.run()` — the agent operates on the same sandbox
   - Run `step.evaluators` → collect per-step scores
   - If average score < `step.minScore`, stop early
3. Aggregate per-step scores into the final `EvalResult.scores` map
   using the configured `ScoreAggregation` strategy.
4. The message history carries forward between steps — the agent retains
   context from previous steps (subject to compaction if enabled).

**Key decisions:**
- The sandbox is **shared** across steps (like Harbor). Files persist.
- The agent's message history is **cumulative** — each step appends new
  user messages. The agent can reference previous work.
- Per-step scores are stored in the result map with keys like
  `"scaffold/FileChangedEvaluator"`, `"add_feature/ExecEvaluator"`.
- Early stopping uses `minScore` on the previous step, checked before
  the next step begins.

**Files to create/modify:**

| File | Action |
|:---|:---|
| `packages/framework/lib/src/multi_step_eval.dart` | **New** — `MultiStepEval` + `EvalStep` |
| `packages/framework/lib/src/eval.dart` | **Modify** — extract shared lifecycle logic |
| `packages/framework/lib/framework.dart` | **Modify** — export new classes |
| `packages/evals_results/lib/src/eval_result.dart` | **Modify** — add `stepsCompleted` field |

---

## 4. Parallel Matrix Execution

**Priority**: P1  
**Effort**: ~1 week  
**Unblocks**: Faster iteration on large eval sets

### The Gap

`EvalSet.run()` iterates the `models × scenarios × evals` matrix
sequentially with nested `for` loops. A 3×3×5 matrix (45 cells) runs
serially, which is unnecessarily slow when cells are independent.

### Prior Art

**Inspect AI** uses `asyncio` with configurable `max_sandboxes` and
`max_connections` to run samples in parallel. It also supports running
multiple tasks in parallel with `eval_set()`.

**Harbor** scales horizontally across cloud sandbox providers, running
100+ parallel trials.

### Implementation Plan

Add a `maxParallel` parameter to `EvalSet` and use `Stream`-based
concurrency:

```dart
class EvalSet {
  // ...existing fields...

  /// Maximum number of cells to run in parallel.
  /// Default: 1 (sequential — current behavior).
  final int maxParallel;

  Future<List<EvalResult>> run({...}) async {
    final results = <EvalResult>[];
    final cells = <_CellSpec>[];

    // 1. Build the cell list
    for (final model in models) {
      for (final scenario in scenarios) {
        for (final eval in evals) {
          cells.add(_CellSpec(model: model, scenario: scenario, eval: eval));
        }
      }
    }

    // 2. Run with bounded parallelism
    final pool = Pool(maxParallel);
    final futures = cells.map((cell) => pool.withResource(
      () => _runCell(cell.eval, cell.model, cell.scenario, runDir: runDir),
    ));

    for (final result in await Future.wait(futures)) {
      results.add(result);
      if (onResult != null) await onResult(result, results);
    }

    return results;
  }
}
```

**Constraints:**
- Sandbox sessions must be independent (already true — each cell creates
  its own session in `_runCell`).
- MCP servers must support concurrent sessions (already true — each cell
  starts/stops its own `McpSession`).
- Backend model calls must be thread-safe (they are — Genkit handles this).
- Logging needs cell-ID prefixes to avoid interleaved output.
- The `onResult` callback needs a mutex to prevent concurrent writes to
  the same `eval.json` file.

**Dependencies**: [`package:pool`](https://pub.dev/packages/pool) for
bounded concurrency (or implement a simple semaphore).

**Files to create/modify:**

| File | Action |
|:---|:---|
| `packages/framework/lib/src/eval_set.dart` | **Modify** — add `maxParallel`, parallel execution |
| `packages/framework/lib/src/logging/eval_log.dart` | **Modify** — add cell-ID prefixing |
| `packages/framework/pubspec.yaml` | **Modify** — add `pool` dependency |

---

## 5. Richer Scoring Primitives

**Priority**: P1  
**Effort**: ~3 days  
**Unblocks**: Multi-dimensional scoring, aggregate metrics, post-hoc re-scoring

### The Gap

Our `Score` class is a single `double value` with an optional explanation.
This prevents:

- **Multi-dimensional scoring**: Tracking `correctness=0.9, style=0.7,
  performance=0.5` independently
- **Aggregate metrics**: Computing accuracy, mean, stderr across an eval set
- **Post-hoc re-scoring**: Running new evaluators on existing results
  without re-running the agent

### Prior Art

**Inspect AI**:
- Score value can be a dict: `{"accuracy": 1, "style": 0.8}`
- Built-in metrics: `accuracy()`, `mean()`, `stderr()`, `bootstrap_stderr()`
- Epoch reducers: `mean`, `mode`, `pass_at_k`, `at_least_k`
- `inspect score` CLI to re-score existing logs

**Harbor RewardKit**:
- Subdirectory-based multi-dim rewards with weighted aggregation
- `weighted_mean`, `all_pass`, `any_pass`, `threshold` strategies

### Implementation Plan

**Phase 1 — Score metadata for multi-dimensional scores:**

The `Score.metadata` field already exists. Establish a convention:

```dart
Score(
  value: 0.8,               // the primary/aggregate score
  metadata: {
    'dimensions': {
      'correctness': 1.0,
      'code_quality': 0.7,
      'test_coverage': 0.6,
    },
  },
  explanation: 'Code works but could be cleaner.',
);
```

Create a `DimensionalScore` helper:

```dart
class DimensionalScore {
  /// Creates a Score from multiple named dimensions.
  ///
  /// The primary [Score.value] is computed via [aggregation].
  static Score from({
    required Map<String, double> dimensions,
    ScoreAggregation aggregation = ScoreAggregation.mean,
    String? explanation,
  }) {
    final value = switch (aggregation) {
      ScoreAggregation.mean => dimensions.values.average,
      ScoreAggregation.last => dimensions.values.last,
      // ... etc
    };
    return Score(
      value: value,
      metadata: {'dimensions': dimensions},
      explanation: explanation,
    );
  }
}
```

**Phase 2 — Aggregate metrics on `EvalSetResult`:**

```dart
extension EvalSetMetrics on EvalSetResult {
  /// Mean score across all results for a given evaluator name.
  double meanScore(String evaluatorName) { ... }

  /// Accuracy (fraction of results with score >= threshold).
  double accuracy(String evaluatorName, {double threshold = 1.0}) { ... }

  /// Standard error of the mean.
  double stderr(String evaluatorName) { ... }
}
```

**Phase 3 — Post-hoc re-scoring CLI:**

Add a `dart run rescore` command that:
1. Loads an existing `eval.json`
2. Deserializes the `EvalResult` entries (which contain trajectory data)
3. Reconstructs `EvalState` from the stored trajectory
4. Runs new evaluators against the reconstructed state
5. Writes updated scores back to `eval.json`

This requires the trajectory data in `EvalResult` to be rich enough to
reconstruct `EvalState`. We already store `trajectory` (the message list)
and `store` — this should be sufficient for most evaluators.

**Files to create/modify:**

| File | Action |
|:---|:---|
| `packages/framework/lib/src/evaluators/dimensional_score.dart` | **New** — multi-dim helper |
| `packages/evals_results/lib/src/eval_set_result.dart` | **Modify** — add metric extensions |
| `packages/framework/bin/rescore.dart` | **New** — post-hoc re-scoring CLI |

---

## Priority Summary

```
                              ┌─────────────────────┐
                              │  Week 1             │
                              │                     │
                              │  LLM-as-Judge       │
                              │  Evaluator          │
                              └──────────┬──────────┘
                                         │
                              ┌──────────▼──────────┐
                              │  Weeks 2–3          │
                              │                     │
                              │  Context            │
                              │  Compaction         │
                              └──────────┬──────────┘
                                         │
                    ┌────────────────────┬┴──────────────────┐
                    │                    │                    │
         ┌──────────▼──────────┐ ┌──────▼───────┐ ┌─────────▼─────────┐
         │  Week 4             │ │  Week 4      │ │  Week 4–5         │
         │                     │ │              │ │                   │
         │  Richer Scoring     │ │  Parallel    │ │  Multi-Step       │
         │  Primitives         │ │  Execution   │ │  Orchestration    │
         └─────────────────────┘ └──────────────┘ └───────────────────┘
```

**Total estimated effort**: ~5 weeks of focused work.

After these five items, dart-evals will have feature parity with Inspect
and Harbor on the axes that matter for our use case, while keeping the
Dart-native DX that makes it uniquely suited to our team.
