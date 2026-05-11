import 'package:equatable/equatable.dart';

/// A model identifier consisting of a provider and version.
///
/// Used by `EvalSet` to enumerate models in the evaluation matrix.
/// The string form is `$provider/$version`, which matches common
/// model reference formats (e.g. `googleai/gemini-2.5-flash`).
class Model extends Equatable {
  final String provider;
  final String version;

  const Model(this.provider, this.version);

  @override
  List<Object?> get props => [provider, version];

  @override
  String toString() => '$provider/$version';
}
