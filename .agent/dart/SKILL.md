---
name: modern-dart
description: >
  Guidance for writing idiomatic, modern Dart code using the latest language features
  from Dart 3.x (through 3.11). Use this skill whenever you are writing, reviewing,
  or refactoring Dart or Flutter code. Always apply this skill when the user asks for
  Dart code, Flutter code, a Dart class/function/widget, or a code review. Encourages
  the use of patterns, records, sealed classes, switch expressions, extension types,
  dot shorthands, null-aware collection elements, and other Dart 3.x features instead
  of older, more verbose patterns. If the user says "use modern Dart", "idiomatic Dart",
  "latest Dart", or "Dart best practices", this skill is essential.
---

# Modern Dart

Current stable: **Dart 3.11** (November 2025). Always target the latest stable unless
the user has a specific version constraint.

---

## Core Dart 3.x Language Features

### 1. Records (Dart 3.0+)

Use records to return multiple values from a function without defining a class.

```dart
// ✅ Modern: record return type
(String name, int age) parseUser(Map<String, dynamic> json) =>
    (json['name'] as String, json['age'] as int);

final (name, age) = parseUser(data);

// ❌ Old: Map or ad-hoc class
Map<String, dynamic> parseUser(Map<String, dynamic> json) { ... }
```

Named record fields improve readability:

```dart
({String name, int age}) parseUser(Map<String, dynamic> json) =>
    (name: json['name'] as String, age: json['age'] as int);
```

### 2. Patterns & Destructuring (Dart 3.0+)

Use patterns for concise destructuring and validation.

```dart
// Destructure a record
final (x, y) = getCoords();

// Destructure a list
final [first, second, ...rest] = myList;

// Destructure a map / JSON
final {'name': String name, 'age': int age} = json;

// Object pattern
final Point(:x, :y) = point; // shorthand for Point(x: x, y: y)
```

**if-case**: validate and extract in one step:

```dart
if (response case {'status': 'ok', 'data': final data}) {
  process(data);
}
```

### 3. Switch Expressions & Exhaustive Matching (Dart 3.0+)

Prefer switch *expressions* (not statements) for concise value-returning logic:

```dart
// ✅ Switch expression
String label(Status s) => switch (s) {
  Status.active   => 'Active',
  Status.inactive => 'Inactive',
  Status.pending  => 'Pending',
};

// ❌ Old: verbose switch statement
String label(Status s) {
  switch (s) {
    case Status.active: return 'Active';
    // ...
  }
}
```

Use guards with `when`:

```dart
String describe(Shape shape) => switch (shape) {
  Circle(radius: var r) when r > 10 => 'Large circle',
  Circle()                          => 'Small circle',
  Square(side: var s)               => 'Square with side $s',
};
```

### 4. Sealed Classes (Dart 3.0+)

Use `sealed` for exhaustive ADTs (algebraic data types). The compiler enforces that all
subtypes are handled in switch expressions.

```dart
sealed class Result<T> {}
class Success<T> extends Result<T> { final T value; Success(this.value); }
class Failure<T> extends Result<T> { final String error; Failure(this.error); }

String message(Result<int> r) => switch (r) {
  Success(:final value) => 'Got $value',
  Failure(:final error) => 'Error: $error',
  // No default needed — compiler verifies exhaustiveness
};
```

Prefer `sealed` over `abstract` when you want to enumerate a closed set of subtypes.

### 5. Class Modifiers (Dart 3.0+)

Choose the right modifier:

| Modifier    | Can extend? | Can implement? | Can mix in? | Use when…                                  |
|-------------|-------------|----------------|-------------|--------------------------------------------|
| `base`      | ✅ (same pkg)| ❌             | ❌          | Enforce inheritance over implementation    |
| `interface` | ❌          | ✅             | ❌          | Pure contract, no inherited implementation |
| `final`     | ❌          | ❌             | ❌          | Lock hierarchy completely                  |
| `sealed`    | ✅ (same lib)| ✅ (same lib)  | ❌          | Exhaustive switch, closed hierarchy        |
| `mixin class`| ✅         | ✅             | ✅          | Reusable behavior mixed in                 |

### 6. Extension Types (Dart 3.3+)

Zero-cost wrappers to add type safety around primitives or existing types:

```dart
extension type Meters(double value) {
  Meters operator +(Meters other) => Meters(value + other.value);
  String get label => '${value}m';
}

Meters distance = Meters(5.0);
```

