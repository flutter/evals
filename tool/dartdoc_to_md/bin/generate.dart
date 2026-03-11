// Dart-to-Markdown generator for Sphinx docs.
//
// Usage:
//   dart run bin/generate.dart [--output <dir>] [--root <dir>]
//
// Reads Dart source files using the analyzer, extracts public API elements
// (classes, enums, functions, constants) with their doc comments, and
// generates Sphinx-compatible Markdown (.md) files.

import 'dart:io';

import 'package:analyzer/dart/analysis/analysis_context_collection.dart';
import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
import 'package:analyzer/file_system/physical_file_system.dart';
import 'package:args/args.dart';
import 'package:path/path.dart' as p;

// ---------------------------------------------------------------------------
// Configuration
// ---------------------------------------------------------------------------

class PackageSpec {
  final String name;
  final String displayName;
  final String packageDir;
  final String libraryFile;

  const PackageSpec({
    required this.name,
    required this.displayName,
    required this.packageDir,
    required this.libraryFile,
  });
}

// ---------------------------------------------------------------------------
// Main
// ---------------------------------------------------------------------------

Future<void> main(List<String> args) async {
  final parser =
      ArgParser()
        ..addOption(
          'output',
          abbr: 'o',
          defaultsTo: 'docs/reference/dart_api',
          help: 'Output directory for generated markdown files.',
        )
        ..addOption(
          'root',
          abbr: 'r',
          defaultsTo: '.',
          help: 'Root directory of the monorepo.',
        );

  final results = parser.parse(args);
  final root = p.canonicalize(results['root'] as String);
  final outputDir = p.join(root, results['output'] as String);

  // Clean stale output from previous runs.
  final outputDirectory = Directory(outputDir);
  if (outputDirectory.existsSync()) {
    stdout.writeln('🧹 Cleaning $outputDir...');
    outputDirectory.deleteSync(recursive: true);
  }

  final packages = [
    PackageSpec(
      name: 'dataset_config_dart',
      displayName: 'dataset_config_dart',
      packageDir: p.join(root, 'packages', 'dataset_config_dart'),
      libraryFile: 'dataset_config_dart.dart',
    ),
    PackageSpec(
      name: 'devals_cli',
      displayName: 'devals_cli (devals)',
      packageDir: p.join(root, 'packages', 'devals_cli'),
      libraryFile: 'devals.dart',
    ),
    PackageSpec(
      name: 'eval_explorer_server',
      displayName: 'eval_explorer_server',
      packageDir: p.join(root, 'packages', 'eval_explorer', 'eval_explorer_server'),
      libraryFile: 'server.dart',
    ),
    PackageSpec(
      name: 'eval_explorer_shared',
      displayName: 'eval_explorer_shared',
      packageDir: p.join(root, 'packages', 'eval_explorer', 'eval_explorer_shared'),
      libraryFile: 'eval_explorer_shared.dart',
    ),
    PackageSpec(
      name: 'eval_explorer_client',
      displayName: 'eval_explorer_client',
      packageDir: p.join(root, 'packages', 'eval_explorer', 'eval_explorer_client'),
      libraryFile: 'eval_explorer_client.dart',
    ),
  ];

  for (final pkg in packages) {
    stdout.writeln('📦 Processing ${pkg.displayName}...');
    try {
      await _processPackage(pkg, outputDir);
      stdout.writeln('   ✅ Done');
    } catch (e, st) {
      stderr.writeln('   ❌ Error processing ${pkg.name}: $e');
      stderr.writeln(st);
    }
  }

  _writeIndex(outputDir, packages);
  stdout.writeln('\n🎉 All done! Markdown written to $outputDir');
}

/// Check if an element should be excluded from docs.
bool _shouldExclude(Element element) {
  final name = element.name;
  if (name == null) return true;

  // Skip private elements
  if (name.startsWith('_')) return true;

  // Skip Freezed-generated classes ($CopyWith, _$Impl, etc.)
  if (name.startsWith(r'$')) return true;

  return false;
}

// ---------------------------------------------------------------------------
// Package processing
// ---------------------------------------------------------------------------

