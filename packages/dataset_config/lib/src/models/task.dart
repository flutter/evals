import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:dataset_config/src/models/models.dart';

part 'task.freezed.dart';
part 'task.g.dart';

/// Dart representation of Inspect AI's `Task` class.
///
/// Models the configuration accepted by the
/// [`Task.__init__`](https://inspect.aisi.org.uk/reference/inspect_ai.html#task)
/// constructor.
@freezed
sealed class Task with _$Task {
  const factory Task({
    /// Dataset to evaluate.
    ///
    /// A `Dataset`, a sequence of `Sample` objects, or `null`.
    Dataset? dataset,

    /// Setup step (always run even when the main solver is replaced).
    Object? setup,

    /// Solver or list of solvers. Defaults to `generate()`.
    Object? solver,

    /// Optional cleanup function for task.
    ///
    /// Called after all solvers and scorers have run for each sample
    /// (including if an exception occurs during the run).
    Object? cleanup,

    /// Scorer used to evaluate model output.
    Object? scorer,

    /// Alternative metrics (overrides the metrics provided by the scorer).
    Object? metrics,

    /// Default model for task (optional, defaults to the eval model).
    String? model,

    /// Model generation config for default model.
    Object? config,

    /// Named roles for use in `get_model()`.
    @JsonKey(name: 'model_roles') Map<String, String>? modelRoles,

    /// Sandbox environment type (or a shorthand spec).
    Object? sandbox,

    /// Tool use approval policies.
    Object? approval,

    /// Epochs to repeat samples for and optional score reducer function(s).
    Object? epochs,

    /// Fail on sample errors.
    ///
    /// `true` = fail on first error (default), `false` = never fail,
    /// `0.0–1.0` = fail if proportion exceeds threshold,
    /// `>1` = fail if count exceeds threshold.
    @JsonKey(name: 'fail_on_error') Object? failOnError,

    /// Continue running if the `fail_on_error` condition is met.
    @JsonKey(name: 'continue_on_fail') bool? continueOnFail,

    /// Limit on total messages per sample.
    @JsonKey(name: 'message_limit') int? messageLimit,

    /// Limit on total tokens per sample.
    @JsonKey(name: 'token_limit') int? tokenLimit,

    /// Limit on clock time (in seconds) per sample.
    @JsonKey(name: 'time_limit') int? timeLimit,

    /// Limit on working time (in seconds) per sample.
    ///
    /// Working time includes model generation, tool calls, etc. but does not
    /// include waiting on retries or shared resources.
    @JsonKey(name: 'working_limit') int? workingLimit,

    /// Limit on total cost (in dollars) per sample.
    @JsonKey(name: 'cost_limit') double? costLimit,

    /// Early stopping callbacks.
    @JsonKey(name: 'early_stopping') Object? earlyStopping,

    /// Task display name (e.g. for plotting).
    ///
    /// Defaults to the registered task name.
    @JsonKey(name: 'display_name') String? displayName,

    /// Task function identifier for Mode 1 hydration.
    ///
    /// When present, the Python runner uses this to look up a pre-built
    /// `@task` function (e.g. `"flutter_code_gen"` or
    /// `"eval_runner.runner.tasks.flutter_code_gen"`).
    /// When absent, the runner hydrates directly from JSON (Mode 2 — future).
    @JsonKey(name: 'task_func') String? taskFunc,

    /// Task name.
    ///
    /// Automatically determined based on the registered name if not specified.
    String? name,

    /// Version of task (to distinguish evolutions of the task spec).
    @Default(0) Object version,

    /// Additional metadata to associate with the task.
    Map<String, dynamic>? metadata,
  }) = _Task;

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);
}

class TaskMetadata {
  final String taskFunc;
  final Map<String, Object?> additional;

  TaskMetadata(this.taskFunc, this.additional);

  Map<String, dynamic> toJson() {
    return {
      'taskFunc': taskFunc,
    };
  }
}
