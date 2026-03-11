import 'models/models.dart';

import 'parsers/yaml_parser.dart';
import 'resolvers/eval_set_resolver.dart';

/// Convenience facade that composes Parser → Resolver into a single call.
///
/// For finer-grained control, use [YamlParser], [JsonParser],
/// and [EvalSetResolver] directly.
class ConfigResolver {
  /// Resolve dataset + job(s) into [EvalSet] objects.
  ///
  /// [datasetPath] is the root directory containing `tasks/` and `jobs/`.
  /// [jobNames] are the job names (looked up in `jobs/`) or paths.
  List<EvalSet> resolve(String datasetPath, List<String> jobNames) {
    final parser = YamlParser();
    final resolver = EvalSetResolver();

    final taskConfigs = parser.parseTasks(datasetPath);
    final configs = <EvalSet>[];

    for (final jobName in jobNames) {
      final jobPath = findJobFile(datasetPath, jobName);
      final job = parser.parseJob(jobPath, datasetPath);
      configs.addAll(resolver.resolve(taskConfigs, job, datasetPath));
    }

    return configs;
  }
}