Use instead of `typedef` when you want type-level distinction with no runtime cost.

### 7. Dot Shorthands (Dart 3.10+)

Omit the type name when the compiler can infer it from context:

```dart
// ✅ Modern (Dart 3.10+)
Status status = .active;
int port = .parse('8080');
Alignment align = .center;

// In switches:
switch (color) {
  case .red: ...
  case .blue: ...
}

// ❌ Old
Status status = Status.active;
int port = int.parse('8080');
```

Works for: enum values, static methods, static getters, named constructors.
Does **not** work with `var` — the contextual type must be known.

### 8. Null-Aware Collection Elements (Dart 3.8+)

Conditionally include nullable values in collection literals with `?`:

```dart
String? maybeTag = getTag();
int? maybeCount = getCount();

// ✅ Modern
List<String> parts = [
  'header',
  ?maybeTag,       // included only if non-null
  'footer',
];

Map<String, int> data = {
  'base': 1,
  ?maybeTag: ?maybeCount,  // key and value only if both non-null
};

// ❌ Old
final parts = ['header', if (maybeTag != null) maybeTag!, 'footer'];
```

### 9. Wildcard Variables (Dart 3.7+)

Use `_` freely for multiple unused parameters — no collision:

```dart
// ✅ Modern
future.onError((_, _) => print('failed'));
var [_, second, _, fourth] = list;

// ❌ Old — awkward workarounds
future.onError((_, __) => print('failed'));
```

### 10. Digit Separators (Dart 3.6+)

Improve readability of large number literals:

```dart
const bytesPerGigabyte = 1_000_000_000;
const hexColor = 0xFF_A0_B0_C0;
const pi = 3.141_592_653_589;
```

---

## Patterns to Prefer

### Null safety — leverage the type system

```dart
// ✅ Prefer null-aware access and promotion
String? name;
final upper = name?.toUpperCase() ?? 'UNKNOWN';

// Promote inside a block
if (name != null) print(name.length); // name is String here

// Late initialization
late final String config = loadConfig();
```

### Extensions over utility functions

```dart
// ✅
extension StringX on String {
  bool get isEmail => contains('@');
}

// ❌
bool isEmail(String s) => s.contains('@');
```

### Enums with members

```dart
enum Direction {
  north, south, east, west;

  Direction get opposite => switch (this) {
    Direction.north => Direction.south,
    Direction.south => Direction.north,
    Direction.east  => Direction.west,
    Direction.west  => Direction.east,
  };
}
```

### Async/await and Streams

Always `await` Futures; prefer `async*`/`yield` for custom streams:

```dart
Stream<int> countdown(int from) async* {
  for (var i = from; i >= 0; i--) {
    yield i;
    await Future.delayed(Duration(seconds: 1));
  }
}
```

---

## Tooling & Style

- **Formatter**: Use `dart format` (Dart 3.7+ uses the new "tall" style automatically).
  Run `dart pub get` before formatting to ensure language version detection is correct.
- **Linter**: Enable `lints` or `flutter_lints` package. Run `dart analyze` regularly.
- **`dart fix`**: Use `dart fix --apply` to apply bulk automated fixes.
- **SDK constraint**: Keep your `pubspec.yaml` SDK lower bound up to date to unlock
  language features (e.g., `sdk: '^3.10.0'` for dot shorthands).

---

## Anti-Patterns to Avoid

| Avoid                                   | Prefer                                   |
|-----------------------------------------|------------------------------------------|
| `dynamic` unless absolutely necessary  | Typed generics or `Object?`             |
| `var map = {}` for JSON bags            | Records or typed classes                |
| Long switch *statements* returning values | Switch *expressions*                  |
| `abstract class` for closed hierarchies | `sealed class`                          |
| `typedef` for type aliases with behavior | `extension type`                        |
| `_, __, ___` for unused params          | `_, _` (wildcard variables)             |
| Conditional `list.add(x)` inside `if`  | `?x` null-aware element in literal      |
| Calling `.runtimeType` for type checks  | Pattern matching / `is` checks          |

---

## When in Doubt, Consult the Docs

- Language tour: https://dart.dev/language
- What's new: https://dart.dev/resources/whats-new
- Language evolution: https://dart.dev/resources/language/evolution
- Effective Dart: https://dart.dev/effective-dart
- Changelog: https://dart.dev/changelog

Always check if there's a newer Dart feature that makes your code simpler before
reaching for a workaround or a third-party package.