Future<void> _processPackage(PackageSpec pkg, String outputDir) async {
  final libDir = p.join(pkg.packageDir, 'lib');
  final barrelPath = p.join(libDir, pkg.libraryFile);

  if (!File(barrelPath).existsSync()) {
    stderr.writeln('   ⚠️  Barrel file not found: $barrelPath — skipping');
    return;
  }

  // Use the analyzer to resolve the barrel library. This gives us all
  // exported elements across transitive exports.
  final collection = AnalysisContextCollection(
    includedPaths: [libDir],
    resourceProvider: PhysicalResourceProvider.INSTANCE,
  );

  final canonBarrel = p.canonicalize(barrelPath);
  final context = collection.contextFor(canonBarrel);
  final resolvedResult = await context.currentSession.getResolvedLibrary(
    canonBarrel,
  );

  if (resolvedResult is! ResolvedLibraryResult) {
    stderr.writeln('   ⚠️  Could not resolve $barrelPath — skipping');
    return;
  }

  final library = resolvedResult.element;

  final buf = StringBuffer();
  buf.writeln('# ${pkg.displayName}');
  buf.writeln();

  // Library-level doc comment
  final libDoc = library.documentationComment;
  if (libDoc != null) {
    buf.writeln(_cleanDoc(libDoc));
    buf.writeln();
  }

  // Use the export namespace to get ALL publicly visible elements,
  // including those re-exported from src/ files.
  final exportedNames = library.exportNamespace.definedNames2;

  // Sort elements into categories
  final classes = <ClassElement>[];
  final enums = <EnumElement>[];
  final functions = <TopLevelFunctionElement>[];
  final variables = <TopLevelVariableElement>[];

  for (final element in exportedNames.values) {
    if (_shouldExclude(element)) continue;

    if (element is ClassElement) {
      classes.add(element);
    } else if (element is EnumElement) {
      enums.add(element);
    } else if (element is TopLevelFunctionElement) {
      functions.add(element);
    } else if (element is TopLevelVariableElement) {
      variables.add(element);
    }
    // Skip getters, setters, and other element types for now
  }

  // Sort by name for stable output
  classes.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
  enums.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
  functions.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));
  variables.sort((a, b) => (a.name ?? '').compareTo(b.name ?? ''));

  stdout.writeln(
    '   Found ${classes.length} classes, ${enums.length} enums, '
    '${functions.length} functions, ${variables.length} variables',
  );

  // Track whether we've written any content yet (to avoid leading ---)
  var hasContent = libDoc != null;

  _writeClasses(buf, classes, hasContent);
  hasContent = hasContent || classes.isNotEmpty;
  _writeEnums(buf, enums, hasContent);
  hasContent = hasContent || enums.isNotEmpty;
  _writeFunctions(buf, functions, hasContent);
  hasContent = hasContent || functions.isNotEmpty;
  _writeTopLevelVariables(buf, variables, hasContent);

  // Write to disk
  final pkgOutputDir = p.join(outputDir, pkg.name);
  Directory(pkgOutputDir).createSync(recursive: true);
  File(
    p.join(pkgOutputDir, '${pkg.name}.md'),
  ).writeAsStringSync(buf.toString());
}

// ---------------------------------------------------------------------------
// Markdown generators
// ---------------------------------------------------------------------------

