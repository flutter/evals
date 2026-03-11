"""
Unit tests for flutter_code_execution task and related utilities.

Tests the pure functions that don't have side effects.
"""

import pytest

# Test Flutter parsers
from dash_evals.runner.scorers.flutter_output_parser import (
    AnalyzerResult,
    TestResult,
    parse_analyzer_output,
    parse_test_output,
)

# Test Flutter scoring
from dash_evals.runner.scorers.flutter_scoring import (
    calculate_analyzer_score,
    calculate_final_score,
    calculate_test_score,
    validate_code_structure,
)


class TestAnalyzerParsing:
    """Test analyzer output parsing."""

    def test_parse_analyzer_output_clean(self):
        """Test parsing output with no issues."""
        output = "Analyzing project...\nNo issues found!"
        result = parse_analyzer_output(output)

        assert result.error_count == 0
        assert result.warning_count == 0
        assert result.info_count == 0
        assert result.raw_output == output

    def test_parse_analyzer_output_with_issues(self):
        """Test parsing output with errors and warnings."""
        output = """
        error • The method 'foo' isn't defined
        warning • Unused import
        warning • Missing const
        info • Consider using final
        """
        result = parse_analyzer_output(output)

        assert result.error_count == 1
        assert result.warning_count == 2
        assert result.info_count == 1

    def test_calculate_analyzer_score_perfect(self):
        """Test score calculation with no issues."""
        result = AnalyzerResult(0, 0, 0, "")
        score, explanation = calculate_analyzer_score(result)
        assert score == 1.0
        assert "No analyzer issues" in explanation

    def test_calculate_analyzer_score_minor(self):
        """Test score calculation with minor issues."""
        result = AnalyzerResult(0, 2, 1, "")
        score, explanation = calculate_analyzer_score(result)
        assert score == 0.7
        assert "Minor issues" in explanation

    def test_calculate_analyzer_score_major(self):
        """Test score calculation with major issues."""
        result = AnalyzerResult(3, 5, 2, "")
        score, explanation = calculate_analyzer_score(result)
        assert score == 0.3
        assert "Multiple issues" in explanation


class TestTestParsing:
    """Test test output parsing."""

    def test_parse_test_output_success(self):
        """Test parsing successful test output."""
        output = "All tests passed!"
        result = parse_test_output(output, success=True)

        assert result.passed is True
        assert result.raw_output == output

    def test_parse_test_output_all_passed_in_output(self):
        """Test parsing when 'All tests passed' is in output."""
        output = "Running tests... All tests passed! (5 tests)"
        result = parse_test_output(output, success=False)

        assert result.passed is True

    def test_parse_test_output_no_tests(self):
        """Test parsing when no tests passed."""
        output = "+0 tests passed"
        result = parse_test_output(output, success=False)

        assert result.passed is False
        assert result.passed_count == 0

    def test_parse_test_output_partial(self):
        """Test parsing when some tests failed."""
        output = "+3 -2: Some tests failed"
        result = parse_test_output(output, success=False)

        assert result.passed is False
        assert result.passed_count == 3
        assert result.failed_count == 2

    def test_calculate_test_score_success(self):
        """Test score calculation for successful tests."""
        result = TestResult(passed=True, raw_output="")
        score, explanation = calculate_test_score(result)
        assert score == 1.0
        assert "All tests passed" in explanation

    def test_calculate_test_score_no_tests(self):
        """Test score calculation when no tests passed."""
        result = TestResult(passed=False, passed_count=0, raw_output="")
        score, explanation = calculate_test_score(result)
        assert score == 0.0
        assert "No tests found" in explanation

    def test_calculate_test_score_partial(self):
        """Test score calculation for partial success."""
        result = TestResult(passed=False, passed_count=3, failed_count=2, raw_output="")
        score, explanation = calculate_test_score(result)
        # 3 passed / 5 total = 0.6
        assert score == 0.6
        assert "3/5" in explanation


class TestCodeStructureValidation:
    """Test code structure validation."""

    def test_validate_code_structure_complete(self):
        """Test validation with all required elements."""
        code = """
        import 'package:flutter/material.dart';

        void main() => runApp(MyApp());

        class MyApp extends StatelessWidget {
          @override
          Widget build(BuildContext context) {
            return MaterialApp(
              home: Scaffold(
                body: TextField(),
              ),
            );
          }
        }
        """
        required_widgets = ["TextField"]
        score, explanation = validate_code_structure(code, required_widgets)

        assert score == 1.0
        assert "Contains required elements" in explanation
        assert "MyApp class" in explanation

    def test_validate_code_structure_partial(self):
        """Test validation with some missing elements."""
        code = """
        import 'package:flutter/material.dart';

        void main() => runApp(MyApp());

        class MyApp extends StatelessWidget {
          @override
          Widget build(BuildContext context) {
            return Container();
          }
        }
        """
        required_widgets = ["TextField"]
        score, explanation = validate_code_structure(code, required_widgets)

        # Has MyApp and StatelessWidget but missing MaterialApp and TextField
        assert score == 0.7
        assert "Missing some elements" in explanation

    def test_validate_code_structure_minimal(self):
        """Test validation with minimal code."""
        code = "void main() {}"
        required_widgets = ["TextField", "MaterialApp"]
        score, explanation = validate_code_structure(code, required_widgets)

        assert score == 0.3
        assert "Missing required elements" in explanation


class TestScoreCalculation:
    """Test final score calculation."""

    def test_calculate_final_score_perfect(self):
        """Test perfect score."""
        score = calculate_final_score(1.0, 1.0, 1.0)
        assert score == 1.0

    def test_calculate_final_score_weighted(self):
        """Test weighted score calculation."""
        # 30% analyzer (1.0) + 50% test (0.5) + 20% structure (1.0)
        score = calculate_final_score(1.0, 0.5, 1.0)
        expected = 0.3 * 1.0 + 0.5 * 0.5 + 0.2 * 1.0
        assert score == pytest.approx(expected)

    def test_calculate_final_score_zero(self):
        """Test zero score."""
        score = calculate_final_score(0.0, 0.0, 0.0)
        assert score == 0.0

    def test_calculate_final_score_test_heavy(self):
        """Test that test score is weighted most heavily."""
        # Test score is 50% of total
        score_high_test = calculate_final_score(0.0, 1.0, 0.0)
        score_high_analyzer = calculate_final_score(1.0, 0.0, 0.0)
        score_high_structure = calculate_final_score(0.0, 0.0, 1.0)

        assert score_high_test > score_high_analyzer
        assert score_high_test > score_high_structure

    def test_calculate_final_score_custom_weights(self):
        """Test custom weights."""
        weights = {"analyzer": 0.5, "test": 0.3, "structure": 0.2}
        score = calculate_final_score(1.0, 0.5, 1.0, weights=weights)
        expected = 0.5 * 1.0 + 0.3 * 0.5 + 0.2 * 1.0
        assert score == pytest.approx(expected)
