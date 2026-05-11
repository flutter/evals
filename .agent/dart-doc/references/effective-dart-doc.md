# Effective Dart: Documentation Reference

A condensed reference of the official Effective Dart documentation rules. Source: https://dart.dev/effective-dart/documentation

---

## Doc Comment Basics

### DO use `///` for all documentation
Always use triple-slash `///` style — never `/** ... */` JavaDoc style.

```dart
// GOOD
/// The number of items in the list.
int get length => ...

// BAD
/** The number of items in the list. */
int get length => ...
```

### PREFER writing doc comments for public APIs
Every public class, function, method, field, enum, typedef, and extension should have a doc comment. Private members can have doc comments too, especially if they're complex.

### DO start with a single-sentence summary
The first line should be a self-contained summary sentence, ending with a period. A sentence fragment is fine.

```dart
/// Deletes the file at [path] from the file system.
void delete(String path) { ... }
```

### DO separate the first sentence with a blank `///` line
If there's more to say, add a blank doc comment line after the summary to create a separate paragraph. dart doc uses the first paragraph as a short summary in indexes.

```dart
/// Deletes the file at [path].
///
/// Throws an [IOError] if the file could not be found. Throws a
/// [PermissionError] if the file is present but could not be deleted.
void delete(String path) { ... }
```

---

## Documentation by Member Type

### Functions and Methods (side-effect focus)
Start with a **third-person verb** when the main purpose is a side effect.

```dart
/// Saves the current state to disk.
void save() { ... }

/// Starts the stopwatch if not already running.
void start() { ... }
```

### Functions and Methods (return-value focus)
Start with a **noun phrase or non-imperative verb phrase** when returning a value is the main purpose.

```dart
/// The number of seconds since the epoch.
int get timestamp => ...

/// A [List] of the items currently selected.
List<Item> get selectedItems => ...
```

### Properties and Fields (non-boolean)
Start with a **noun phrase** describing what the property *is*.

```dart
/// The currently active theme color.
Color get primaryColor => ...

/// The number of pending requests.
int pendingCount = 0;
```

### Properties and Fields (boolean)
Start with **"Whether"** followed by a noun or gerund phrase.

```dart
/// Whether the connection is currently open.
bool get isConnected => ...

/// Whether this widget should be excluded from the semantics tree.
bool excludeFromSemantics = false;
```

### Classes, Enums, Typedefs, Extensions
Start with a **noun phrase** describing what the type *is*.

```dart
/// A paginated result set returned by a query.
class QueryResults { ... }

/// The available brightness modes for the display.
enum Brightness { light, dark }
```

### Constructors
Describe what the constructor creates or configures. Skip documenting parameters unless they need non-obvious explanation — the parameter names and types are visible in the signature.

```dart
/// Creates a button with the given [label] and [onPressed] callback.
const MyButton({required this.label, this.onPressed});
```

### Getters and Setters
**Document only the getter**, not both. The setter's doc is implied.

```dart
/// The current volume level, from 0.0 to 1.0.
double get volume => _volume;
set volume(double value) => _volume = value.clamp(0.0, 1.0);
```

### Library-Level Comments
Place a doc comment **before** the `library` directive. Include:
- A one-sentence summary
- Terminology explanations
- At least one complete code sample
- Links to the most important classes/functions

```dart
/// Support for client-side HTTP requests.
///
/// This library provides [HttpClient] for making HTTP requests and
/// [HttpResponse] for handling responses.
///
/// ```dart
/// final client = HttpClient();
/// final response = await client.get(Uri.parse('https://example.com'));
/// print(response.statusCode);
/// ```
///
/// See also:
///
///  * [HttpClient], the main entry point for making requests.
library;
```

---

## Cross-References and Formatting

### DO use `[SymbolName]` for in-scope identifiers
Use square brackets to cross-reference types, methods, functions, and parameters. dart doc turns these into hyperlinks.

```dart
/// Throws [ArgumentError] if [value] is negative.
/// See also [clamp] for a non-throwing alternative.
```

### DO use prose for parameters, return values, and exceptions
Don't use `@param`, `@returns`, or `@throws` tags. Explain them in sentences using `[paramName]` references.

```dart
/// Divides [numerator] by [denominator].
///
/// Returns the quotient as a [double]. Throws [ArgumentError] if
/// [denominator] is zero.
double divide(int numerator, int denominator) { ... }
```

### DO put doc comments before metadata annotations

```dart
// GOOD
/// A widget that displays an image.
@immutable
class ImageWidget extends StatelessWidget { ... }

// BAD
@immutable
/// A widget that displays an image.
class ImageWidget extends StatelessWidget { ... }
```

### CONSIDER including code samples
Include a `dart` fenced code block when it significantly aids understanding.

```dart
/// Parses a date string in ISO 8601 format.
///
/// ```dart
/// final date = parseDate('2024-01-15');
/// print(date.year); // 2024
/// ```
DateTime parseDate(String input) { ... }
```

### AVOID redundancy with the declaration
Don't restate what the signature already says. Add information the reader doesn't already have.

```dart
// BAD — tells us nothing new
/// Returns a string representation of this widget.
@override
String toString() => ...

// GOOD — or just omit it if there's truly nothing to add
```

---

## Markdown in Doc Comments

- Use standard markdown (headers, lists, bold, code blocks)
- AVOID excessive markdown — don't use it for visual decoration
- AVOID HTML for formatting
- PREFER `` ``` `` fenced code blocks over indented code blocks
- AVOID markdown in the first sentence summary

---

## Writing Style

- **PREFER brevity** — say as much as needed, no more
- **AVOID abbreviations** unless they're universally known
- **PREFER "this"** over "the" when referring to the current object ("this widget", "this list")
- Omit doc comments that add no value over the declaration itself — silence is better than noise
