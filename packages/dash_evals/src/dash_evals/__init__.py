"""dash_evals - Evaluation framework for Dart and Flutter AI assistants.

This package provides tools for running evaluations using Inspect AI
to measure model performance on Dart/Flutter tasks.

Configuration is resolved by the Dart CLI (devals) and emitted as JSONL
datasets + a run manifest. The Python package reads the manifest and
calls eval_set() directly.

Main entry point:
    run-evals --manifest <path-to-manifest>
"""
