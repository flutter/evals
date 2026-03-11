"""Dart static analysis scorer.

Reusable scorer that runs ``dart analyze`` on auto-discovered project roots
and scores based on output.
"""

import os

from inspect_ai.scorer import CORRECT, INCORRECT, Score, Scorer, Target, accuracy, scorer
from inspect_ai.solver import TaskState
from inspect_ai.util import sandbox


@scorer(metrics=[accuracy()])
def dart_analyze_scorer(strict: bool = False, project_dir: str | None = None) -> Scorer:
    """
    Score based on dart static analysis results.

    Scoping behavior (in priority order):

    1. If ``project_dir`` argument is set, analyze only that subdirectory.
    2. If ``state.metadata["project_dir"]`` exists, use that.
    3. Fall back to auto-discovering all ``pubspec.yaml`` files.

    Scores:
    - CORRECT if no errors in any project (and no warnings if strict=True)
    - INCORRECT if any project has errors

    Args:
        strict: If True, also fail on warnings. Default False (only errors fail).
        project_dir: Optional subdirectory to scope analysis to.
                     Relative to the workspace root.

    Returns:
        A Scorer that evaluates Dart code quality via static analysis.
    """

    async def score(state: TaskState, target: Target) -> Score:
        sb = sandbox()
        workspace = state.metadata.get("workspace")

        if not workspace:
            return Score(
                value=INCORRECT,
                explanation="No workspace found - setup may have failed",
            )

        # Determine target project directory(ies)
        scope = project_dir or state.metadata.get("project_dir")  # noqa: F823

        if scope:
            # Scoped to a specific project subdirectory
            project_dirs = [scope]
        else:
            # Discover all Dart/Flutter projects by finding pubspec.yaml files
            find_result = await sb.exec(
                ["find", ".", "-name", "pubspec.yaml", "-not", "-path", "*/.*"],
                cwd=workspace,
                timeout=30,
            )

            pubspec_paths = [
                p.strip() for p in (find_result.stdout or "").splitlines() if p.strip()
            ]

            if not pubspec_paths:
                # Fallback: try analyzing workspace root directly
                pubspec_paths = ["."]

            # Derive project directories from pubspec.yaml paths
            project_dirs = sorted({os.path.dirname(p) or "." for p in pubspec_paths})

        # Run dart analyze in each project directory
        all_outputs: list[str] = []
        has_errors = False
        has_warnings = False

        for proj_dir in project_dirs:
            project_cwd = os.path.join(workspace, proj_dir)

            args = ["dart", "analyze", "."]
            if strict:
                args.append("--fatal-infos")

            result = await sb.exec(args, cwd=project_cwd, timeout=60)

            stdout = result.stdout or ""
            stderr = result.stderr or ""
            output = stdout + stderr

            # Tag output with the project directory for clarity
            labeled = f"[{proj_dir}] {output.strip()}"
            all_outputs.append(labeled)

            if "error •" in output.lower() or result.returncode != 0:
                has_errors = True
            if "warning •" in output.lower():
                has_warnings = True

        combined = "\n\n".join(all_outputs)

        if has_errors:
            return Score(
                value=INCORRECT,
                explanation=f"Static analysis failed:\n{combined[:2000]}",
                metadata={
                    "analyze_output": combined,
                    "projects_analyzed": project_dirs,
                },
            )

        if strict and has_warnings:
            return Score(
                value=INCORRECT,
                explanation=f"Static analysis has warnings (strict mode):\n{combined[:2000]}",
                metadata={
                    "analyze_output": combined,
                    "projects_analyzed": project_dirs,
                },
            )

        # Count info-level issues across all projects
        info_count = combined.lower().count("info •")

        return Score(
            value=CORRECT,
            explanation=f"Static analysis passed across {len(project_dirs)} project(s) "
            f"({info_count} info-level issues)",
            metadata={
                "analyze_output": combined,
                "info_count": info_count,
                "projects_analyzed": project_dirs,
            },
        )

    return score
