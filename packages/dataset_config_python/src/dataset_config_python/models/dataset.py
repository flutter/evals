"""Dataset model — mirrors Inspect AI's Dataset/MemoryDataset."""

from __future__ import annotations

from typing import Any

from pydantic import BaseModel

from dataset_config_python.models.sample import Sample


class Dataset(BaseModel):
    """A named collection of samples, or a reference to a file-backed dataset.

    Supports three dataset formats:
    - ``format="memory"`` (default): inline samples via ``samples`` list.
    - ``format="json"``: loads via Inspect AI's ``json_dataset(source, **args)``.
    - ``format="csv"``: loads via Inspect AI's ``csv_dataset(source, **args)``.
    """

    samples: list[Sample] = []
    """The sample records (only used when format is 'memory')."""

    name: str = ""
    """Display name for the dataset."""

    location: str | None = None
    """Dataset location (file path or remote URL)."""

    shuffled: bool = False
    """Whether the dataset was shuffled after reading."""

    format: str = "memory"
    """Dataset format: 'memory' (inline samples), 'json', or 'csv'."""

    source: str | None = None
    """File path or URL for json/csv datasets."""

    args: dict[str, Any] | None = None
    """Extra kwargs passed to json_dataset() or csv_dataset()."""
