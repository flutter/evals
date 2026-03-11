# devals_cli (devals)

CLI for managing dash-evals.

Provides commands for:
- Creating samples and jobs
- Running evaluations
- Viewing results

---

## class `CheckResult`

The result of a single prerequisite check.

### Constructors

#### `CheckResult`

```dart
CheckResult({required CheckStatus status, String? version, String? message, String? fix})
```

### Properties

- **`status`** → `CheckStatus` *(final)*

- **`version`** → `String?` *(final)*

- **`message`** → `String?` *(final)*

- **`fix`** → `String?` *(final)*

---

## class `CliException`

**Implements:** `Exception`

Exception thrown when a CLI command fails with a specific exit code.

Throw this from anywhere in the CLI codebase when an error occurs.
The top-level main function catches these and exits with the specified code.

### Constructors

#### `CliException`

```dart
CliException(String message, {int exitCode})
```

### Properties

- **`message`** → `String` *(final)*

- **`exitCode`** → `int` *(final)*

---

## class `CreateCommand`

**Extends:** `Command<int>`

Parent command for create subcommands.

### Constructors

#### `CreateCommand`

```dart
CreateCommand()
```

### Properties

- **`name`** → `String`

- **`description`** → `String`

---

## class `CreateJobCommand`

**Extends:** `Command<int>`

Interactive command to create a new job file.

### Constructors

#### `CreateJobCommand`

```dart
CreateJobCommand()
```

### Properties

- **`name`** → `String`

- **`description`** → `String`

### Methods

#### `run`

```dart
Future<int> run()
```

---

## class `CreatePipelineCommand`

**Extends:** `Command<int>`

Interactive guide to create a task and job in one go.

### Constructors

#### `CreatePipelineCommand`

```dart
CreatePipelineCommand()
```

### Properties

- **`name`** → `String`

- **`description`** → `String`

### Methods

#### `run`

```dart
Future<int> run()
```

---

## class `CreateSampleCommand`

**Extends:** `Command<int>`

Interactive command to add a new sample to an existing task file.

### Constructors

#### `CreateSampleCommand`

```dart
CreateSampleCommand()
```

### Properties

- **`name`** → `String`

- **`description`** → `String`

### Methods

#### `run`

```dart
Future<int> run()
```

---

## class `CreateTaskCommand`

**Extends:** `Command<int>`

Interactive command to create a new task file in tasks/{name}/task.yaml.

### Constructors

#### `CreateTaskCommand`

```dart
CreateTaskCommand()
```

### Properties

- **`name`** → `String`

- **`description`** → `String`

### Methods

#### `run`

```dart
Future<int> run()
```

---

## class `DoctorCheck`

A single prerequisite check to run.

### Constructors

#### `DoctorCheck`

```dart
DoctorCheck({required String name, required String component, required Future<CheckResult> Function() check, bool isRequired})
```

### Properties

- **`name`** → `String` *(final)*

- **`component`** → `String` *(final)*

- **`check`** → `Future<CheckResult> Function()` *(final)*

- **`isRequired`** → `bool` *(final)*

---

## class `DoctorCommand`

**Extends:** `Command<int>`

Command that checks whether prerequisites are installed.

Similar to `flutter doctor`, this verifies the tools needed
for the CLI, dash_evals, and eval_explorer.

### Constructors

#### `DoctorCommand`

```dart
DoctorCommand({Future<ProcessResult> Function(String, List<String>)? processRunner})
```

### Properties

- **`name`** → `String`

- **`description`** → `String`

### Methods

#### `run`

```dart
Future<int> run()
```

---

## class `InitCommand`

**Extends:** `Command<int>`

### Constructors

#### `InitCommand`

```dart
InitCommand()
```

### Properties

- **`name`** → `String`

- **`description`** → `String`

### Methods

#### `run`

```dart
Future<int> run()
```

---

## class `PublishCommand`

**Extends:** `Command<int>`

Publishes InspectAI JSON log files to a GCS bucket.

Usage:
  devals publish {path}           Upload a file or directory of logs
  devals publish --dry-run {path} Preview what would be uploaded

The target bucket and credentials are configured via `.env` file,
environment variables, or CLI flags. Precedence: flag > env var > .env.

### Constructors

#### `PublishCommand`

```dart
PublishCommand()
```

### Properties

- **`name`** → `String`

- **`description`** → `String`

- **`invocation`** → `String`

### Methods

#### `run`

```dart
Future<int> run()
```

---

## class `RunCommand`

**Extends:** `Command<int>`

Command to run evaluations using the Python dash_evals package.

Config resolution and dry-run happen entirely in Dart. For actual runs,
Dart writes an EvalSet JSON file, then Python reads it and calls
`eval_set()` directly.

### Constructors

#### `RunCommand`

```dart
RunCommand()
```

### Properties

- **`name`** → `String`

- **`description`** → `String`

- **`invocation`** → `String`

### Methods

#### `run`

```dart
Future<int> run()
```

---

## class `ViewCommand`

**Extends:** `Command<int>`

Command to launch the Inspect AI viewer.

### Constructors

#### `ViewCommand`

```dart
ViewCommand()
```

### Properties

- **`name`** → `String`

- **`description`** → `String`

- **`invocation`** → `String`

### Methods

#### `run`

```dart
Future<int> run()
```

---

## enum `CheckStatus`

The result status of a single doctor check.

### Values

- **`ok`**
- **`warning`**
- **`error`**

---

## `buildChecks`

```dart
List<DoctorCheck> buildChecks({Future<ProcessResult> Function(String, List<String>)? processRunner})
```

Builds the list of all doctor checks.

[processRunner] is injectable for testing.

**Parameters:**

- `processRunner` (`Future<ProcessResult> Function(String, List<String>)?`)

