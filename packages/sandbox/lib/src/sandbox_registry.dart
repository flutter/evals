import 'docker/docker_sandbox_manager.dart';
import 'local/local_sandbox_manager.dart';
import 'podman/podman_sandbox_manager.dart';
import 'sandbox_manager.dart';

/// Registry for sandbox types, enabling third-party packages to register
/// new sandbox backends.
///
/// Built-in types (`docker`, `podman`, and `local`) are registered
/// automatically on first access. Third-party packages can register
/// additional types:
///
/// ```dart
/// // In your package's initialization:
/// SandboxRegistry.register('kubernetes', () => K8sSandboxManager());
///
/// // Later, create by name (e.g. from config):
/// final manager = SandboxRegistry.create('kubernetes');
/// ```
class SandboxRegistry {
  SandboxRegistry._();

  static final Map<String, SandboxManager Function()> _factories = {};
  static bool _builtinsRegistered = false;

  /// Register a sandbox type with a factory function.
  ///
  /// If [type] is already registered, it will be overwritten.
  static void register(String type, SandboxManager Function() factory) {
    _factories[type] = factory;
  }

  /// Create a [SandboxManager] for the given sandbox [type].
  ///
  /// Throws [ArgumentError] if [type] is not registered.
  static SandboxManager create(String type) {
    _ensureBuiltins();
    final factory = _factories[type];
    if (factory == null) {
      throw ArgumentError(
        'Unknown sandbox type: "$type". '
        'Registered types: ${_factories.keys.join(', ')}. '
        'Use SandboxRegistry.register() to add new types.',
      );
    }
    return factory();
  }

  /// List all registered sandbox type names.
  static List<String> get registeredTypes {
    _ensureBuiltins();
    return List.unmodifiable(_factories.keys);
  }

  /// Check whether a sandbox type is registered.
  static bool isRegistered(String type) {
    _ensureBuiltins();
    return _factories.containsKey(type);
  }

  /// Remove a registered sandbox type (mainly for testing).
  static void unregister(String type) {
    _factories.remove(type);
  }

  /// Clear all registrations (mainly for testing).
  static void clear() {
    _factories.clear();
    _builtinsRegistered = false;
  }

  /// Ensure built-in types are registered.
  static void _ensureBuiltins() {
    if (_builtinsRegistered) return;
    _builtinsRegistered = true;
    if (!_factories.containsKey('docker')) {
      _factories['docker'] = () => DockerSandboxManager();
    }
    if (!_factories.containsKey('podman')) {
      _factories['podman'] = () => PodmanSandboxManager(
        dockerfilePath: 'docker/Dockerfile',
        buildContext: '.',
      );
    }
    if (!_factories.containsKey('local')) {
      _factories['local'] = () => LocalSandboxManager();
    }
  }
}
