# dash_evals Style Guide

This style guide outlines the coding conventions and contribution requirements for the dash_evals repository.

---

## Documentation Requirements

All changes that affect user-facing behavior, configuration, or APIs **must** be documented in the `docs/` directory:

- **New features**: Add documentation explaining the feature and how to use it
- **CLI changes**: Update `docs/dataset_yaml_schema.md` (CLI Usage section)
- **Configuration changes**: Update `docs/dataset_yaml_schema.md` 
- **Workflow changes**: Update `docs/contributing_guide.md`
- **Architecture changes**: Update `docs/repository_structure.md`

When reviewing PRs, check that:
1. Any new CLI flags or options are documented
2. New configuration fields are documented with type, description, and examples
3. User-facing error messages are clear and actionable

---

## Python Style Guide

This project follows the [Google Python Style Guide](https://google.github.io/styleguide/pyguide.html).

### Key Points

- **Formatting**: Use `ruff format` for automatic formatting
- **Linting**: Use `ruff check` and `pylint` 
- **Line length**: 100 characters maximum
- **Docstrings**: Use Google-style docstrings with Args, Returns, and Raises sections
- **Type hints**: Required for all public functions and methods
- **Imports**: Use absolute imports, grouped by standard library / third-party / local

### Docstring Example

```python
def parse(dataset_path: Path, jobs: list[str] | None = None) -> list[EvalSetConfig]:
    """Parse dataset directory into resolved EvalSetConfig(s).

    Args:
        dataset_path: Path to dataset directory containing dataset.yaml.
        jobs: Optional list of job names or paths. Uses default_job if not specified.

    Returns:
        List of EvalSetConfig objects ready to pass to inspect_ai.eval_set().

    Raises:
        FileNotFoundError: If dataset or job file not found.
    """
```

---

## Dart Style Guide

This project follows the [Effective Dart Style Guide](https://dart.dev/effective-dart/style).

Code should follow the relevant style guides, and use the correct
auto-formatter, for each language, as described in
[the repository contributing guide's Style section](https://github.com/flutter/packages/blob/main/CONTRIBUTING.md#style).

### Best Practices

- Code should follow the guidance and principles described in
  [the flutter/packages contribution guide](https://github.com/flutter/flutter/blob/master/docs/ecosystem/contributing/README.md).
- Code should be tested. Changes to plugin packages, which include code written
  in C, C++, Java, Kotlin, Objective-C, or Swift, should have appropriate tests
  as described in [the plugin test guidance](https://github.com/flutter/flutter/blob/master/docs/ecosystem/testing/Plugin-Tests.md).
- PR descriptions should include the Pre-Review Checklist from
  [the PR template](https://github.com/flutter/packages/blob/main/.github/PULL_REQUEST_TEMPLATE.md),
  with all of the steps completed.

### Review Agent Guidelines

When providing a summary, the review agent must adhere to the following principles:
- **Be Objective:** Focus on a neutral, descriptive summary of the changes. Avoid subjective value judgments
  like "good," "bad," "positive," or "negative." The goal is to report what the code does, not to evaluate it.
- **Use Code as the Source of Truth:** Base all summaries on the code diff. Do not trust or rephrase the PR
  description, which may be outdated or inaccurate. A summary must reflect the actual changes in the code.
- **Be Concise:** Generate summaries that are brief and to the point. Focus on the most significant changes,
  and avoid unnecessary details or verbose explanations. This ensures the feedback is easy to scan and understand.

### YAML Configuration Files

- Use 2-space indentation
- Include comments explaining non-obvious fields
- Use explicit `path:` references for file paths (e.g., `- path: samples/file.yaml`)
