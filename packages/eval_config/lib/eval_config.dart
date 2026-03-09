/// Core library for resolving eval dataset YAML into EvalSet JSON.
///
/// This package contains the business logic for:
/// - Parsing task and job YAML files (or pre-parsed JSON maps)
/// - Resolving configs (models, sandboxes, variants)
/// - Writing EvalSet JSON for the Python runner
///
/// It is frontend-agnostic — both the CLI and a future web interface
/// can use this library.
///
/// ## Quick start
///
/// Use [ConfigResolver] for a single-call convenience facade:
///
/// ```dart
/// final resolver = ConfigResolver();
/// final configs = resolver.resolve(datasetPath, ['my_job']);
/// ```
///
/// ## Layered API
///
/// For finer-grained control, use the individual layers:
///
/// 1. **Parsers** — [YamlParser], [JsonParser]
/// 2. **Resolvers** — [EvalSetResolver]
/// 3. **Writers** — [EvalSetWriter]
library;

// Facade
export 'src/config_resolver.dart';

// Parsers
export 'src/parsers/parser.dart';
export 'src/parsers/yaml_parser.dart';
export 'src/parsers/json_parser.dart';

// Resolvers
export 'src/resolvers/eval_set_resolver.dart';

// Internal types (used by Parser/Resolver API)
export 'src/parsed_task.dart';

// Writers
export 'src/writers/eval_set_writer.dart';

// Supporting
export 'src/runner_config_exception.dart';
export 'src/utils/yaml_utils.dart';

// Models (merged from the former `models` package)
export 'src/models/models.dart';
