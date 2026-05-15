/// Default prompt templates for [ModelGradedEvaluator].
///
/// The default grading prompt for QA-style evaluation.
///
/// Template variables:
/// - `{question}` — the original eval input
/// - `{target}` — the expected answer (if any)
/// - `{answer}` — the model's actual output
/// - `{rubric}` — the grading rubric (instructions for the judge)
const String defaultGradingTemplate = '''
You are an expert evaluator. Your job is to grade an AI assistant's answer
to a question.

## Question
{question}

## Expected Answer
{target}

## AI Assistant's Answer
{answer}

## Grading Rubric
{rubric}

## Instructions
Evaluate the AI assistant's answer against the rubric. Consider:
- Correctness: Does the answer achieve what was asked?
- Completeness: Does it address all parts of the question?
- Quality: Is the approach sound and well-reasoned?

Respond with EXACTLY one of the following grades, followed by a brief
explanation:

- GRADE: C — Correct. The answer satisfies the rubric.
- GRADE: P — Partial. The answer partially satisfies the rubric.
- GRADE: I — Incorrect. The answer does not satisfy the rubric.

Your response MUST start with "GRADE: " followed by C, P, or I.
Then provide your explanation on the following lines.
''';

/// A grading prompt focused on factual verification.
///
/// Use when the target is a specific fact and you want to check
/// whether the model's output contains or implies that fact.
const String factCheckTemplate = '''
You are a fact-checking evaluator. Determine whether the AI assistant's
response contains or correctly implies the target fact.

## Target Fact
{target}

## AI Assistant's Response
{answer}

## Additional Criteria
{rubric}

## Instructions
Determine whether the response contains the target fact.

- The fact does not need to be stated verbatim — semantic equivalence counts.
- Ignore formatting, casing, and minor phrasing differences.
- If the response contradicts the target fact, grade as Incorrect.

Respond with EXACTLY one of the following:

- GRADE: C — The response contains or correctly implies the target fact.
- GRADE: I — The response does not contain the target fact, or contradicts it.

Your response MUST start with "GRADE: " followed by C or I.
Then provide your explanation.
''';

/// A grading prompt for code quality evaluation.
///
/// Designed for evaluating Dart/Flutter code output.
const String codeQualityTemplate = '''
You are a senior Dart/Flutter developer reviewing code produced by an
AI assistant. Evaluate the code quality.

## Task Description
{question}

## Expected Behavior
{target}

## Code Produced
{answer}

## Evaluation Criteria
{rubric}

## Instructions
Evaluate the code against the criteria. Consider:
- Correctness: Does the code achieve the intended behavior?
- Dart idioms: Does it use Dart conventions (null safety, naming, etc.)?
- Readability: Is the code clean and well-structured?
- Completeness: Are edge cases handled? Are imports correct?

Respond with EXACTLY one of the following grades:

- GRADE: C — High quality. The code is correct and idiomatic.
- GRADE: P — Acceptable. The code works but has quality issues.
- GRADE: I — Poor quality. The code has significant issues or is incorrect.

Your response MUST start with "GRADE: " followed by C, P, or I.
Then explain your assessment.
''';

/// Fills a prompt template by replacing `{variable}` placeholders.
///
/// Any placeholder not present in [variables] is left as-is.
String fillTemplate(String template, Map<String, String> variables) {
  var result = template;
  for (final MapEntry(:key, :value) in variables.entries) {
    result = result.replaceAll('{$key}', value);
  }
  return result;
}
