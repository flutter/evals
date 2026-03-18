/// Template for the starter task created by `devals init`.
///
/// Creates a task.yaml at tasks/get_started/task.yaml that points at
/// the parent project via files.
String initTaskTemplate() {
  return '''
# =============================================================================
# Starter Task
# =============================================================================
# This task copies your project root into the sandbox and runs a simple
# codebase analysis evaluation.

func: analyze_codebase

# Files: copies the project root into /workspace in the sandbox
files:
  /workspace: ../../
setup: "cd /workspace && flutter pub get"

samples:
  inline:
    - id: get_started
      difficulty: easy
      tags: []
      # Input: The prompt given to the model
      input: |
        Explore this codebase and suggest one improvement
        to the code quality, readability, or architecture.
      # Target: Expected output or grading criteria
      target: |
        The suggestion should be specific, actionable, and reference
        actual code in the project. It should explain why the change
        improves the codebase.
''';
}
