---
name: dart-doc
description: Document Dart and Flutter code by writing or improving dartdoc inline comments (`///`) and package/library-level documentation (README, library directives). Use this skill whenever the user wants to document Dart or Flutter code, add doc comments, write API docs, generate dartdoc, document a class, function, method, file, package, or library, or improve existing Dart documentation. Also trigger for requests like "add docs", "write comments", "document this code", or "add dartdoc" when Dart or Flutter files are involved.
---

# Dart Documentation Skill

This skill guides you in writing high-quality documentation for Dart and Flutter projects. It covers three layers:

1. **Inline doc comments** — `///` comments on classes, functions, methods, fields, and typedefs
2. **Library-level docs** — `library` directive comments and the main package entry file
3. **Package-level prose** — `README.md`, usage guides, and other Markdown documentation

Follow Effective Dart conventions + Flutter's extended dartdoc tags throughout. Reference files:
- `references/effective-dart-doc.md` — Effective Dart documentation rules (read when writing any doc comments)
- `references/flutter-dartdoc-tags.md` — Flutter-specific dartdoc tags like `{@template}`, `{@macro}`, `{@tool}` (read when working on Flutter code or widget documentation)

---

## Workflow

### Step 1: Understand the Scope

Ask or infer from context:
- Is this a Dart-only package or a Flutter package/app?
- What is the entry point? (typically `lib/<package_name>.dart`)
- Are we documenting the whole project, a single file, or a specific symbol?

If the user says "document the project" or similar, treat it as full-project scope: cover the entry file → individual files → public symbols.

### Step 2: Audit Existing Docs

Before writing anything, scan the target files to understand what's already documented and what's missing. Look for:
- Public classes, enums, typedefs, extensions without `///` doc comments
- Methods/functions/getters/setters with missing or thin docs
- Missing `library` directive on the package entry file
- Absent or outdated `README.md`

Use this audit to decide what to write first (start with the most user-facing public API).

### Step 3: Write Documentation

Work top-down: package README → library comment → classes → members.

**Priority order:**
1. Public API (classes, top-level functions, enums)
2. Constructors and important methods
3. Fields and properties
4. Private members (if complex enough to benefit from a comment)

See `references/effective-dart-doc.md` for the exact rules at each level.

For Flutter projects, read `references/flutter-dartdoc-tags.md` before documenting widgets or shared Widget sub-trees.

**When writing inline docs:**
- Edit the source `.dart` files directly using the file editing tools
- Place `///` comments immediately before the declaration (and before any `@` metadata annotations)
- Never use `/** ... */` JavaDoc style

**When writing README or library docs:**
- Edit `README.md` at the package root directly
- Library-level docs go before the `library;` directive (or `library name;`) at the top of `lib/<package>.dart`

### Step 4: Add a `library` Directive (if missing)

If the package entry file (`lib/<package>.dart`) doesn't have a `library` directive, add one with a doc comment:

```dart
/// Brief description of what this library provides.
///
/// Longer explanation including terminology, main concepts,
/// and links to key classes. Example:
///
/// ```dart
/// import 'package:<package>/<package>.dart';
///
/// final result = MyClass().doSomething();
/// ```
///
/// See also:
///
///  * [MyClass], the main entry point for most use cases.
library;
```

### Step 5: Write or Update README.md

A good README includes:
1. **One-line tagline** — what the package does
2. **Features** — bullet list of capabilities
3. **Getting started** — how to install/import
4. **Usage** — at least one complete code example
5. **Additional information** — links to API docs, contributing, license

Keep it practical and focused on helping a new user get up and running in under 5 minutes.

### Step 6: Verify

After writing, scan for:
- Dangling `[references]` that don't correspond to real types/functions in scope
- Doc comments that just restate the function name (add value or omit)
- Missing periods at the end of the first sentence
- Any public symbol without a `///` comment

---

## Key Rules to Always Follow

These are the most important Effective Dart conventions. The full rules are in `references/effective-dart-doc.md`.

- **First sentence is a self-contained summary**, ending with a period. One blank `///` line separates it from the rest.
- **Use `[SymbolName]`** to cross-reference classes, methods, and identifiers. Private symbols like `[_helper]` can be referenced within the same file — useful for linking a public method to the private helpers it delegates to.
- **Describe what, not how.** Explain the result/behavior from the caller's perspective.
- **Third-person verbs for side-effect methods** ("Saves the file." not "Save the file.")
- **Noun phrases for properties** ("The number of items." not "Gets the number of items.")
- **"Whether" for booleans** ("Whether the stream is closed.")
- **Prose for parameters, return values, exceptions** — don't use `@param` or `@returns` tags; weave them into sentences using `[paramName]`.
- **Document only the getter, not both getter and setter**, when a property has both.
- **Put doc comments before metadata annotations.**
- **`@override` members** — omit the doc comment to inherit the superclass's documentation if the behavior is identical. Only add `///` if this override meaningfully diverges from the parent contract.

---

## Example: Well-Documented Class

```dart
/// A paginated list of results returned by a search query.
///
/// Use [SearchResults.empty] to create an empty result set, or
/// construct one from raw [items].
///
/// ```dart
/// final results = SearchResults(items: hits, totalCount: 42);
/// print(results.hasMore); // true
/// ```
///
/// See also:
///
///  * [SearchClient.search], which returns this type.
class SearchResults {
  /// Creates a result set from [items] with a given [totalCount].
  const SearchResults({
    required this.items,
    required this.totalCount,
  });

  /// An empty result set with zero items.
  static const SearchResults empty = SearchResults(items: [], totalCount: 0);

  /// The items in this page of results.
  final List<SearchHit> items;

  /// The total number of results across all pages.
  final int totalCount;

  /// Whether there are more pages of results beyond this one.
  bool get hasMore => items.length < totalCount;
}
```