void _writeClasses(
  StringBuffer buf,
  List<ClassElement> classes,
  bool hasContent,
) {
  var isFirst = !hasContent;
  for (final cls in classes) {
    if (cls.name == null || cls.name!.startsWith('_')) continue;

    // Skip classes with @nodoc annotation
    final classDoc = cls.documentationComment;
    if (classDoc != null && classDoc.contains('@nodoc')) continue;

    if (!isFirst) {
      buf.writeln('---');
      buf.writeln();
    }
    isFirst = false;
    final keyword = cls.isAbstract ? 'abstract class' : 'class';
    buf.writeln('## $keyword `${cls.name}`');
    buf.writeln();

    // Superclass
    final supertype = cls.supertype;
    if (supertype != null) {
      final supertypeName = _typeStr(supertype);
      if (supertypeName != 'Object') {
        buf.writeln('**Extends:** `$supertypeName`');
        buf.writeln();
      }
    }

    // Interfaces
    if (cls.interfaces.isNotEmpty) {
      final names = cls.interfaces.map((i) => '`${_typeStr(i)}`').join(', ');
      buf.writeln('**Implements:** $names');
      buf.writeln();
    }

    // Mixins
    if (cls.mixins.isNotEmpty) {
      final names = cls.mixins.map((m) => '`${_typeStr(m)}`').join(', ');
      buf.writeln('**Mixins:** $names');
      buf.writeln();
    }

    _writeDoc(buf, cls.documentationComment);

    // Constructors
    final constructors =
        cls.constructors
            .where((c) => c.name != null && !c.name!.startsWith('_'))
            .toList();
    if (constructors.isNotEmpty) {
      buf.writeln('### Constructors');
      buf.writeln();
      for (final ctor in constructors) {
        final ctorName =
            ctor.name == 'new' ? cls.name! : '${cls.name}.${ctor.name}';
        buf.writeln('#### `$ctorName`');
        buf.writeln();
        buf.writeln('```dart');
        buf.writeln(_constructorSignature(cls.name!, ctor));
        buf.writeln('```');
        buf.writeln();
        _writeDoc(buf, ctor.documentationComment);
      }
    }

    // Fields / properties
    final fields =
        cls.fields
            .where(
              (f) =>
                  f.name != null &&
                  !f.name!.startsWith('_') &&
                  f.name != 'hashCode',
            )
            .toList();
    if (fields.isNotEmpty) {
      buf.writeln('### Properties');
      buf.writeln();
      for (final field in fields) {
        final typeStr = _typeStr(field.type);
        final prefix = field.isStatic ? 'static ' : '';
        final suffix = field.isFinal ? ' *(final)*' : '';
        buf.writeln('- **`${field.name}`** → `$prefix$typeStr`$suffix');
        final doc = field.documentationComment;
        if (doc != null) {
          buf.writeln();
          buf.writeln('  ${_cleanDoc(doc).replaceAll('\n', '\n  ')}');
        }
        buf.writeln();
      }
    }

    // Methods
    final methods =
        cls.methods
            .where(
              (m) =>
                  m.name != null &&
                  !m.name!.startsWith('_') &&
                  m.name != 'toString' &&
                  m.name != 'noSuchMethod' &&
                  m.name != '==',
            )
            .toList();
    if (methods.isNotEmpty) {
      buf.writeln('### Methods');
      buf.writeln();
      for (final method in methods) {
        _writeMethod(buf, method);
      }
    }
  }
}

void _writeEnums(StringBuffer buf, List<EnumElement> enums, bool hasContent) {
  var isFirst = !hasContent;
  for (final e in enums) {
    if (e.name == null || e.name!.startsWith('_')) continue;

    if (!isFirst) {
      buf.writeln('---');
      buf.writeln();
    }
    isFirst = false;
    buf.writeln('## enum `${e.name}`');
    buf.writeln();

    _writeDoc(buf, e.documentationComment);

    buf.writeln('### Values');
    buf.writeln();
    for (final value in e.constants) {
      buf.writeln('- **`${value.name}`**');
      final doc = value.documentationComment;
      if (doc != null) {
        buf.writeln('  ${_cleanDoc(doc).replaceAll('\n', '\n  ')}');
      }
    }
    buf.writeln();
  }
}

void _writeFunctions(
  StringBuffer buf,
  List<TopLevelFunctionElement> functions,
  bool hasContent,
) {
  final publicFns =
      functions
          .where((f) => f.name != null && !f.name!.startsWith('_'))
          .toList();
  if (publicFns.isEmpty) return;

  var isFirst = !hasContent;
  for (final fn in publicFns) {
    // Skip main() — not part of the public API
    if (fn.name == 'main') continue;

    if (!isFirst) {
      buf.writeln('---');
      buf.writeln();
    }
    isFirst = false;
    buf.writeln('## `${fn.name}`');
    buf.writeln();
    buf.writeln('```dart');
    buf.writeln(_functionSignature(fn));
    buf.writeln('```');
    buf.writeln();
    _writeDoc(buf, fn.documentationComment);
    _writeParams(buf, fn.formalParameters);
  }
}

void _writeTopLevelVariables(
  StringBuffer buf,
  List<TopLevelVariableElement> variables,
  bool hasContent,
) {
  final publicVars =
      variables
          .where((v) => v.name != null && !v.name!.startsWith('_'))
          .toList();
  if (publicVars.isEmpty) return;

  var isFirst = !hasContent;
  for (final v in publicVars) {
    if (!isFirst) {
      buf.writeln('---');
      buf.writeln();
    }
    isFirst = false;

    final typeStr = _typeStr(v.type);
    buf.writeln('### `${v.name}`');
    buf.writeln();
    buf.writeln('**Type:** `$typeStr`');
    buf.writeln();
    _writeDoc(buf, v.documentationComment);
  }
}

