"""Dataset model — mirrors Inspect AI's Dataset/MemoryDataset."""

from __future__ import annotations

from pydantic import BaseModel

from dataset_config_python.models.sample import Sample


class Dataset(BaseModel):
    """A named collection of samples."""

    samples: list[Sample] = []
    """The sample records in this dataset."""

    name: str = ""
    """Display name for the dataset."""
