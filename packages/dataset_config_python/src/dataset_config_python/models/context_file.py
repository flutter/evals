"""Context file model — parsed YAML frontmatter + content."""

from __future__ import annotations

import os

import yaml
from pydantic import BaseModel


class ContextFileMetadata(BaseModel):
    """Metadata parsed from a context file's YAML frontmatter."""

    title: str
    version: str
    description: str
    dart_version: str | None = None
    flutter_version: str | None = None
    updated: str | None = None


class ContextFile(BaseModel):
    """A context file with parsed YAML frontmatter and markdown content."""

    metadata: ContextFileMetadata
    """Parsed frontmatter metadata."""

    content: str
    """File content after the frontmatter section."""

    file_path: str
    """Absolute path to the context file on disk."""

    @staticmethod
    def load(file_path: str) -> ContextFile:
        """Load a context file from disk, parsing its YAML frontmatter.

        The file must begin with ``---`` and contain valid YAML frontmatter
        followed by a closing ``---`` delimiter.
        """
        if not os.path.isfile(file_path):
            raise FileNotFoundError(f"Context file not found: {file_path}")

        with open(file_path) as f:
            text = f.read()

        if not text.startswith("---"):
            raise ValueError(f"Context file must have YAML frontmatter: {file_path}")

        parts = text.split("---")
        if len(parts) < 3:
            raise ValueError(f"Invalid frontmatter in {file_path}")

        # parts[0] is empty (before first ---), parts[1] is frontmatter,
        # parts[2..] is content (rejoin in case content contains ---)
        yaml_content = yaml.safe_load(parts[1])
        content = "---".join(parts[2:]).strip()

        metadata = ContextFileMetadata(
            title=yaml_content["title"],
            version=str(yaml_content["version"]),
            description=yaml_content["description"],
            dart_version=str(yaml_content["dart_version"]) if "dart_version" in yaml_content else None,
            flutter_version=str(yaml_content["flutter_version"]) if "flutter_version" in yaml_content else None,
            updated=str(yaml_content["updated"]) if "updated" in yaml_content else None,
        )

        return ContextFile(
            metadata=metadata,
            content=content,
            file_path=file_path,
        )
