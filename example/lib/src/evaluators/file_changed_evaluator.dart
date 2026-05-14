import 'package:framework/framework.dart';
import 'package:evals_results/evals_results.dart';

/// Grades an eval by checking that the agent modified a specific file.
///
/// Reads [filePath] from the sandbox after the eval completes and compares
/// it to [originalContent]. If the file differs, the agent made a change.
///
/// ```dart
/// FileChangedEvaluator(
///   filePath: '/workspace/app/lib/sort.dart',
///   originalContent: '...the original source...',
/// )
/// ```
class FileChangedEvaluator extends Evaluator {
  /// Path inside the sandbox to check.
  final String filePath;

  /// The original (pre-eval) file content to compare against.
  final String originalContent;

  const FileChangedEvaluator({
    required this.filePath,
    required this.originalContent,
  });

  @override
  Future<Score> evaluate(EvalState state) async {
    final sandbox = state.context.sandbox;
    if (sandbox == null) {
      return Score.incorrect(
        explanation: 'No sandbox — cannot check file changes.',
      );
    }

    try {
      final currentContent = await sandbox.readFile(filePath);
      final changed = currentContent.trim() != originalContent.trim();

      return changed
          ? Score.correct(
              answer: 'modified',
              explanation: 'File $filePath was modified by the agent.',
            )
          : Score.incorrect(
              answer: 'unchanged',
              explanation: 'File $filePath was NOT modified — '
                  'agent did not edit the expected file.',
            );
    } catch (e) {
      return Score.error(
        explanation: 'Could not read $filePath from sandbox: $e',
      );
    }
  }
}
