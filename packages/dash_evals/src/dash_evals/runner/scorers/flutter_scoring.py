"""Scoring utilities for Flutter code evaluation."""

from typing import Tuple

from dash_evals.runner.scorers.flutter_output_parser import AnalyzerResult, TestResult


def calculate_analyzer_score(result: AnalyzerResult) -> Tuple[float, str]:
    """
    Calculate score from analyzer results.

    Args:
        result: Parsed analyzer output

    Returns:
        Tuple of (score, explanation)

    Examples:
        >>> from dash_evals.utils.flutter_output_parser import AnalyzerResult, TestResult
        >>> result = AnalyzerResult(0, 0, 0, "")
        >>> score, explanation = calculate_analyzer_score(result)
        >>> score
        1.0
    """
    total_issues = result.error_count + result.warning_count + (result.info_count * 0.5)

    if total_issues == 0:
        return 1.0, "✓ No analyzer issues"
    elif total_issues <= 3:
        return (
            0.7,
            f"⚠ Minor issues: {result.error_count} errors, {result.warning_count} warnings",
        )
    else:
        return (
            0.3,
            f"✗ Multiple issues: {result.error_count} errors, {result.warning_count} warnings",
        )


def calculate_test_score(result: TestResult) -> Tuple[float, str]:
    """
    Calculate score from test results as a percentage of tests passed.

    Args:
        result: Parsed test output

    Returns:
        Tuple of (score, explanation) where score is the percentage of tests passed (0.0-1.0)

    Examples:
        >>> from dash_evals.parsers.flutter_output_parser import TestResult
        >>> result = TestResult(passed=True, raw_output="")
        >>> score, explanation = calculate_test_score(result)
        >>> score
        1.0
    """
    if result.passed:
        return 1.0, "✓ All tests passed"

    # Calculate percentage based on actual test counts
    total_tests = result.passed_count + result.failed_count

    if total_tests == 0:
        return 0.0, "✗ No tests found or executed"

    pass_rate = result.passed_count / total_tests

    if pass_rate == 1.0:
        return 1.0, f"✓ All tests passed ({result.passed_count}/{total_tests})"
    elif pass_rate == 0.0:
        return 0.0, f"✗ All tests failed (0/{total_tests})"
    else:
        return (
            pass_rate,
            f"⚠ {result.passed_count}/{total_tests} tests passed ({pass_rate:.0%})",
        )


def validate_code_structure(code: str, required_widgets: list) -> Tuple[float, str]:
    """
    Validate that code contains required structural elements.

    Args:
        code: The generated Dart code
        required_widgets: List of required widget names from metadata

    Returns:
        Tuple of (score, explanation)

    Examples:
        >>> code = "class MyApp extends StatelessWidget { MaterialApp() }"
        >>> score, explanation = validate_code_structure(code, ["TextField"])
        >>> score >= 0.7
        True
    """
    required_elements = []

    # Check for required widgets from target
    if "MyApp" in code:
        required_elements.append("MyApp class")
    if "StatefulWidget" in code or "StatelessWidget" in code:
        required_elements.append("Widget structure")
    if "MaterialApp" in code:
        required_elements.append("MaterialApp")

    # Check for specific requirements from metadata
    for widget in required_widgets:
        if widget in code:
            required_elements.append(widget)

    # Score based on required elements
    if len(required_elements) >= len(required_widgets) + 2:
        return 1.0, f"✓ Contains required elements: {', '.join(required_elements)}"
    elif len(required_elements) >= len(required_widgets):
        return 0.7, "⚠ Missing some elements"
    else:
        return 0.3, "✗ Missing required elements"


def calculate_final_score(
    analyzer_score: float,
    test_score: float,
    structure_score: float,
    weights: dict | None = None,
) -> float:
    """
    Calculate weighted final score.

    Args:
        analyzer_score: Code quality score (0.0-1.0)
        test_score: Test pass rate (0.0-1.0)
        structure_score: Code structure score (0.0-1.0)
        weights: Optional custom weights (default: {"analyzer": 0.3, "test": 0.5, "structure": 0.2})

    Returns:
        Weighted final score (0.0-1.0)

    Examples:
        >>> calculate_final_score(1.0, 1.0, 1.0)
        1.0
        >>> calculate_final_score(0.0, 1.0, 0.0)  # Test score is 50% of total
        0.5
    """
    if weights is None:
        weights = {"analyzer": 0.3, "test": 0.5, "structure": 0.2}

    return (
        analyzer_score * weights["analyzer"]
        + test_score * weights["test"]
        + structure_score * weights["structure"]
    )
