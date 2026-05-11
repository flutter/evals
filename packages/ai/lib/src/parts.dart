import 'package:equatable/equatable.dart';

/// Base class for message parts.
abstract class Part extends Equatable {
  const Part();

  /// Convenience factory for a text part.
  factory Part.text(String text) => TextPart(text);

  /// Serialises this part to a JSON-compatible map.
  Map<String, dynamic> toJson();

  /// Deserialises a [Part] from a JSON map.
  ///
  /// Dispatches based on the presence of `'text'`, `'toolRequest'`, or
  /// `'toolResponse'` keys.
  factory Part.fromJson(Map<String, dynamic> json) {
    if (json.containsKey('text')) return TextPart.fromJson(json);
    if (json.containsKey('toolRequest')) return ToolRequestPart.fromJson(json);
    if (json.containsKey('toolResponse')) {
      return ToolResponsePart.fromJson(json);
    }
    throw FormatException('Unknown Part type: ${json.keys}');
  }
}

/// A text part of a message.
class TextPart extends Part {
  final String text;
  const TextPart(this.text);

  @override
  Map<String, dynamic> toJson() => {'text': text};

  /// Deserialises a [TextPart] from a JSON map.
  factory TextPart.fromJson(Map<String, dynamic> json) =>
      TextPart(json['text'] as String);

  @override
  List<Object?> get props => [text];

  @override
  String toString() => 'Text: $text';
}

/// A request from the model to execute a tool.
class ToolRequestPart extends Part {
  final String name;
  final String ref;
  final Map<String, dynamic> input;

  const ToolRequestPart({
    required this.name,
    required this.ref,
    required this.input,
  });

  @override
  Map<String, dynamic> toJson() => {
    'toolRequest': {'name': name, 'ref': ref, 'input': input},
  };

  /// Deserialises a [ToolRequestPart] from a JSON map.
  factory ToolRequestPart.fromJson(Map<String, dynamic> json) {
    final tr = json['toolRequest'] as Map<String, dynamic>;
    return ToolRequestPart(
      name: tr['name'] as String,
      ref: tr['ref'] as String,
      input: tr['input'] as Map<String, dynamic>,
    );
  }

  @override
  List<Object?> get props => [name, ref, input];

  @override
  String toString() => 'ToolRequest: $name($input)';
}

/// A response to a tool request.
class ToolResponsePart extends Part {
  final String name;
  final String ref;
  final dynamic output;

  const ToolResponsePart({
    required this.name,
    required this.ref,
    required this.output,
  });

  @override
  Map<String, dynamic> toJson() => {
    'toolResponse': {'name': name, 'ref': ref, 'output': output},
  };

  /// Deserialises a [ToolResponsePart] from a JSON map.
  factory ToolResponsePart.fromJson(Map<String, dynamic> json) {
    final tr = json['toolResponse'] as Map<String, dynamic>;
    return ToolResponsePart(
      name: tr['name'] as String,
      ref: tr['ref'] as String,
      output: tr['output'],
    );
  }

  @override
  List<Object?> get props => [name, ref, output];

  @override
  String toString() => 'ToolResponse: $name -> $output';
}
