"""
Tests for utility modules: markdown extraction and YAML loading.
"""

from pathlib import Path

import pytest

from dash_evals.utils.markdown import extract_code_from_markdown


class TestExtractCodeFromMarkdown:
    """Tests for extract_code_from_markdown()."""

    def test_extract_dart_code_block(self):
        """Test extracting dart code from a language-specific block."""
        text = "Here's the code:\n```dart\nvoid main() {}\n```\nDone."
        result = extract_code_from_markdown(text, language="dart")
        assert result == "void main() {}"

    def test_extract_python_code_block(self):
        """Test extracting python code."""
        text = "```python\nprint('hello')\n```"
        result = extract_code_from_markdown(text, language="python")
        assert result == "print('hello')"

    def test_extract_generic_code_block(self):
        """Test extracting from a generic (no language) code block."""
        text = "```\nsome code\n```"
        result = extract_code_from_markdown(text)
        assert result == "some code"

    def test_no_code_block_returns_original(self):
        """Test that text without code blocks is returned as-is."""
        text = "Just some plain text without code blocks."
        result = extract_code_from_markdown(text)
        assert result == text

    def test_language_specific_fallback(self):
        """Test that dart block is found even when different language requested."""
        text = "```dart\nvoid main() {}\n```"
        # Requesting "python" but only dart block exists
        result = extract_code_from_markdown(text, language="python")
        # Should fallback to finding the dart block
        assert result == "void main() {}"

    def test_multiple_code_blocks_extracts_first(self):
        """Test that the first matching code block is extracted."""
        text = "```dart\nfirst()\n```\n\n```dart\nsecond()\n```"
        result = extract_code_from_markdown(text, language="dart")
        assert result == "first()"

    def test_multiline_code_block(self):
        """Test extracting multiline code."""
        text = """```dart
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
```"""
        result = extract_code_from_markdown(text, language="dart")
        assert "import 'package:flutter/material.dart';" in result
        assert "class MyApp" in result

    def test_code_block_with_surrounding_text(self):
        """Test extraction when code block is embedded in explanatory text."""
        text = (
            "Here is the solution:\n\n```dart\nvoid main() {}\n```\n\nThis creates a minimal app."
        )
        result = extract_code_from_markdown(text, language="dart")
        assert result == "void main() {}"
