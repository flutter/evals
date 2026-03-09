import 'models/models.dart';

/// Default system message used when no override is provided.
const kDefaultSystemMessage =
    'You are a helpful assistant with deep expertise in Dart and Flutter '
    'development. Answer questions clearly and accurately, providing '
    'examples when helpful.';

/// Lightweight intermediate type used during parsing and resolution.
///
/// Groups samples with task-level config (variant, sandbox, etc.) before
/// the resolver produces the final [Task] objects. This replaces the
/// former `TaskConfig` model-package class.
class ParsedTask {
  final String id;
  final String taskFunc;
  final List<Sample> samples;
  final Variant variant;
  final String sandboxType;
  final String? systemMessage;
  final List<String>? allowedVariants;
  final bool saveExamples;
  final String? examplesDir;

  // ------------------------------------------------------------------
  // Task-level settings (from task.yaml)
  // ------------------------------------------------------------------

  /// Default model for this task.
  final String? model;

  /// Model generation config.
  final Map<String, dynamic>? config;

  /// Named roles for use in `get_model()`.
  final Map<String, String>? modelRoles;

  /// Sandbox environment type (or a shorthand spec).
  final Object? sandbox;

  /// Tool use approval policies.
  final Object? approval;

  /// Epochs to repeat samples for.
  final Object? epochs;

  /// Fail on sample errors.
  final Object? failOnError;

  /// Continue running if the `fail_on_error` condition is met.
  final bool? continueOnFail;

  /// Limit on total messages per sample.
  final int? messageLimit;

  /// Limit on total tokens per sample.
  final int? tokenLimit;

  /// Limit on clock time (in seconds) per sample.
  final int? timeLimit;

  /// Limit on working time (in seconds) per sample.
  final int? workingLimit;

  /// Limit on total cost (in dollars) per sample.
  final double? costLimit;

  /// Early stopping callbacks.
  final Object? earlyStopping;

  /// Task display name (e.g. for plotting).
  final String? displayName;

  /// Version of task.
  final Object? version;

  /// Additional metadata to associate with the task.
  final Map<String, dynamic>? metadata;

  const ParsedTask({
    required this.id,
    required this.taskFunc,
    required this.samples,
    required this.variant,
    this.sandboxType = 'local',
    this.systemMessage,
    this.allowedVariants,
    this.saveExamples = false,
    this.examplesDir,
    // Task-level settings
    this.model,
    this.config,
    this.modelRoles,
    this.sandbox,
    this.approval,
    this.epochs,
    this.failOnError,
    this.continueOnFail,
    this.messageLimit,
    this.tokenLimit,
    this.timeLimit,
    this.workingLimit,
    this.costLimit,
    this.earlyStopping,
    this.displayName,
    this.version,
    this.metadata,
  });

  /// Create a copy with overrides.
  ParsedTask copyWith({
    String? id,
    String? taskFunc,
    List<Sample>? samples,
    Variant? variant,
    String? sandboxType,
    String? systemMessage,
    List<String>? allowedVariants,
    bool? saveExamples,
    String? examplesDir,
    String? model,
    Map<String, dynamic>? config,
    Map<String, String>? modelRoles,
    Object? sandbox,
    Object? approval,
    Object? epochs,
    Object? failOnError,
    bool? continueOnFail,
    int? messageLimit,
    int? tokenLimit,
    int? timeLimit,
    int? workingLimit,
    double? costLimit,
    Object? earlyStopping,
    String? displayName,
    Object? version,
    Map<String, dynamic>? metadata,
  }) {
    return ParsedTask(
      id: id ?? this.id,
      taskFunc: taskFunc ?? this.taskFunc,
      samples: samples ?? this.samples,
      variant: variant ?? this.variant,
      sandboxType: sandboxType ?? this.sandboxType,
      systemMessage: systemMessage ?? this.systemMessage,
      allowedVariants: allowedVariants ?? this.allowedVariants,
      saveExamples: saveExamples ?? this.saveExamples,
      examplesDir: examplesDir ?? this.examplesDir,
      model: model ?? this.model,
      config: config ?? this.config,
      modelRoles: modelRoles ?? this.modelRoles,
      sandbox: sandbox ?? this.sandbox,
      approval: approval ?? this.approval,
      epochs: epochs ?? this.epochs,
      failOnError: failOnError ?? this.failOnError,
      continueOnFail: continueOnFail ?? this.continueOnFail,
      messageLimit: messageLimit ?? this.messageLimit,
      tokenLimit: tokenLimit ?? this.tokenLimit,
      timeLimit: timeLimit ?? this.timeLimit,
      workingLimit: workingLimit ?? this.workingLimit,
      costLimit: costLimit ?? this.costLimit,
      earlyStopping: earlyStopping ?? this.earlyStopping,
      displayName: displayName ?? this.displayName,
      version: version ?? this.version,
      metadata: metadata ?? this.metadata,
    );
  }
}
