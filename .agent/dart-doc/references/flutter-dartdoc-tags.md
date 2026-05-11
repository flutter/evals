# Flutter dartdoc Tags Reference

Flutter's `dartdoc` tool supports a set of extended tags beyond standard Dart doc comments. These are primarily used in the Flutter framework itself and in packages that want to reuse documentation snippets across many symbols.

Use these tags when documenting Flutter widgets, framework classes, or any code that benefits from shared documentation blocks.

---

## `{@template name}` and `{@macro name}`

Define a reusable documentation block once and reference it from multiple places.

**Define a template** (typically in the class or library that "owns" the concept):

```dart
/// {@template my_package.my_class.some_concept}
/// This text will be reused wherever the macro is referenced.
///
/// It can span multiple lines and include markdown.
/// {@endtemplate}
class MyClass { ... }
```

**Reference it elsewhere** with `{@macro}`:

```dart
/// Creates a [MyClass].
///
/// {@macro my_package.my_class.some_concept}
const MyClass();
```

**Naming convention**: Use `package_name.class_name.concept` as the template name to avoid collisions. Flutter uses names like `flutter.widgets.GestureDetector.onTap`.

**When to use**: When many constructors, subclasses, or overriding methods share a large block of common documentation (e.g., a widget's behavior description shared across constructor variants).

---

## `{@tool}` ... `{@end-tool}`

Embed an interactive tool or code sample viewer. Used in the Flutter framework to include DartPad-runnable examples.

```dart
/// A full example of using this widget:
///
/// {@tool dartpad}
/// ** See code in examples/api/lib/widgets/my_widget/my_widget.0.dart **
/// {@end-tool}
class MyWidget extends StatelessWidget { ... }
```

The tool name (`dartpad`, `snippet`, `sample`) determines how the sample is rendered on api.flutter.dev.

**When to use**: When documenting a Flutter package that will be published and you have runnable example files. For most internal projects, a regular ` ```dart ``` ` code block is sufficient.

---

## `{@animation width height url}`

Embed an animation into the documentation page.

```dart
/// {@animation 464 192 https://flutter.github.io/assets-for-api-docs/assets/widgets/curve.mp4}
```

**When to use**: Only when documenting visual effects that benefit from seeing the animation. Requires a hosted video URL.

---

## `{@youtube width height url}`

Embed a YouTube video.

```dart
/// {@youtube 560 315 https://www.youtube.com/watch?v=...}
```

---

## `{@inject-html}` ... `{@end-inject-html}`

Injects raw HTML into the generated documentation page. Use sparingly — only when markdown is genuinely insufficient.

---

## Widget Documentation Conventions

When documenting Flutter widgets, follow these additional conventions used consistently in the Flutter framework:

### Class-level comment structure
```dart
/// A [StatelessWidget] that displays a [message] in a styled callout box.
///
/// Use this widget to draw attention to important information. For a
/// dismissible variant, see [DismissibleCallout].
///
/// {@tool snippet}
/// This example shows a basic callout:
///
/// ```dart
/// const Callout(message: 'Important information here.')
/// ```
/// {@end-tool}
///
/// See also:
///
///  * [DismissibleCallout], which adds a close button.
///  * [SnackBar], for transient messages.
class Callout extends StatelessWidget { ... }
```

### Constructor-level docs
For `const` constructors, describe what arguments configure:

```dart
/// Creates a callout widget.
///
/// The [message] argument must not be null.
const Callout({
  super.key,
  required this.message,
  this.style,
});
```

For named constructors that are common factory patterns, describe what scenario the constructor is for:

```dart
/// Creates a callout styled for warning messages.
const Callout.warning({super.key, required this.message})
    : style = CalloutStyle.warning;
```

### Property docs in widgets
Widget properties that correspond to Flutter's common patterns:

```dart
/// The text displayed inside the callout.
final String message;

/// The visual style of this callout.
///
/// Defaults to [CalloutStyle.info] if not specified.
final CalloutStyle? style;

/// Called when the user taps the callout.
///
/// If null, the callout does not respond to taps.
final VoidCallback? onTap;
```

### `See also:` section
Use a bulleted `See also:` list at the end of class or library doc comments to link related types:

```dart
/// See also:
///
///  * [RelatedClass], which does something similar.
///  * [OtherClass.method], for a method-level alternative.
```

Note the two-space indent before `*` bullets — this is the Flutter convention for `See also:` lists.

---

## `@override` and Inherited Docs

When overriding a method that is already well-documented on the parent class, you can omit the doc comment to inherit the parent's documentation. Only add a doc comment on the override if the behavior differs in a meaningful way.

```dart
@override
Widget build(BuildContext context) {
  // No doc comment needed if behavior matches the inherited contract.
  ...
}
```

If the override changes behavior, document the difference:

```dart
/// Builds this widget.
///
/// Unlike the default implementation, this build method listens to
/// [MyInheritedWidget] and rebuilds when it changes.
@override
Widget build(BuildContext context) { ... }
```
