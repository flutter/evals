/// Configuration for a Docker Compose service, used to programmatically
/// generate compose YAML.
class ComposeService {
  /// Docker image name.
  final String? image;

  /// Build context (directory or config).
  final Object? /* String | Map<String, Object> */ build;

  /// Container command.
  final String? command;

  /// Environment variables.
  final Map<String, String>? environment;

  /// Volume mounts.
  final List<String>? volumes;

  /// Port mappings.
  final List<String>? ports;

  /// Memory limit (e.g. '0.5gb', '512m').
  final String? memLimit;

  /// CPU limit (e.g. 1.0).
  final double? cpus;

  /// Network mode (e.g. 'none' for isolation).
  final String? networkMode;

  /// Whether to use init (PID 1 signal handling).
  final bool init;

  /// Extension fields (x-local, x-default, etc.).
  final Map<String, Object>? extensions;

  /// Creates a [ComposeService] definition.
  ///
  /// All fields are optional; unset fields are omitted from the generated
  /// compose YAML.
  const ComposeService({
    this.image,
    this.build,
    this.command,
    this.environment,
    this.volumes,
    this.ports,
    this.memLimit,
    this.cpus,
    this.networkMode,
    this.init = true,
    this.extensions,
  });

  /// Convert to a map suitable for YAML serialization.
  Map<String, Object> toMap() {
    final map = <String, Object>{};
    if (image != null) map['image'] = image!;
    if (build != null) map['build'] = build!;
    if (command != null) map['command'] = command!;
    if (environment != null) map['environment'] = environment!;
    if (volumes != null) map['volumes'] = volumes!;
    if (ports != null) map['ports'] = ports!;
    if (memLimit != null) map['mem_limit'] = memLimit!;
    if (cpus != null) map['cpus'] = cpus!;
    if (networkMode != null) map['network_mode'] = networkMode!;
    if (init) map['init'] = true;
    if (extensions != null) {
      for (final entry in extensions!.entries) {
        map[entry.key] = entry.value;
      }
    }
    return map;
  }
}

/// Configuration for a Docker Compose project, containing one or more
/// services and optional volumes.
class ComposeConfig {
  /// Service definitions.
  final Map<String, ComposeService> services;

  /// Named volume definitions.
  final Map<String, Object>? volumes;

  const ComposeConfig({
    required this.services,
    this.volumes,
  });

  /// Creates a minimal default compose configuration.
  ///
  /// Uses `ghcr.io/cirruslabs/flutter:stable` with a keep-alive command
  /// (`tail -f /dev/null`) so the container stays running for exec commands.
  factory ComposeConfig.defaultConfig() {
    return ComposeConfig(
      services: {
        'default': ComposeService(
          image: 'ghcr.io/cirruslabs/flutter:stable',
          init: true,
          command: 'tail -f /dev/null',
        ),
      },
    );
  }

  /// Convert to a map suitable for YAML serialization.
  Map<String, Object> toMap() {
    final map = <String, Object>{
      'services': {
        for (final entry in services.entries) entry.key: entry.value.toMap(),
      },
    };
    if (volumes != null) {
      map['volumes'] = volumes!;
    }
    return map;
  }

  /// Serialize to a YAML string.
  String toYaml() {
    final map = toMap();
    return _mapToYaml(map, indent: 0);
  }
}

/// Simple recursive YAML serializer.
///
/// We avoid pulling in a full YAML emitter dependency by hand-writing this
/// for the limited set of types we need (Map, List, String, num, bool).
String _mapToYaml(Map<String, Object> map, {required int indent}) {
  final buf = StringBuffer();
  final prefix = '  ' * indent;
  for (final entry in map.entries) {
    final key = entry.key;
    final value = entry.value;
    if (value is Map<String, Object>) {
      buf.writeln('$prefix$key:');
      buf.write(_mapToYaml(value, indent: indent + 1));
    } else if (value is List) {
      buf.writeln('$prefix$key:');
      for (final item in value) {
        buf.writeln('$prefix  - $item');
      }
    } else if (value is String) {
      // Quote strings that contain special YAML chars
      if (_needsQuoting(value)) {
        buf.writeln("$prefix$key: '$value'");
      } else {
        buf.writeln('$prefix$key: $value');
      }
    } else {
      buf.writeln('$prefix$key: $value');
    }
  }
  return buf.toString();
}

bool _needsQuoting(String s) {
  if (s.isEmpty) return true;
  if (s.contains(':') ||
      s.contains('#') ||
      s.contains('{') ||
      s.contains('}') ||
      s.contains('[') ||
      s.contains(']') ||
      s.contains(',') ||
      s.contains('&') ||
      s.contains('*') ||
      s.contains('?') ||
      s.contains('|') ||
      s.contains('>') ||
      s.contains("'") ||
      s.contains('"') ||
      s.contains('%') ||
      s.contains('@') ||
      s.startsWith(' ') ||
      s.endsWith(' ')) {
    return true;
  }
  return false;
}