void _writeMethod(StringBuffer buf, MethodElement method) {
  final isStatic = method.isStatic;
  final prefix = isStatic ? 'static ' : '';
  buf.writeln('#### `$prefix${method.name}`');
  buf.writeln();
  buf.writeln('```dart');
  buf.writeln(_methodSignature(method));
  buf.writeln('```');
  buf.writeln();
  _writeDoc(buf, method.documentationComment);
  _writeParams(buf, method.formalParameters);
}

void _writeDoc(StringBuffer buf, String? doc) {
  if (doc == null) return;
  buf.writeln(_cleanDoc(doc));
  buf.writeln();
}

void _writeParams(StringBuffer buf, List<FormalParameterElement> params) {
  final publicParams =
      params.where((p) => p.name != null && !p.name!.startsWith('_')).toList();
  if (publicParams.isEmpty) return;

  buf.writeln('**Parameters:**');
  buf.writeln();
  for (final param in publicParams) {
    final typeStr = _typeStr(param.type);
    final required = param.isRequired ? ' *(required)*' : '';
    buf.writeln('- `${param.name}` (`$typeStr`)$required');
  }
  buf.writeln();
}

// ---------------------------------------------------------------------------
// Signature formatting
// ---------------------------------------------------------------------------

String _constructorSignature(String className, ConstructorElement ctor) {
  final name = ctor.name == 'new' ? className : '$className.${ctor.name}';
  final params = _formatParams(ctor.formalParameters);
  return '$name($params)';
}

String _functionSignature(TopLevelFunctionElement fn) {
  final retType = _typeStr(fn.returnType);
  final params = _formatParams(fn.formalParameters);
  return '$retType ${fn.name}($params)';
}

String _methodSignature(MethodElement method) {
  final retType = _typeStr(method.returnType);
  final params = _formatParams(method.formalParameters);
  final prefix = method.isStatic ? 'static ' : '';
  return '$prefix$retType ${method.name}($params)';
}

String _formatParams(List<FormalParameterElement> params) {
  if (params.isEmpty) return '';

  final parts = <String>[];
  var inNamed = false;
  var inPositional = false;

  for (final p in params) {
    final typeStr = _typeStr(p.type);
    final required = p.isRequired && p.isNamed ? 'required ' : '';
    final paramStr = '$required$typeStr ${p.name}';

    if (p.isNamed && !inNamed) {
      inNamed = true;
      parts.add('{$paramStr');
    } else if (p.isOptionalPositional && !inPositional) {
      inPositional = true;
      parts.add('[$paramStr');
    } else {
      parts.add(paramStr);
    }
  }

  var result = parts.join(', ');
  if (inNamed) result += '}';
  if (inPositional) result += ']';
  return result;
}

// ---------------------------------------------------------------------------
// Type formatting
// ---------------------------------------------------------------------------

String _typeStr(DartType type) => type.getDisplayString();

// ---------------------------------------------------------------------------
// Doc comment cleaning
// ---------------------------------------------------------------------------

String _cleanDoc(String doc) {
  return doc
      .split('\n')
      .map((line) {
        var cleaned = line;
        if (cleaned.trimLeft().startsWith('///')) {
          cleaned = cleaned.trimLeft().substring(3);
          if (cleaned.startsWith(' ')) cleaned = cleaned.substring(1);
        } else if (cleaned.trimLeft().startsWith('*')) {
          cleaned = cleaned.trimLeft().substring(1);
          if (cleaned.startsWith(' ')) cleaned = cleaned.substring(1);
        }
        return cleaned;
      })
      .join('\n')
      .trim();
}

// ---------------------------------------------------------------------------
// Index page
// ---------------------------------------------------------------------------

void _writeIndex(String outputDir, List<PackageSpec> packages) {
  final buf = StringBuffer();
  buf.writeln('# Dart API Reference');
  buf.writeln();
  buf.writeln(
    'Auto-generated API documentation for the Dart packages in this repository.',
  );
  buf.writeln();

  buf.writeln('```{toctree}');
  buf.writeln(':maxdepth: 2');
  buf.writeln();
  for (final pkg in packages) {
    final pkgFile = File(p.join(outputDir, pkg.name, '${pkg.name}.md'));
    if (pkgFile.existsSync()) {
      buf.writeln('${pkg.name}/${pkg.name}');
    }
  }
  buf.writeln('```');
  buf.writeln();

  Directory(outputDir).createSync(recursive: true);
  File(p.join(outputDir, 'index.md')).writeAsStringSync(buf.toString());
  stdout.writeln('📄 Wrote index page');
}
