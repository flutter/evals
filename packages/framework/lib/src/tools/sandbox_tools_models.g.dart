// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sandbox_tools_models.dart';

// **************************************************************************
// SchemaGenerator
// **************************************************************************

base class BashInput {
  factory BashInput.fromJson(Map<String, dynamic> json) => $schema.parse(json);

  BashInput._(this._json);

  BashInput({required String command, String? workingDir, int? timeout}) {
    _json = {
      'command': command,
      'workingDir': ?workingDir,
      'timeout': ?timeout,
    };
  }

  late final Map<String, dynamic> _json;

  static const SchemanticType<BashInput> $schema = _BashInputTypeFactory();

  String get command {
    return _json['command'] as String;
  }

  set command(String value) {
    _json['command'] = value;
  }

  String? get workingDir {
    return _json['workingDir'] as String?;
  }

  set workingDir(String? value) {
    if (value == null) {
      _json.remove('workingDir');
    } else {
      _json['workingDir'] = value;
    }
  }

  int? get timeout {
    return _json['timeout'] as int?;
  }

  set timeout(int? value) {
    if (value == null) {
      _json.remove('timeout');
    } else {
      _json['timeout'] = value;
    }
  }

  @override
  String toString() {
    return _json.toString();
  }

  Map<String, dynamic> toJson() {
    return _json;
  }
}

base class _BashInputTypeFactory extends SchemanticType<BashInput> {
  const _BashInputTypeFactory();

  @override
  BashInput parse(Object? json) {
    return BashInput._(json as Map<String, dynamic>);
  }

  @override
  JsonSchemaMetadata get schemaMetadata => JsonSchemaMetadata(
    name: 'BashInput',
    definition: $Schema
        .object(
          properties: {
            'command': $Schema.string(
              description: 'The bash command to execute.',
            ),
            'workingDir': $Schema.string(
              description:
                  'Optional working directory (absolute path inside the sandbox).',
            ),
            'timeout': $Schema.integer(
              description: 'Optional timeout in seconds. Defaults to 60.',
              minimum: 1,
              maximum: 300,
            ),
          },
          required: ['command'],
        )
        .value,
    dependencies: [],
  );
}

base class ReadFileInput {
  factory ReadFileInput.fromJson(Map<String, dynamic> json) =>
      $schema.parse(json);

  ReadFileInput._(this._json);

  ReadFileInput({required String path}) {
    _json = {'path': path};
  }

  late final Map<String, dynamic> _json;

  static const SchemanticType<ReadFileInput> $schema =
      _ReadFileInputTypeFactory();

  String get path {
    return _json['path'] as String;
  }

  set path(String value) {
    _json['path'] = value;
  }

  @override
  String toString() {
    return _json.toString();
  }

  Map<String, dynamic> toJson() {
    return _json;
  }
}

base class _ReadFileInputTypeFactory extends SchemanticType<ReadFileInput> {
  const _ReadFileInputTypeFactory();

  @override
  ReadFileInput parse(Object? json) {
    return ReadFileInput._(json as Map<String, dynamic>);
  }

  @override
  JsonSchemaMetadata get schemaMetadata => JsonSchemaMetadata(
    name: 'ReadFileInput',
    definition: $Schema
        .object(
          properties: {
            'path': $Schema.string(
              description: 'Absolute path to the file inside the sandbox.',
            ),
          },
          required: ['path'],
        )
        .value,
    dependencies: [],
  );
}

base class WriteFileInput {
  factory WriteFileInput.fromJson(Map<String, dynamic> json) =>
      $schema.parse(json);

  WriteFileInput._(this._json);

  WriteFileInput({required String path, required String content}) {
    _json = {'path': path, 'content': content};
  }

  late final Map<String, dynamic> _json;

  static const SchemanticType<WriteFileInput> $schema =
      _WriteFileInputTypeFactory();

  String get path {
    return _json['path'] as String;
  }

  set path(String value) {
    _json['path'] = value;
  }

  String get content {
    return _json['content'] as String;
  }

  set content(String value) {
    _json['content'] = value;
  }

  @override
  String toString() {
    return _json.toString();
  }

  Map<String, dynamic> toJson() {
    return _json;
  }
}

base class _WriteFileInputTypeFactory extends SchemanticType<WriteFileInput> {
  const _WriteFileInputTypeFactory();

  @override
  WriteFileInput parse(Object? json) {
    return WriteFileInput._(json as Map<String, dynamic>);
  }

  @override
  JsonSchemaMetadata get schemaMetadata => JsonSchemaMetadata(
    name: 'WriteFileInput',
    definition: $Schema
        .object(
          properties: {
            'path': $Schema.string(
              description: 'Absolute path to the file inside the sandbox.',
            ),
            'content': $Schema.string(
              description: 'The complete file content to write.',
            ),
          },
          required: ['path', 'content'],
        )
        .value,
    dependencies: [],
  );
}
