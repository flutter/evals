"""Utilities for working with markdown or text."""


def extract_code_from_markdown(text: str, language: str | None = None) -> str:
    """Extract code from markdown code blocks.

    Args:
        text: Text that may contain markdown code blocks.
        language: Optional language identifier (e.g., 'dart', 'python').

    Returns:
        Extracted code, or original text if no code blocks found.

    Example:
        >>> extract_code_from_markdown("```dart\\ncode\\n```")
        'code'
    """
    # Try language-specific code block first if language is provided
    if language:
        marker = f"```{language}"
        if marker in text:
            start = text.find(marker) + len(marker)
            end = text.find("```", start)
            if end != -1:
                return text[start:end].strip()

    # Try generic language-specific code blocks (e.g., ```dart, ```python)
    if "```" in text:
        # Look for language-specific blocks
        for lang in ["dart", "python", "javascript", "typescript", "java", "kotlin"]:
            marker = f"```{lang}"
            if marker in text:
                start = text.find(marker) + len(marker)
                end = text.find("```", start)
                if end != -1:
                    return text[start:end].strip()

        # Fall back to generic code block
        start = text.find("```") + 3
        end = text.find("```", start)
        if end != -1:
            return text[start:end].strip()

    return text
