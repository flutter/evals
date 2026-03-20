# evals

> [!CAUTION]
> This repo is _highly unstable_ and the APIs _will_ change. 

Evaluation framework for testing AI agents' ability to write Dart and Flutter code. Built on [Inspect AI](https://inspect.aisi.org.uk/).

## Overview

This repo includes

- **eval runner** — Python package for running LLM evaluations with configurable tasks, variants, and models
- **config packages** — Dart and Python packages that resolve dataset YAML into EvalSet JSON for the runner
- **devals CLI** — Dart CLI for creating and managing dataset samples, tasks, and jobs
- **Evaluation Explorer** — Dart/Flutter app for browsing and analyzing results

> [!TIP]
> Full documentation at [dash-evals-docs.web.app/](https://evals-docs.web.app/)

## Packages

| Package | Description | Docs |
|---------|-------------|------|
| [dash_evals](packages/dash_evals/) | Python evaluation runner using Inspect AI | [dash_evals docs](docs/contributing/packages/dash_evals.md) |
| [dataset_config_dart](packages/dataset_config_dart/) | Dart library for resolving dataset YAML into EvalSet JSON (includes shared data models) | [dataset_config_dart docs](docs/contributing/packages/dataset_config_dart.md) |
| [dataset_config_python](packages/dataset_config_python/) | Python configuration models | — |
| [devals_cli](packages/devals_cli/) | Dart CLI for managing evaluation tasks and jobs | [CLI docs](docs/reference/cli.md) |
| [eval_explorer](packages/eval_explorer/) | Dart/Flutter reporting app | [eval_explorer docs](docs/contributing/packages/eval_explorer.md) |

## Documentation

| Doc | Description |
|-----|-------------|
| [Quick Start](docs/guides/quick_start.md) | Get started authoring your own evals |
| [Contributing Guide](docs/contributing/guide.md) | Development setup and guidelines |
| [CLI Reference](docs/reference/cli.md) | Full devals CLI command reference |
| [Configuration Reference](docs/reference/configuration_reference.md) | YAML configuration file reference |
| [Repository Structure](docs/contributing/repository_structure.md) | Project layout |
| [Glossary](docs/reference/glossary.md) | Terminology guide |

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for details, or go directly to the [Contributing Guide](docs/contributing/guide.md).

## License

See [LICENSE](LICENSE) for details.
