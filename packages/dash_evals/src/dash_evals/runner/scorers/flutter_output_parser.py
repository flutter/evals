"""Parsers for Flutter command outputs."""

from dataclasses import dataclass


@dataclass
class AnalyzerResult:
    """Parsed flutter analyze output."""

    error_count: int
    warning_count: int
    info_count: int
    raw_output: str


@dataclass
class TestResult:
    """Parsed flutter test output."""

    passed: bool
    raw_output: str
    passed_count: int = 0
    failed_count: int = 0


def parse_analyzer_output(output: str) -> AnalyzerResult:
    """
    Parse flutter analyze output to count errors, warnings, and info messages.

    Args:
        output: Combined stdout and stderr from flutter analyze

    Returns:
        AnalyzerResult with counts and raw output

    Examples:
        >>> result = parse_analyzer_output("error • Something wrong\\nwarning • Be careful")
        >>> result.error_count
        1
        >>> result.warning_count
        1
    """
    output_lower = output.lower()
    error_count = output_lower.count("error •")
    warning_count = output_lower.count("warning •")
    info_count = output_lower.count("info •")

    return AnalyzerResult(
        error_count=error_count,
        warning_count=warning_count,
        info_count=info_count,
        raw_output=output,
    )


def parse_test_output(output: str, success: bool) -> TestResult:
    """
    Parse flutter test output to determine test results.

    Args:
        output: Combined stdout and stderr from flutter test
        success: Whether the test command succeeded

    Returns:
        TestResult with pass/fail status and raw output

    Examples:
        >>> result = parse_test_output("All tests passed!", success=True)
        >>> result.passed
        True
    """
    if success:
        return TestResult(passed=True, raw_output=output)

    # Parse test output to count passed/failed
    if "All tests passed" in output or "all tests passed" in output:
        return TestResult(passed=True, raw_output=output)
    elif "+0" in output or "No tests" in output:
        return TestResult(passed=False, passed_count=0, raw_output=output)
    else:
        # Partial credit for some passing tests
        # Try to extract counts from output like "+3 -2"
        passed_count = 0
        failed_count = 0

        # Look for patterns like "+3" and "-2"
        import re

        passed_match = re.search(r"\+(\d+)", output)
        failed_match = re.search(r"-(\d+)", output)

        if passed_match:
            passed_count = int(passed_match.group(1))
        if failed_match:
            failed_count = int(failed_match.group(1))

        return TestResult(
            passed=False,
            passed_count=passed_count,
            failed_count=failed_count,
            raw_output=output,
        )
