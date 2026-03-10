import '../variant_defaults.dart';

/// Builds a String of valid YAML for a job configuration file.
///
/// Job files define WHAT to run and HOW to run it. They live in the jobs/
/// directory and are selected via `devals run <job_name>`.
///
/// Jobs can:
/// - Override runtime settings (logs, sandbox, rate limits)
/// - Define named variants to run
/// - Filter which models and tasks to run
/// - Configure per-task options (sample filtering)
///
String jobTemplate({
  required String name,
  required List<String> models,
  required List<String> variants,
  required List<String> tasks,
}) {
  final modelsList = models.map((m) => '  - $m').join('\n');
  final tasksList = tasks.map((t) => '    $t: {}').join('\n');

  // Build named variant map YAML
  // Currently this doesn't work
  final variantsMap = variantDefaults(variants);

  return '''
# =============================================================================
# Job Configuration: $name
# =============================================================================
# A job defines what subset of your dataset to run and how to run it.
# Jobs are the primary way to control evaluation runs.
#
# To run this job:
#   devals run $name


# =============================================================================
# RUNTIME SETTINGS (Optional)
# =============================================================================
# !!!Important!!!
# These override built-in defaults. If you're just getting started,
# I recommend you ignore these for now.
# Uncomment and modify as needed.

# Directory for evaluation logs (relative to dataset root)
# A timestamped subdirectory is created automatically for each run.
# logs_dir: ../logs

# Sandbox environment: "local", "docker", or "podman"
# - local: Run directly on host (fastest, no isolation)
# - docker: Run in Docker containers (recommended for code execution)
# - podman: Run in Podman containers (rootless alternative to Docker)
# sandbox_type: local

# Maximum concurrent API connections to model providers.
# Higher = faster but may hit rate limits with a large dataset
# max_connections: 10

# Maximum retry attempts for failed API calls.
# Helps handle transient errors.
# max_retries: 3

# Save the agent's final workspace to logs/<run>/examples/ after each sample.
# Useful for reviewing the code produced during an eval run.
# save_examples: false

# =============================================================================
# MODELS
# =============================================================================
# Which models to evaluate. Format: "provider/model-name"
# If omitted, falls back to DEFAULT_MODELS from the Python registries.
models:
$modelsList

# =============================================================================
# VARIANTS
# =============================================================================
# Named variant configurations to test.
# Each variant defines what tools/context the agent has access to.
#
# Format: variant_name: { config }
#   baseline: {}                                     # no extra features
#   context_only: { context_files: [./path/to.md] }  # injects context files
#   mcp_only: { mcp_servers: [dart] }                # enables MCP servers
#   full: { context_files: [...], mcp_servers: [...] }
#
# Tasks can optionally restrict which variants they support
# via `allowed_variants:` in their task.yaml.
variants:
${variantsMap.toString().trimRight()}

# =============================================================================
# TASKS
# =============================================================================
# Which tasks to run and how. Uses paths for discovery and inline for overrides.
#
# Task discovery via glob patterns (relative to dataset root):
#   tasks:
#     paths: [tasks/*]
#
# Per-task overrides (keys must match directory names in tasks/):
#   tasks:
#     inline:
#       task_id:
#         include-samples: [sample1]   # Only run specific samples (mutually exclusive with exclude)
#         exclude-samples: [sample2]   # Skip specific samples (mutually exclusive with include)
#         system_message: |            # Override system prompt for this task
#           Custom instructions...
#
# Simple format (run all samples with job-level settings):
#   tasks:
#     inline:
#       task_id: {}
#
tasks:
  inline:
$tasksList
''';
}
