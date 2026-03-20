"""Tag-based filter for including/excluding items by their tags."""

from __future__ import annotations

from pydantic import BaseModel


class TagFilter(BaseModel):
    """Tag-based filter for including/excluding items."""

    include_tags: list[str] | None = None
    exclude_tags: list[str] | None = None


def matches_tag_filter(item_tags: list[str], tag_filter: TagFilter) -> bool:
    """Check whether a set of item_tags matches the given filter.

    Returns True if:
    - All include_tags (if any) are present in item_tags
    - No exclude_tags (if any) are present in item_tags
    """
    if tag_filter.include_tags and not all(
        t in item_tags for t in tag_filter.include_tags
    ):
        return False
    if tag_filter.exclude_tags and any(
        t in item_tags for t in tag_filter.exclude_tags
    ):
        return False
    return True
