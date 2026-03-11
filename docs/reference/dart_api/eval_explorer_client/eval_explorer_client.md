# eval_explorer_client

## class `AuthHeaderEncodingException`

**Implements:** `Exception`

An exception thrown upon erroneous encoding of an auth header.

### Constructors

#### `AuthHeaderEncodingException`

```dart
AuthHeaderEncodingException(String message)
```

Creates a new [AuthHeaderEncodingException].

### Properties

- **`message`** → `String` *(final)*

  A message indicating the error.

---

## abstract class `AuthenticationKeyManager`

**Implements:** `ClientAuthKeyProvider`

Manages keys for authentication with the server.

### Constructors

#### `AuthenticationKeyManager`

```dart
AuthenticationKeyManager()
```

### Properties

- **`authHeaderValue`** → `Future<String?>`

### Methods

#### `get`

```dart
Future<String?> get()
```

Retrieves an authentication key.

#### `put`

```dart
Future<void> put(String key)
```

Saves an authentication key retrieved by the server.

**Parameters:**

- `key` (`String`) *(required)*

#### `remove`

```dart
Future<void> remove()
```

Removes the authentication key.

#### `getHeaderValue`

```dart
Future<String?> getHeaderValue()
```

Retrieves the authentication key in a format that can be used in a transport header.
The format conversion is performed by [toHeaderValue].

#### `toHeaderValue`

```dart
Future<String?> toHeaderValue(String? key)
```

Converts an authentication key to a format that can be used in a transport
header. This will automatically be unwrapped again on the server side
before being handed to the authentication handler.

The value must be compliant with the HTTP header format defined in
RFC 9110 HTTP Semantics, 11.6.2. Authorization.
See:
https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Authorization
https://httpwg.org/specs/rfc9110.html#field.authorization

**Parameters:**

- `key` (`String?`) *(required)*

---

## class `BadRequestMessage`

**Extends:** `WebSocketMessage`

A message sent when a bad request is received.

### Constructors

#### `BadRequestMessage`

```dart
BadRequestMessage(Map<dynamic, dynamic> data)
```

Creates a new [BadRequestMessage].

### Properties

- **`request`** → `String` *(final)*

  The request that was bad.

### Methods

#### `static buildMessage`

```dart
static String buildMessage(String request)
```

Builds a [BadRequestMessage] message.

**Parameters:**

- `request` (`String`) *(required)*

---

## class `Bit`

Represents a binary vector, where each element is either `true` or `false`.

### Constructors

#### `Bit`

```dart
Bit(List<bool> value)
```

Creates a [Bit] from a list of boolean values.

#### `Bit.fromBinary`

```dart
Bit.fromBinary(Uint8List bytes)
```

Creates a [Bit] from its binary representation.

### Methods

#### `toBinary`

```dart
Uint8List toBinary()
```

Converts the bit vector to its binary representation.

#### `toList`

```dart
List<bool> toList()
```

Returns the bit vector as a list of boolean values.

#### `static fromString`

```dart
static Bit fromString(String value)
```

Creates a [Bit] from a string representation.

**Parameters:**

- `value` (`String`) *(required)*

---

## class `Client`

**Extends:** `ServerpodClientShared`

### Constructors

#### `Client`

```dart
Client(String host, {dynamic securityContext, AuthenticationKeyManager? authenticationKeyManager, Duration? streamingConnectionTimeout, Duration? connectionTimeout, dynamic Function(MethodCallContext, Object, StackTrace)? onFailedCall, dynamic Function(MethodCallContext)? onSucceededCall, bool? disconnectStreamsOnLostInternetConnection})
```

### Properties

- **`emailIdp`** → `EndpointEmailIdp` *(final)*

- **`jwtRefresh`** → `EndpointJwtRefresh` *(final)*

- **`googleIdp`** → `EndpointGoogleIdp` *(final)*

- **`modules`** → `Modules` *(final)*

- **`endpointRefLookup`** → `Map<String, EndpointRef>`

- **`moduleLookup`** → `Map<String, ModuleEndpointCaller>`

---

## abstract class `ClientAuthKeyProvider`

Provides the authentication key for the client.

### Constructors

#### `ClientAuthKeyProvider`

```dart
ClientAuthKeyProvider()
```

### Properties

- **`authHeaderValue`** → `Future<String?>`

---

## class `CloseMethodStreamCommand`

**Extends:** `WebSocketMessage`

**Implements:** `WebSocketMessageInfo`

A message sent over a websocket connection to close a websocket stream of
data to an endpoint method.

### Constructors

#### `CloseMethodStreamCommand`

```dart
CloseMethodStreamCommand(Map<dynamic, dynamic> data)
```

Creates a new [CloseMethodStreamCommand].

### Properties

- **`endpoint`** → `String` *(final)*

  The endpoint associated with the stream.

- **`method`** → `String` *(final)*

  The method associated with the stream.

- **`connectionId`** → `UuidValue` *(final)*

  The connection id that uniquely identifies the stream.

- **`parameter`** → `String?` *(final)*

  The parameter associated with the stream.
  If this is null the close command targets the return stream of the method.

- **`reason`** → `CloseReason` *(final)*

  The reason the stream was closed.

### Methods

#### `static buildMessage`

```dart
static String buildMessage({required String endpoint, required UuidValue connectionId, String? parameter, required String method, required CloseReason reason})
```

Creates a new [CloseMethodStreamCommand] message.

**Parameters:**

- `endpoint` (`String`) *(required)*
- `connectionId` (`UuidValue`) *(required)*
- `parameter` (`String?`)
- `method` (`String`) *(required)*
- `reason` (`CloseReason`) *(required)*

---

## class `ConnectionAttemptTimedOutException`

**Extends:** `MethodStreamException`

Thrown if connection attempt timed out.

### Constructors

#### `ConnectionAttemptTimedOutException`

```dart
ConnectionAttemptTimedOutException()
```

---

## class `ConnectionClosedException`

**Extends:** `MethodStreamException`

Thrown if the connection is closed with an error.

### Constructors

#### `ConnectionClosedException`

```dart
ConnectionClosedException()
```

Creates a new [ConnectionClosedException].

---

## abstract class `ConnectivityMonitor`

Keeps track of internet connectivity and notifies its listeners when the
internet connection is either lost or regained. For most use cases, use
the concrete FlutterConnectivityMonitor class in the serverpod_flutter
package.

### Constructors

#### `ConnectivityMonitor`

```dart
ConnectivityMonitor()
```

### Methods

#### `addListener`

```dart
void addListener(void Function(bool) listener)
```

Adds a listener to the connectivity monitor.

**Parameters:**

- `listener` (`void Function(bool)`) *(required)*

#### `removeListener`

```dart
void removeListener(void Function(bool) listener)
```

Removes a listener from the connectivity monitor.

**Parameters:**

- `listener` (`void Function(bool)`) *(required)*

#### `dispose`

```dart
void dispose()
```

Removes all listeners from the connectivity monitor.

#### `notifyListeners`

```dart
void notifyListeners(bool connected)
```

Notifies listeners of changes in connectivity. This method should only
be called by classes that inherits from [ConnectivityMonitor].

**Parameters:**

- `connected` (`bool`) *(required)*

---

## abstract class `Dataset`

**Implements:** `SerializableModel`

A dataset is an Inspect AI term that refers to a collection of samples.

In our case, each dataset corresponds to a collection of sample types.
(i.e. "dart_qa_dataset", "flutter_code_execution") And each sample type
refers to a specific file in the /datasets directory.

### Constructors

#### `Dataset`

```dart
Dataset({UuidValue? id, required String name, bool? isActive})
```

#### `Dataset.fromJson`

```dart
Dataset.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`id`** → `UuidValue?`

  The database id, set if the object has been inserted into the
  database or if it has been fetched from the database. Otherwise,
  the id will be null.

- **`name`** → `String`

- **`isActive`** → `bool`

### Methods

#### `copyWith`

```dart
Dataset copyWith({UuidValue? id, String? name, bool? isActive})
```

Returns a shallow copy of this [Dataset]
with some or all fields replaced by the given arguments.

**Parameters:**

- `id` (`UuidValue?`)
- `name` (`String?`)
- `isActive` (`bool?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## class `DeepCollectionEquality`

**Implements:** `Equality<dynamic>`

Deep equality on collections.

Recognizes lists, sets, iterables and maps and compares their elements using
deep equality as well.

Non-iterable/map objects are compared using a configurable base equality.

Works in one of two modes: ordered or unordered.

In ordered mode, lists and iterables are required to have equal elements
in the same order. In unordered mode, the order of elements in iterables
and lists are not important.

A list is only equal to another list, likewise for sets and maps. All other
iterables are compared as iterables only.

### Constructors

#### `DeepCollectionEquality`

```dart
DeepCollectionEquality([Equality<dynamic> base])
```

#### `DeepCollectionEquality.unordered`

```dart
DeepCollectionEquality.unordered([Equality<dynamic> base])
```

Creates a deep equality on collections where the order of lists and
iterables are not considered important. That is, lists and iterables are
treated as unordered iterables.

### Methods

#### `equals`

```dart
bool equals(Object? e1, Object? e2)
```

**Parameters:**

- `e1` (`Object?`) *(required)*
- `e2` (`Object?`) *(required)*

#### `hash`

```dart
int hash(Object? o)
```

**Parameters:**

- `o` (`Object?`) *(required)*

#### `isValidKey`

```dart
bool isValidKey(Object? o)
```

**Parameters:**

- `o` (`Object?`) *(required)*

---

## class `DeserializationTypeNotFoundException`

**Implements:** `Exception`

Exception thrown when no deserialization type was found during
protocol deserialization

### Constructors

#### `DeserializationTypeNotFoundException`

```dart
DeserializationTypeNotFoundException({String? message, Type? type})
```

Creates a new [DeserializationTypeNotFoundException].

### Properties

- **`message`** → `String` *(final)*

  The exception message that was thrown.

- **`type`** → `Type?` *(final)*

  The type that was not found.

---

## abstract class `EndpointCaller`

Super class for all classes that can call a server endpoint.

### Constructors

#### `EndpointCaller`

```dart
EndpointCaller()
```

### Properties

- **`endpointRefLookup`** → `Map<String, EndpointRef>`

### Methods

#### `callServerEndpoint`

```dart
Future<T> callServerEndpoint(String endpoint, String method, Map<String, dynamic> args, {bool authenticated})
```

Calls a server endpoint method by its name, passing arguments in a map.
Typically, this method is called by generated code.

**Parameters:**

- `endpoint` (`String`) *(required)*
- `method` (`String`) *(required)*
- `args` (`Map<String, dynamic>`) *(required)*
- `authenticated` (`bool`)

#### `callStreamingServerEndpoint`

```dart
dynamic callStreamingServerEndpoint(String endpoint, String method, Map<String, dynamic> args, Map<String, Stream<dynamic>> streams, {bool authenticated})
```

Calls a server endpoint method that supports streaming. The [streams]
parameter is a map of stream names to stream objects. The method will
listen to the streams and send the data to the server.
Typically, this method is called by generated code.

[T] is the type of the return value of the endpoint stream. This is either
a [Stream] or a [Future].

[G] is the generic of [T], such as `T<G>`.

If [T] is not a [Stream] or a [Future], the method will throw an exception.

**Parameters:**

- `endpoint` (`String`) *(required)*
- `method` (`String`) *(required)*
- `args` (`Map<String, dynamic>`) *(required)*
- `streams` (`Map<String, Stream<dynamic>>`) *(required)*
- `authenticated` (`bool`)

#### `getEndpointOfType`

```dart
T getEndpointOfType([String? name])
```

Returns an endpoint of type [T]. If more than one endpoint of type [T]
exists, [name] can be used to disambiguate.

**Parameters:**

- `name` (`String?`)

---

## class `EndpointEmailIdp`

**Extends:** `EndpointEmailIdpBase`

By extending [EmailIdpBaseEndpoint], the email identity provider endpoints
are made available on the server and enable the corresponding sign-in widget
on the client.
{@category Endpoint}

### Constructors

#### `EndpointEmailIdp`

```dart
EndpointEmailIdp(EndpointCaller caller)
```

### Properties

- **`name`** → `String`

### Methods

#### `login`

```dart
Future<AuthSuccess> login({required String email, required String password})
```

Logs in the user and returns a new session.

Throws an [EmailAccountLoginException] in case of errors, with reason:
- [EmailAccountLoginExceptionReason.invalidCredentials] if the email or
  password is incorrect.
- [EmailAccountLoginExceptionReason.tooManyAttempts] if there have been
  too many failed login attempts.

Throws an [AuthUserBlockedException] if the auth user is blocked.

**Parameters:**

- `email` (`String`) *(required)*
- `password` (`String`) *(required)*

#### `startRegistration`

```dart
Future<UuidValue> startRegistration({required String email})
```

Starts the registration for a new user account with an email-based login
associated to it.

Upon successful completion of this method, an email will have been
sent to [email] with a verification link, which the user must open to
complete the registration.

Always returns a account request ID, which can be used to complete the
registration. If the email is already registered, the returned ID will not
be valid.

**Parameters:**

- `email` (`String`) *(required)*

#### `verifyRegistrationCode`

```dart
Future<String> verifyRegistrationCode({required UuidValue accountRequestId, required String verificationCode})
```

Verifies an account request code and returns a token
that can be used to complete the account creation.

Throws an [EmailAccountRequestException] in case of errors, with reason:
- [EmailAccountRequestExceptionReason.expired] if the account request has
  already expired.
- [EmailAccountRequestExceptionReason.policyViolation] if the password
  does not comply with the password policy.
- [EmailAccountRequestExceptionReason.invalid] if no request exists
  for the given [accountRequestId] or [verificationCode] is invalid.

**Parameters:**

- `accountRequestId` (`UuidValue`) *(required)*
- `verificationCode` (`String`) *(required)*

#### `finishRegistration`

```dart
Future<AuthSuccess> finishRegistration({required String registrationToken, required String password})
```

Completes a new account registration, creating a new auth user with a
profile and attaching the given email account to it.

Throws an [EmailAccountRequestException] in case of errors, with reason:
- [EmailAccountRequestExceptionReason.expired] if the account request has
  already expired.
- [EmailAccountRequestExceptionReason.policyViolation] if the password
  does not comply with the password policy.
- [EmailAccountRequestExceptionReason.invalid] if the [registrationToken]
  is invalid.

Throws an [AuthUserBlockedException] if the auth user is blocked.

Returns a session for the newly created user.

**Parameters:**

- `registrationToken` (`String`) *(required)*
- `password` (`String`) *(required)*

#### `startPasswordReset`

```dart
Future<UuidValue> startPasswordReset({required String email})
```

Requests a password reset for [email].

If the email address is registered, an email with reset instructions will
be send out. If the email is unknown, this method will have no effect.

Always returns a password reset request ID, which can be used to complete
the reset. If the email is not registered, the returned ID will not be
valid.

Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
- [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  made too many attempts trying to request a password reset.

**Parameters:**

- `email` (`String`) *(required)*

#### `verifyPasswordResetCode`

```dart
Future<String> verifyPasswordResetCode({required UuidValue passwordResetRequestId, required String verificationCode})
```

Verifies a password reset code and returns a finishPasswordResetToken
that can be used to finish the password reset.

Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
- [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  request has already expired.
- [EmailAccountPasswordResetExceptionReason.tooManyAttempts] if the user has
  made too many attempts trying to verify the password reset.
- [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  for the given [passwordResetRequestId] or [verificationCode] is invalid.

If multiple steps are required to complete the password reset, this endpoint
should be overridden to return credentials for the next step instead
of the credentials for setting the password.

**Parameters:**

- `passwordResetRequestId` (`UuidValue`) *(required)*
- `verificationCode` (`String`) *(required)*

#### `finishPasswordReset`

```dart
Future<void> finishPasswordReset({required String finishPasswordResetToken, required String newPassword})
```

Completes a password reset request by setting a new password.

The [verificationCode] returned from [verifyPasswordResetCode] is used to
validate the password reset request.

Throws an [EmailAccountPasswordResetException] in case of errors, with reason:
- [EmailAccountPasswordResetExceptionReason.expired] if the password reset
  request has already expired.
- [EmailAccountPasswordResetExceptionReason.policyViolation] if the new
  password does not comply with the password policy.
- [EmailAccountPasswordResetExceptionReason.invalid] if no request exists
  for the given [passwordResetRequestId] or [verificationCode] is invalid.

Throws an [AuthUserBlockedException] if the auth user is blocked.

**Parameters:**

- `finishPasswordResetToken` (`String`) *(required)*
- `newPassword` (`String`) *(required)*

---

## class `EndpointGoogleIdp`

**Extends:** `EndpointGoogleIdpBase`

{@category Endpoint}

### Constructors

#### `EndpointGoogleIdp`

```dart
EndpointGoogleIdp(EndpointCaller caller)
```

### Properties

- **`name`** → `String`

### Methods

#### `login`

```dart
Future<AuthSuccess> login({required String idToken, required String? accessToken})
```

Validates a Google ID token and either logs in the associated user or
creates a new user account if the Google account ID is not yet known.

If a new user is created an associated [UserProfile] is also created.

**Parameters:**

- `idToken` (`String`) *(required)*
- `accessToken` (`String?`) *(required)*

---

## class `EndpointJwtRefresh`

**Extends:** `EndpointRefreshJwtTokens`

By extending [RefreshJwtTokensEndpoint], the JWT token refresh endpoint
is made available on the server and enables automatic token refresh on the client.
{@category Endpoint}

### Constructors

#### `EndpointJwtRefresh`

```dart
EndpointJwtRefresh(EndpointCaller caller)
```

### Properties

- **`name`** → `String`

### Methods

#### `refreshAccessToken`

```dart
Future<AuthSuccess> refreshAccessToken({required String refreshToken})
```

Creates a new token pair for the given [refreshToken].

Can throw the following exceptions:
-[RefreshTokenMalformedException]: refresh token is malformed and could
  not be parsed. Not expected to happen for tokens issued by the server.
-[RefreshTokenNotFoundException]: refresh token is unknown to the server.
  Either the token was deleted or generated by a different server.
-[RefreshTokenExpiredException]: refresh token has expired. Will happen
  only if it has not been used within configured `refreshTokenLifetime`.
-[RefreshTokenInvalidSecretException]: refresh token is incorrect, meaning
  it does not refer to the current secret refresh token. This indicates
  either a malfunctioning client or a malicious attempt by someone who has
  obtained the refresh token. In this case the underlying refresh token
  will be deleted, and access to it will expire fully when the last access
  token is elapsed.

This endpoint is unauthenticated, meaning the client won't include any
authentication information with the call.

**Parameters:**

- `refreshToken` (`String`) *(required)*

---

## abstract class `EndpointRef`

This class connects endpoints on the server with the client, it also
hooks up streams with the endpoint. Overridden by generated code.

### Constructors

#### `EndpointRef`

```dart
EndpointRef(EndpointCaller caller)
```

Creates a new [EndpointRef].

### Properties

- **`caller`** → `EndpointCaller` *(final)*

  Holds a reference to the caller class.

- **`client`** → `ServerpodClientShared` *(final)*

  Reference to the client.

- **`name`** → `String`

- **`stream`** → `Stream<SerializableModel>`

### Methods

#### `sendStreamMessage`

```dart
Future<void> sendStreamMessage(SerializableModel message)
```

Sends a message to the endpoint's stream.

**Parameters:**

- `message` (`SerializableModel`) *(required)*

#### `resetStream`

```dart
void resetStream()
```

Resets web socket stream, so it's possible to re-listen to endpoint
streams.

---

## abstract class `Evaluation`

**Implements:** `SerializableModel`

Result of evaluating one sample.

### Constructors

#### `Evaluation`

```dart
Evaluation({UuidValue? id, required UuidValue runId, Run? run, required UuidValue taskId, Task? task, required UuidValue sampleId, Sample? sample, required UuidValue modelId, Model? model, required UuidValue datasetId, Dataset? dataset, required List<Variant> variant, required String output, required List<ToolCallData> toolCalls, required int retryCount, String? error, required bool neverSucceeded, required double durationSeconds, bool? analyzerPassed, int? testsPassed, int? testsTotal, double? structureScore, String? failureReason, required int inputTokens, required int outputTokens, required int reasoningTokens, DateTime? createdAt})
```

#### `Evaluation.fromJson`

```dart
Evaluation.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`id`** → `UuidValue?`

  The database id, set if the object has been inserted into the
  database or if it has been fetched from the database. Otherwise,
  the id will be null.

- **`runId`** → `UuidValue`

- **`run`** → `Run?`

  The parent run.

- **`taskId`** → `UuidValue`

- **`task`** → `Task?`

  The parent task.

- **`sampleId`** → `UuidValue`

- **`sample`** → `Sample?`

  The sample that was evaluated.

- **`modelId`** → `UuidValue`

- **`model`** → `Model?`

  The model that was evaluated.

- **`datasetId`** → `UuidValue`

- **`dataset`** → `Dataset?`

  The dataset this sample belongs to (e.g., "flutter_qa_dataset").

- **`variant`** → `List<Variant>`

  Variant configuration.

- **`output`** → `String`

  The actual output generated by the model.

- **`toolCalls`** → `List<ToolCallData>`

  Tool calls made during evaluation.

- **`retryCount`** → `int`

  Number of times this sample was retried.

- **`error`** → `String?`

  Error message if sample failed.

- **`neverSucceeded`** → `bool`

  True if all retries failed (exclude from accuracy calculations).

- **`durationSeconds`** → `double`

  Total time for this sample in seconds.

- **`analyzerPassed`** → `bool?`

  Did flutter analyze pass?

- **`testsPassed`** → `int?`

  Number of tests passed.

- **`testsTotal`** → `int?`

  Total number of tests.

- **`structureScore`** → `double?`

  Code structure validation score (0.0-1.0).

- **`failureReason`** → `String?`

  Categorized failure reason: "analyzer_error", "test_failure", "missing_structure".

- **`inputTokens`** → `int`

  Input tokens for this sample.

- **`outputTokens`** → `int`

  Output tokens for this sample.

- **`reasoningTokens`** → `int`

  Reasoning tokens for this sample.

- **`createdAt`** → `DateTime`

  When this evaluation was run.

### Methods

#### `copyWith`

```dart
Evaluation copyWith({UuidValue? id, UuidValue? runId, Run? run, UuidValue? taskId, Task? task, UuidValue? sampleId, Sample? sample, UuidValue? modelId, Model? model, UuidValue? datasetId, Dataset? dataset, List<Variant>? variant, String? output, List<ToolCallData>? toolCalls, int? retryCount, String? error, bool? neverSucceeded, double? durationSeconds, bool? analyzerPassed, int? testsPassed, int? testsTotal, double? structureScore, String? failureReason, int? inputTokens, int? outputTokens, int? reasoningTokens, DateTime? createdAt})
```

Returns a shallow copy of this [Evaluation]
with some or all fields replaced by the given arguments.

**Parameters:**

- `id` (`UuidValue?`)
- `runId` (`UuidValue?`)
- `run` (`Run?`)
- `taskId` (`UuidValue?`)
- `task` (`Task?`)
- `sampleId` (`UuidValue?`)
- `sample` (`Sample?`)
- `modelId` (`UuidValue?`)
- `model` (`Model?`)
- `datasetId` (`UuidValue?`)
- `dataset` (`Dataset?`)
- `variant` (`List<Variant>?`)
- `output` (`String?`)
- `toolCalls` (`List<ToolCallData>?`)
- `retryCount` (`int?`)
- `error` (`String?`)
- `neverSucceeded` (`bool?`)
- `durationSeconds` (`double?`)
- `analyzerPassed` (`bool?`)
- `testsPassed` (`int?`)
- `testsTotal` (`int?`)
- `structureScore` (`double?`)
- `failureReason` (`String?`)
- `inputTokens` (`int?`)
- `outputTokens` (`int?`)
- `reasoningTokens` (`int?`)
- `createdAt` (`DateTime?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## class `FileUploader`

The file uploader uploads files to Serverpod's cloud storage. On the server
you can setup a custom storage service, such as S3 or Google Cloud. To
directly upload a file, you first need to retrieve an upload description
from your server. After the file is uploaded, make sure to notify the server
by calling the verifyDirectFileUpload on the current Session object.

### Constructors

#### `FileUploader`

```dart
FileUploader(String uploadDescription)
```

Creates a new FileUploader from an [uploadDescription] created by the
server.

### Methods

#### `uploadByteData`

```dart
Future<bool> uploadByteData(ByteData byteData)
```

Uploads a file contained by a [ByteData] object, returns true if
successful.

**Parameters:**

- `byteData` (`ByteData`) *(required)*

#### `upload`

```dart
Future<bool> upload(Stream<List<int>> stream, [int? length])
```

Uploads a file from a [Stream], returns true if successful. The [length]
of the stream is optional, but if it's not provided for a multipart upload,
the entire file will be buffered in memory.

**Parameters:**

- `stream` (`Stream<List<int>>`) *(required)*
- `length` (`int?`)

---

## abstract class `Greeting`

**Implements:** `SerializableModel`

A greeting message which can be sent to or from the server.

### Constructors

#### `Greeting`

```dart
Greeting({required String message, required String author, required DateTime timestamp})
```

#### `Greeting.fromJson`

```dart
Greeting.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`message`** → `String`

  The greeting message.

- **`author`** → `String`

  The author of the greeting message.

- **`timestamp`** → `DateTime`

  The time when the message was created.

### Methods

#### `copyWith`

```dart
Greeting copyWith({String? message, String? author, DateTime? timestamp})
```

Returns a shallow copy of this [Greeting]
with some or all fields replaced by the given arguments.

**Parameters:**

- `message` (`String?`)
- `author` (`String?`)
- `timestamp` (`DateTime?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## class `HalfVector`

Represents a vector of half-precision float values.

### Constructors

#### `HalfVector`

```dart
HalfVector(List<double> _vec)
```

Creates a new [HalfVector] from a list of double values.

#### `HalfVector.fromBinary`

```dart
HalfVector.fromBinary(Uint8List bytes)
```

Creates a [HalfVector] from its binary representation.

### Methods

#### `toBinary`

```dart
Uint8List toBinary()
```

Converts the [HalfVector] to its binary representation.

#### `toList`

```dart
List<double> toList()
```

Returns the half-precision vector as a list of double values.

---

## class `MethodCallContext`

Context for a method call.

### Constructors

#### `MethodCallContext`

```dart
MethodCallContext({required String endpointName, required String methodName, required Map<String, dynamic> arguments})
```

Creates a new [MethodCallContext].

### Properties

- **`endpointName`** → `String` *(final)*

  Name of the called endpoint.

- **`methodName`** → `String` *(final)*

  Name of the called endpoint method.

- **`arguments`** → `Map<String, dynamic>` *(final)*

  Arguments passed to the method.

---

## abstract class `MethodStreamException`

**Implements:** `Exception`

Exceptions thrown by the [ClientMethodStreamManager].

### Constructors

#### `MethodStreamException`

```dart
MethodStreamException()
```

Creates a new [MethodStreamException].

---

## class `MethodStreamMessage`

**Extends:** `WebSocketMessage`

**Implements:** `WebSocketMessageInfo`

A message sent to a method stream.

### Constructors

#### `MethodStreamMessage`

```dart
MethodStreamMessage(Map<dynamic, dynamic> data, SerializationManager _serializationManager)
```

Creates a new [MethodStreamMessage].
The [object] must be an object processed by the
[SerializationManager.wrapWithClassName] method.

### Properties

- **`endpoint`** → `String` *(final)*

  The endpoint the message is sent to.

- **`method`** → `String` *(final)*

  The method the message is sent to.

- **`connectionId`** → `UuidValue` *(final)*

  The connection id that uniquely identifies the stream.

- **`parameter`** → `String?` *(final)*

  The parameter the message is sent to.
  If this is null the message is sent to the return stream of the method.

- **`object`** → `dynamic` *(final)*

  The object that was sent.

### Methods

#### `static buildMessage`

```dart
static String buildMessage({required String endpoint, required String method, required UuidValue connectionId, String? parameter, required dynamic object, required SerializationManager serializationManager})
```

Builds a [MethodStreamMessage] message.

**Parameters:**

- `endpoint` (`String`) *(required)*
- `method` (`String`) *(required)*
- `connectionId` (`UuidValue`) *(required)*
- `parameter` (`String?`)
- `object` (`dynamic`) *(required)*
- `serializationManager` (`SerializationManager`) *(required)*

---

## class `MethodStreamSerializableException`

**Extends:** `WebSocketMessage`

**Implements:** `WebSocketMessageInfo`

A serializable exception sent over a method stream.

### Constructors

#### `MethodStreamSerializableException`

```dart
MethodStreamSerializableException(Map<dynamic, dynamic> data, SerializationManager serializationManager)
```

Creates a new [MethodStreamSerializableException].
The [exception] must be a serializable exception processed by the
[SerializationManager.wrapWithClassName] method.

### Properties

- **`endpoint`** → `String` *(final)*

  The endpoint the message is sent to.

- **`method`** → `String` *(final)*

  The method the message is sent to.

- **`connectionId`** → `UuidValue` *(final)*

  The connection id that uniquely identifies the stream.

- **`parameter`** → `String?` *(final)*

  The parameter the message is sent to.
  If this is null the message is sent to the return stream of the method.

- **`exception`** → `SerializableException` *(final)*

  The serializable exception sent.

### Methods

#### `static buildMessage`

```dart
static String buildMessage({required String endpoint, required String method, required UuidValue connectionId, String? parameter, required dynamic object, required SerializationManager serializationManager})
```

Builds a [MethodStreamSerializableException] message.
The [exception] must be a serializable exception processed by the
[SerializationManager.wrapWithClassName] method.

**Parameters:**

- `endpoint` (`String`) *(required)*
- `method` (`String`) *(required)*
- `connectionId` (`UuidValue`) *(required)*
- `parameter` (`String?`)
- `object` (`dynamic`) *(required)*
- `serializationManager` (`SerializationManager`) *(required)*

---

## abstract class `Model`

**Implements:** `SerializableModel`

An LLM being evaluated.

### Constructors

#### `Model`

```dart
Model({UuidValue? id, required String name})
```

#### `Model.fromJson`

```dart
Model.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`id`** → `UuidValue?`

  The database id, set if the object has been inserted into the
  database or if it has been fetched from the database. Otherwise,
  the id will be null.

- **`name`** → `String`

  Unique identifier for the model.

### Methods

#### `copyWith`

```dart
Model copyWith({UuidValue? id, String? name})
```

Returns a shallow copy of this [Model]
with some or all fields replaced by the given arguments.

**Parameters:**

- `id` (`UuidValue?`)
- `name` (`String?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## abstract class `ModuleEndpointCaller`

**Extends:** `EndpointCaller`

This class is used to connect modules with the client. Overridden by
generated code.

### Constructors

#### `ModuleEndpointCaller`

```dart
ModuleEndpointCaller(ServerpodClientShared client)
```

Creates a new [ModuleEndpointCaller].

### Properties

- **`client`** → `ServerpodClientShared` *(final)*

  Reference to the client.

### Methods

#### `callServerEndpoint`

```dart
Future<T> callServerEndpoint(String endpoint, String method, Map<String, dynamic> args, {bool authenticated})
```

**Parameters:**

- `endpoint` (`String`) *(required)*
- `method` (`String`) *(required)*
- `args` (`Map<String, dynamic>`) *(required)*
- `authenticated` (`bool`)

#### `callStreamingServerEndpoint`

```dart
dynamic callStreamingServerEndpoint(String endpoint, String method, Map<String, dynamic> args, Map<String, Stream<dynamic>> streams, {bool authenticated})
```

**Parameters:**

- `endpoint` (`String`) *(required)*
- `method` (`String`) *(required)*
- `args` (`Map<String, dynamic>`) *(required)*
- `streams` (`Map<String, Stream<dynamic>>`) *(required)*
- `authenticated` (`bool`)

---

## class `Modules`

### Constructors

#### `Modules`

```dart
Modules(Client client)
```

### Properties

- **`serverpod_auth_idp`** → `Caller` *(final)*

- **`serverpod_auth_core`** → `Caller` *(final)*

---

## class `MutexRefresherClientAuthKeyProvider`

**Implements:** `RefresherClientAuthKeyProvider`

A [RefresherClientAuthKeyProvider] decorator that adds a mutex lock to
prevent concurrent refresh calls. Actual auth header getter and refresh
logic is delegated to the [_delegate] provider.

### Constructors

#### `MutexRefresherClientAuthKeyProvider`

```dart
MutexRefresherClientAuthKeyProvider(RefresherClientAuthKeyProvider _delegate)
```

Creates a new [MutexRefresherClientAuthKeyProvider].

### Properties

- **`authHeaderValue`** → `Future<String?>`

### Methods

#### `refreshAuthKey`

```dart
Future<RefreshAuthKeyResult> refreshAuthKey({bool force})
```

Refreshes the authentication key with locking to prevent concurrent calls.

**Parameters:**

- `force` (`bool`)

---

## class `OpenMethodStreamCommand`

**Extends:** `WebSocketMessage`

**Implements:** `WebSocketMessageInfo`

A message sent over a websocket connection to open a websocket stream of
data to an endpoint method.

An [OpenMethodStreamResponse] should be sent in response to this message.

### Constructors

#### `OpenMethodStreamCommand`

```dart
OpenMethodStreamCommand(Map<dynamic, dynamic> data)
```

Creates a new [OpenMethodStreamCommand] message.

### Properties

- **`endpoint`** → `String` *(final)*

  The endpoint to call.

- **`method`** → `String` *(final)*

  The method to call.

- **`encodedArgs`** → `String` *(final)*

  The JSON encoded arguments to pass to the method.

- **`inputStreams`** → `List<String>` *(final)*

  The input streams that should be opened.

- **`connectionId`** → `UuidValue` *(final)*

  The connection id that uniquely identifies the stream.

- **`authentication`** → `String?` *(final)*

  The authentication value as it is sent across the transport layer.

### Methods

#### `static buildMessage`

```dart
static String buildMessage({required String endpoint, required String method, required Map<String, dynamic> args, required UuidValue connectionId, required List<String> inputStreams, String? authentication})
```

Creates a new [OpenMethodStreamCommand].

**Parameters:**

- `endpoint` (`String`) *(required)*
- `method` (`String`) *(required)*
- `args` (`Map<String, dynamic>`) *(required)*
- `connectionId` (`UuidValue`) *(required)*
- `inputStreams` (`List<String>`) *(required)*
- `authentication` (`String?`)

---

## class `OpenMethodStreamException`

**Extends:** `MethodStreamException`

Thrown if opening a method stream fails.

### Constructors

#### `OpenMethodStreamException`

```dart
OpenMethodStreamException(OpenMethodStreamResponseType responseType)
```

Creates a new [OpenMethodStreamException].

### Properties

- **`responseType`** → `OpenMethodStreamResponseType` *(final)*

  The response type that caused the exception.

---

## class `OpenMethodStreamResponse`

**Extends:** `WebSocketMessage`

**Implements:** `WebSocketMessageInfo`

A message sent over a websocket connection to respond to an
[OpenMethodStreamCommand].

### Constructors

#### `OpenMethodStreamResponse`

```dart
OpenMethodStreamResponse(Map<dynamic, dynamic> data)
```

Creates a new [OpenMethodStreamResponse].

### Properties

- **`connectionId`** → `UuidValue` *(final)*

  The connection id that uniquely identifies the stream.

- **`endpoint`** → `String` *(final)*

  The endpoint called.

- **`method`** → `String` *(final)*

  The method called.

- **`responseType`** → `OpenMethodStreamResponseType` *(final)*

  The response type.

### Methods

#### `static buildMessage`

```dart
static String buildMessage({required UuidValue connectionId, required OpenMethodStreamResponseType responseType, required String endpoint, required String method})
```

Builds a new [OpenMethodStreamResponse] message.

**Parameters:**

- `connectionId` (`UuidValue`) *(required)*
- `responseType` (`OpenMethodStreamResponseType`) *(required)*
- `endpoint` (`String`) *(required)*
- `method` (`String`) *(required)*

---

## class `PingCommand`

**Extends:** `WebSocketMessage`

A message sent over a websocket connection to check if the connection is
still alive. The other end should respond with a [PongCommand].

### Constructors

#### `PingCommand`

```dart
PingCommand()
```

### Methods

#### `static buildMessage`

```dart
static String buildMessage()
```

Builds a [PingCommand] message.

---

## class `PongCommand`

**Extends:** `WebSocketMessage`

A response to a [PingCommand].

### Constructors

#### `PongCommand`

```dart
PongCommand()
```

### Methods

#### `static buildMessage`

```dart
static String buildMessage()
```

Builds a [PongCommand] message.

---

## class `Protocol`

**Extends:** `SerializationManager`

### Constructors

#### `Protocol`

```dart
Protocol()
```

### Methods

#### `static getClassNameFromObjectJson`

```dart
static String? getClassNameFromObjectJson(dynamic data)
```

**Parameters:**

- `data` (`dynamic`) *(required)*

#### `deserialize`

```dart
T deserialize(dynamic data, [Type? t])
```

**Parameters:**

- `data` (`dynamic`) *(required)*
- `t` (`Type?`)

#### `static getClassNameForType`

```dart
static String? getClassNameForType(Type type)
```

**Parameters:**

- `type` (`Type`) *(required)*

#### `getClassNameForObject`

```dart
String? getClassNameForObject(Object? data)
```

**Parameters:**

- `data` (`Object?`) *(required)*

#### `deserializeByClassName`

```dart
dynamic deserializeByClassName(Map<String, dynamic> data)
```

**Parameters:**

- `data` (`Map<String, dynamic>`) *(required)*

#### `mapRecordToJson`

```dart
Map<String, dynamic>? mapRecordToJson(Record? record)
```

Maps any `Record`s known to this [Protocol] to their JSON representation

Throws in case the record type is not known.

This method will return `null` (only) for `null` inputs.

**Parameters:**

- `record` (`Record?`) *(required)*

---

## abstract class `ProtocolSerialization`

The [ProtocolSerialization] defines a toJsonForProtocol method which makes it
possible to limit what fields are serialized

### Constructors

#### `ProtocolSerialization`

```dart
ProtocolSerialization()
```

### Methods

#### `toJsonForProtocol`

```dart
dynamic toJsonForProtocol()
```

Returns a JSON structure of the model, optimized for Protocol communication.

---

## abstract class `RefresherClientAuthKeyProvider`

**Implements:** `ClientAuthKeyProvider`

Provides the authentication key for the client, with a method to refresh it.

### Constructors

#### `RefresherClientAuthKeyProvider`

```dart
RefresherClientAuthKeyProvider()
```

### Methods

#### `refreshAuthKey`

```dart
Future<RefreshAuthKeyResult> refreshAuthKey({bool force})
```

Refreshes the authentication key and returns the result of the operation.
If the refresh is successful, should return [RefreshAuthKeyResult.success]
to retry requests that failed due to authentication errors. Be sure to
annotate the refresh endpoint with @unauthenticatedClientCall to avoid a
deadlock on the [authHeaderValue] getter on a refresh call. If the [force]
parameter is set to true, the refresh should be performed regardless of
skip conditions that the provider might have.

**Parameters:**

- `force` (`bool`)

---

## abstract class `Run`

**Implements:** `SerializableModel`

A collection of tasks executed together.

### Constructors

#### `Run`

```dart
Run({UuidValue? id, required String inspectId, required Status status, required List<String> variants, required String mcpServerVersion, required int batchRuntimeSeconds, List<Model>? models, List<Dataset>? datasets, List<Task>? tasks, DateTime? createdAt})
```

#### `Run.fromJson`

```dart
Run.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`id`** → `UuidValue?`

  The database id, set if the object has been inserted into the
  database or if it has been fetched from the database. Otherwise,
  the id will be null.

- **`inspectId`** → `String`

  InspectAI-generated Id.

- **`status`** → `Status`

  Run status (e.g., "complete", "inProgress", "failed").

- **`variants`** → `List<String>`

  The variant configurations used in this run.

- **`mcpServerVersion`** → `String`

  Version of the MCP server used during evaluation.

- **`batchRuntimeSeconds`** → `int`

  Total script runtime in seconds.

- **`models`** → `List<Model>?`

  List of models evaluated in this run.

- **`datasets`** → `List<Dataset>?`

  List of datasets evaluated in this run.

- **`tasks`** → `List<Task>?`

  List of Inspect AI task names that were run.

- **`createdAt`** → `DateTime`

  Creation time for this record.

### Methods

#### `copyWith`

```dart
Run copyWith({UuidValue? id, String? inspectId, Status? status, List<String>? variants, String? mcpServerVersion, int? batchRuntimeSeconds, List<Model>? models, List<Dataset>? datasets, List<Task>? tasks, DateTime? createdAt})
```

Returns a shallow copy of this [Run]
with some or all fields replaced by the given arguments.

**Parameters:**

- `id` (`UuidValue?`)
- `inspectId` (`String?`)
- `status` (`Status?`)
- `variants` (`List<String>?`)
- `mcpServerVersion` (`String?`)
- `batchRuntimeSeconds` (`int?`)
- `models` (`List<Model>?`)
- `datasets` (`List<Dataset>?`)
- `tasks` (`List<Task>?`)
- `createdAt` (`DateTime?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## abstract class `RunSummary`

**Implements:** `SerializableModel`

Metadata for the outcomes of a given [Run]. This is a separate table from [Run] because
otherwise each of these columns would have to be nullable on [Run], as they are generated
after the run is completed.

### Constructors

#### `RunSummary`

```dart
RunSummary({UuidValue? id, required UuidValue runId, Run? run, required int totalTasks, required int totalSamples, required double avgAccuracy, required int totalTokens, required int inputTokens, required int outputTokens, required int reasoningTokens, DateTime? createdAt})
```

#### `RunSummary.fromJson`

```dart
RunSummary.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`id`** → `UuidValue?`

  The database id, set if the object has been inserted into the
  database or if it has been fetched from the database. Otherwise,
  the id will be null.

- **`runId`** → `UuidValue`

- **`run`** → `Run?`

  Run this summary belongs to.

- **`totalTasks`** → `int`

  Number of tasks in this run.

- **`totalSamples`** → `int`

  Total number of samples evaluated.

- **`avgAccuracy`** → `double`

  Average accuracy across all tasks (0.0 to 1.0).

- **`totalTokens`** → `int`

  Total token usage.

- **`inputTokens`** → `int`

  Input tokens used.

- **`outputTokens`** → `int`

  Output tokens generated.

- **`reasoningTokens`** → `int`

  Reasoning tokens used (for models that support it).

- **`createdAt`** → `DateTime`

  Creation time for this record.

### Methods

#### `copyWith`

```dart
RunSummary copyWith({UuidValue? id, UuidValue? runId, Run? run, int? totalTasks, int? totalSamples, double? avgAccuracy, int? totalTokens, int? inputTokens, int? outputTokens, int? reasoningTokens, DateTime? createdAt})
```

Returns a shallow copy of this [RunSummary]
with some or all fields replaced by the given arguments.

**Parameters:**

- `id` (`UuidValue?`)
- `runId` (`UuidValue?`)
- `run` (`Run?`)
- `totalTasks` (`int?`)
- `totalSamples` (`int?`)
- `avgAccuracy` (`double?`)
- `totalTokens` (`int?`)
- `inputTokens` (`int?`)
- `outputTokens` (`int?`)
- `reasoningTokens` (`int?`)
- `createdAt` (`DateTime?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## abstract class `Sample`

**Implements:** `SerializableModel`

A single challenge to be presented to a [Model] and evaluated by one or more [Scorer]s.

### Constructors

#### `Sample`

```dart
Sample({UuidValue? id, required String name, required UuidValue datasetId, Dataset? dataset, required String input, required String target, List<SampleTagXref>? tagsXref, bool? isActive, DateTime? createdAt})
```

#### `Sample.fromJson`

```dart
Sample.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`id`** → `UuidValue?`

  The database id, set if the object has been inserted into the
  database or if it has been fetched from the database. Otherwise,
  the id will be null.

- **`name`** → `String`

  Short sample name/ID (e.g., "dart_futures_vs_streams").

- **`datasetId`** → `UuidValue`

- **`dataset`** → `Dataset?`

  The dataset this sample belongs to (e.g., "dart_qa_dataset").

- **`input`** → `String`

  The input prompt/question for the model.

- **`target`** → `String`

  The expected answer or grading guidance.

- **`tagsXref`** → `List<SampleTagXref>?`

  Tags associated with this sample (e.g., ["dart", "flutter"]).
  Technically, this relationship only reaches the cross-reference table,
  not the tags themselves.

- **`isActive`** → `bool`

  True if the sample is still active and included in eval runs.

- **`createdAt`** → `DateTime`

  Creation time for this record.

### Methods

#### `copyWith`

```dart
Sample copyWith({UuidValue? id, String? name, UuidValue? datasetId, Dataset? dataset, String? input, String? target, List<SampleTagXref>? tagsXref, bool? isActive, DateTime? createdAt})
```

Returns a shallow copy of this [Sample]
with some or all fields replaced by the given arguments.

**Parameters:**

- `id` (`UuidValue?`)
- `name` (`String?`)
- `datasetId` (`UuidValue?`)
- `dataset` (`Dataset?`)
- `input` (`String?`)
- `target` (`String?`)
- `tagsXref` (`List<SampleTagXref>?`)
- `isActive` (`bool?`)
- `createdAt` (`DateTime?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## abstract class `SampleTagXref`

**Implements:** `SerializableModel`

Cross reference table for samples and tags.

### Constructors

#### `SampleTagXref`

```dart
SampleTagXref({int? id, required UuidValue sampleId, Sample? sample, required UuidValue tagId, Tag? tag})
```

#### `SampleTagXref.fromJson`

```dart
SampleTagXref.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`id`** → `int?`

  The database id, set if the object has been inserted into the
  database or if it has been fetched from the database. Otherwise,
  the id will be null.

- **`sampleId`** → `UuidValue`

- **`sample`** → `Sample?`

- **`tagId`** → `UuidValue`

- **`tag`** → `Tag?`

### Methods

#### `copyWith`

```dart
SampleTagXref copyWith({int? id, UuidValue? sampleId, Sample? sample, UuidValue? tagId, Tag? tag})
```

Returns a shallow copy of this [SampleTagXref]
with some or all fields replaced by the given arguments.

**Parameters:**

- `id` (`int?`)
- `sampleId` (`UuidValue?`)
- `sample` (`Sample?`)
- `tagId` (`UuidValue?`)
- `tag` (`Tag?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## abstract class `Scorer`

**Implements:** `SerializableModel`

Ye who watch the watchers.

### Constructors

#### `Scorer`

```dart
Scorer({UuidValue? id, required String name})
```

#### `Scorer.fromJson`

```dart
Scorer.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`id`** → `UuidValue?`

  The database id, set if the object has been inserted into the
  database or if it has been fetched from the database. Otherwise,
  the id will be null.

- **`name`** → `String`

  Name of the scorer (e.g., "bleu").

### Methods

#### `copyWith`

```dart
Scorer copyWith({UuidValue? id, String? name})
```

Returns a shallow copy of this [Scorer]
with some or all fields replaced by the given arguments.

**Parameters:**

- `id` (`UuidValue?`)
- `name` (`String?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## abstract class `ScorerResult`

**Implements:** `SerializableModel`

A scorer's assessment of a task.

### Constructors

#### `ScorerResult`

```dart
ScorerResult({UuidValue? id, required UuidValue scorerId, Scorer? scorer, required UuidValue evaluationId, Evaluation? evaluation, required ScorerResultData data})
```

#### `ScorerResult.fromJson`

```dart
ScorerResult.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`id`** → `UuidValue?`

  The database id, set if the object has been inserted into the
  database or if it has been fetched from the database. Otherwise,
  the id will be null.

- **`scorerId`** → `UuidValue`

- **`scorer`** → `Scorer?`

  Scorer this summary belongs to.

- **`evaluationId`** → `UuidValue`

- **`evaluation`** → `Evaluation?`

  Whether this scorer data is for a baseline run.

- **`data`** → `ScorerResultData`

  Flexible data archived by the scorer.

### Methods

#### `copyWith`

```dart
ScorerResult copyWith({UuidValue? id, UuidValue? scorerId, Scorer? scorer, UuidValue? evaluationId, Evaluation? evaluation, ScorerResultData? data})
```

Returns a shallow copy of this [ScorerResult]
with some or all fields replaced by the given arguments.

**Parameters:**

- `id` (`UuidValue?`)
- `scorerId` (`UuidValue?`)
- `scorer` (`Scorer?`)
- `evaluationId` (`UuidValue?`)
- `evaluation` (`Evaluation?`)
- `data` (`ScorerResultData?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## abstract class `SerializableException`

**Implements:** `SerializableModel`, `Exception`

This is `SerializableException` that can be used to pass Domain exceptions
from the Server to the Client

You can `throw SerializableException()`

Based on issue [#486](https://github.com/serverpod/serverpod/issues/486)

### Constructors

#### `SerializableException`

```dart
SerializableException()
```

Const constructor to pass empty exception with `statusCode 500`

### Methods

#### `toJson`

```dart
dynamic toJson()
```

---

## abstract class `SerializableModel`

The [SerializableModel] is the base interface for all serializable objects in
Serverpod, except primitives.

### Constructors

#### `SerializableModel`

```dart
SerializableModel()
```

### Methods

#### `toJson`

```dart
dynamic toJson()
```

Returns a serialized JSON structure of the model which also includes
fields used by the database.

---

## abstract class `SerializationManager`

The [SerializationManager] is responsible for creating objects from a
serialization, but also for serializing objects. This class is typically
extended by generated code.

### Constructors

#### `SerializationManager`

```dart
SerializationManager()
```

### Methods

#### `decode`

```dart
T decode(String data, [Type? t])
```

Decodes the provided json [String] to an object of type [t] or [T].

**Parameters:**

- `data` (`String`) *(required)*
- `t` (`Type?`)

#### `decodeWithType`

```dart
Object? decodeWithType(String data)
```

Decodes the provided json [String] if it has been encoded with
[encodeWithType].

**Parameters:**

- `data` (`String`) *(required)*

#### `deserialize`

```dart
T deserialize(dynamic data, [Type? t])
```

Deserialize the provided json [data] to an object of type [t] or [T].

**Parameters:**

- `data` (`dynamic`) *(required)*
- `t` (`Type?`)

#### `getClassNameForObject`

```dart
String? getClassNameForObject(Object? data)
```

Get the className for the provided object.

**Parameters:**

- `data` (`Object?`) *(required)*

#### `deserializeByClassName`

```dart
dynamic deserializeByClassName(Map<String, dynamic> data)
```

Deserialize the provided json [data] by using the className stored in the [data].

**Parameters:**

- `data` (`Map<String, dynamic>`) *(required)*

#### `wrapWithClassName`

```dart
Map<String, dynamic> wrapWithClassName(Object? data)
```

Wraps serialized data with its class name so that it can be deserialized
with [deserializeByClassName].

**Parameters:**

- `data` (`Object?`) *(required)*

#### `static encode`

```dart
static String encode(Object? object, {bool formatted, bool encodeForProtocol})
```

Encode the provided [object] to a Json-formatted [String].
If [formatted] is true, the output will be formatted with two spaces
indentation.

**Parameters:**

- `object` (`Object?`) *(required)*
- `formatted` (`bool`)
- `encodeForProtocol` (`bool`)

#### `static encodeForProtocol`

```dart
static String encodeForProtocol(Object? object, {bool formatted})
```

Encode the provided [object] to a Json-formatted [String].
if object implements [ProtocolSerialization] interface then
[toJsonForProtocol] it will be used instead of [toJson] method

**Parameters:**

- `object` (`Object?`) *(required)*
- `formatted` (`bool`)

#### `encodeWithType`

```dart
String encodeWithType(Object? object, {bool formatted})
```

Encode the provided [object] to a json-formatted [String], include class
name so that it can be decoded even if the class is unknown.
If [formatted] is true, the output will be formatted with two spaces
indentation.

**Parameters:**

- `object` (`Object?`) *(required)*
- `formatted` (`bool`)

#### `encodeWithTypeForProtocol`

```dart
String encodeWithTypeForProtocol(Object? object, {bool formatted})
```

Encode the provided [object] to a Json-formatted [String], including the
class name so that it can be decoded even if the class is unknown.
If [formatted] is true, the output will be formatted with two spaces
indentation. If [object] implements [ProtocolSerialization] interface, then
[toJsonForProtocol] will be used instead of the [toJson] method.

**Parameters:**

- `object` (`Object?`) *(required)*
- `formatted` (`bool`)

---

## class `ServerpodClientBadRequest`

**Extends:** `ServerpodClientException`

Thrown if the client created a malformed or invalid request
to the server.

### Constructors

#### `ServerpodClientBadRequest`

```dart
ServerpodClientBadRequest([String? message])
```

Creates a Bad Request Exception

---

## class `ServerpodClientEndpointNotFound`

**Extends:** `ServerpodClientGetEndpointException`

Thrown if the client tries to call an endpoint that was not generated.
This will typically happen if getting the endpoint by type while the user
has not defined the endpoint in their project.

### Constructors

#### `ServerpodClientEndpointNotFound`

```dart
ServerpodClientEndpointNotFound(Type type)
```

Creates an Endpoint Missing Exception.

---

## class `ServerpodClientException`

**Implements:** `Exception`

[Exception] thrown when errors in communication with the server occurs.

### Constructors

#### `ServerpodClientException`

```dart
ServerpodClientException(String message, int statusCode)
```

Creates a new [ServerpodClientException].

### Properties

- **`message`** → `String` *(final)*

  Error message sent from the server.

- **`statusCode`** → `int` *(final)*

  Http status code associated with the error.

---

## class `ServerpodClientForbidden`

**Extends:** `ServerpodClientException`

Thrown if the client is forbidden to perform the request.
This is typically due to missing permissions.

### Constructors

#### `ServerpodClientForbidden`

```dart
ServerpodClientForbidden()
```

Creates a Forbidden Exception

---

## abstract class `ServerpodClientGetEndpointException`

**Implements:** `Exception`

Thrown if not able to get an endpoint on the client by type.

### Constructors

#### `ServerpodClientGetEndpointException`

```dart
ServerpodClientGetEndpointException(String message)
```

Creates an Endpoint Missing Exception.

### Properties

- **`message`** → `String` *(final)*

  The error message to show to the user.

---

## class `ServerpodClientInternalServerError`

**Extends:** `ServerpodClientException`

Thrown if the server encountered an internal error.
This is typically a bug in the server code.

### Constructors

#### `ServerpodClientInternalServerError`

```dart
ServerpodClientInternalServerError()
```

Creates an Internal Server Error Exception

---

## class `ServerpodClientMultipleEndpointsFound`

**Extends:** `ServerpodClientGetEndpointException`

Thrown if the client tries to call an endpoint by type, but multiple
endpoints of that type exists. The user should disambiguate by using the
name parameter.

### Constructors

#### `ServerpodClientMultipleEndpointsFound`

```dart
ServerpodClientMultipleEndpointsFound(Type type, Iterable<EndpointRef> endpoints)
```

Creates an Multiple Endpoints Found Exception.

---

## class `ServerpodClientNotFound`

**Extends:** `ServerpodClientException`

Thrown if the requested resource was not found on the server.

### Constructors

#### `ServerpodClientNotFound`

```dart
ServerpodClientNotFound()
```

Creates a Not Found Exception

---

## abstract class `ServerpodClientRequestDelegate`

Defines the interface of the delegate that performs the actual request to the server
and returns the response data.
The delegate is used by [ServerpodClientShared] to perform the actual request.
It's overridden in different versions depending on if the dart:io library
is available.

### Constructors

#### `ServerpodClientRequestDelegate`

```dart
ServerpodClientRequestDelegate()
```

### Methods

#### `serverRequest`

```dart
Future<String> serverRequest(Uri url, {required String body, String? authenticationValue})
```

Performs the actual request to the server and returns the response data.

**Parameters:**

- `url` (`Uri`) *(required)*
- `body` (`String`) *(required)*
- `authenticationValue` (`String?`)

#### `close`

```dart
void close()
```

Closes the connection to the server.
This delegate should not be used after calling this.

---

## abstract class `ServerpodClientShared`

**Extends:** `EndpointCaller`

Superclass with shared methods for handling communication with the server.
Is typically overridden by generated code to provide implementations of methods for calling the server.

### Constructors

#### `ServerpodClientShared`

```dart
ServerpodClientShared(String host, SerializationManager serializationManager, {dynamic securityContext, AuthenticationKeyManager? authenticationKeyManager, required Duration? streamingConnectionTimeout, required Duration? connectionTimeout, void Function(MethodCallContext, Object, StackTrace)? onFailedCall, void Function(MethodCallContext)? onSucceededCall, bool? disconnectStreamsOnLostInternetConnection})
```

Creates a new ServerpodClientShared.

### Properties

- **`host`** → `String` *(final)*

  Full url to the Serverpod server. E.g. "https://example.com/"

- **`serializationManager`** → `SerializationManager` *(final)*

  The [SerializationManager] used to serialize objects sent to the server.

- **`authenticationKeyManager`** → `AuthenticationKeyManager?`

- **`moduleLookup`** → `Map<String, ModuleEndpointCaller>`

- **`streamingConnectionTimeout`** → `Duration` *(final)*

  Timeout when opening a web socket connection. If no message has been
  received within the timeout duration the socket will be closed.

- **`connectionTimeout`** → `Duration` *(final)*

  Timeout when calling a server endpoint. If no response has been received, defaults to 20 seconds.

- **`onFailedCall`** → `void Function(MethodCallContext, Object, StackTrace)?` *(final)*

  Callback when any call to the server fails or an exception is
  thrown.

- **`onSucceededCall`** → `void Function(MethodCallContext)?` *(final)*

  Callback when any call to the server succeeds.

- **`connectivityMonitor`** → `ConnectivityMonitor?`

- **`authKeyProvider`** → `ClientAuthKeyProvider?`

  Provides the authentication key for the client. Required to make
  authenticated requests. If not provided, all requests will be
  unauthenticated.

- **`streamingConnectionStatus`** → `StreamingConnectionStatus`

### Methods

#### `close`

```dart
void close()
```

Closes all open connections to the server.

#### `openStreamingConnection`

```dart
Future<void> openStreamingConnection({bool disconnectOnLostInternetConnection})
```

Open a streaming connection to the server.

**Parameters:**

- `disconnectOnLostInternetConnection` (`bool`)

#### `closeStreamingMethodConnections`

```dart
Future<void> closeStreamingMethodConnections({Object? exception})
```

Closes all open streaming method connections.

[exception] is an optional exception that will be thrown to all
listeners of open streams.

If [exception] is not provided, a [WebSocketClosedException] will be
thrown.

**Parameters:**

- `exception` (`Object?`)

#### `closeStreamingConnection`

```dart
Future<void> closeStreamingConnection()
```

Closes the streaming connection if it is open.

#### `addStreamingConnectionStatusListener`

```dart
void addStreamingConnectionStatusListener(void Function() listener)
```

Adds a callback for when the [streamingConnectionStatus] property is
changed.

**Parameters:**

- `listener` (`void Function()`) *(required)*

#### `removeStreamingConnectionStatusListener`

```dart
void removeStreamingConnectionStatusListener(void Function() listener)
```

Removes a connection status listener.

**Parameters:**

- `listener` (`void Function()`) *(required)*

#### `updateStreamingConnectionAuthenticationKey`

```dart
Future<void> updateStreamingConnectionAuthenticationKey()
```

Updates the authentication key if the streaming connection is open.
Note, the provided key will be converted/wrapped as a proper authentication header value
when sent to the server.

#### `callServerEndpoint`

```dart
Future<T> callServerEndpoint(String endpoint, String method, Map<String, dynamic> args, {bool authenticated})
```

**Parameters:**

- `endpoint` (`String`) *(required)*
- `method` (`String`) *(required)*
- `args` (`Map<String, dynamic>`) *(required)*
- `authenticated` (`bool`)

#### `callStreamingServerEndpoint`

```dart
dynamic callStreamingServerEndpoint(String endpoint, String method, Map<String, dynamic> args, Map<String, Stream<dynamic>> streams, {bool authenticated})
```

**Parameters:**

- `endpoint` (`String`) *(required)*
- `method` (`String`) *(required)*
- `args` (`Map<String, dynamic>`) *(required)*
- `streams` (`Map<String, Stream<dynamic>>`) *(required)*
- `authenticated` (`bool`)

---

## class `ServerpodClientUnauthorized`

**Extends:** `ServerpodClientException`

Thrown if the client fails to authenticate and is therefore
not authorized to perform the request.

### Constructors

#### `ServerpodClientUnauthorized`

```dart
ServerpodClientUnauthorized()
```

Creates an Unauthorized Exception

---

## class `SparseVector`

Represents a sparse vector that stores only non-zero elements.

### Constructors

#### `SparseVector`

```dart
SparseVector(List<double> value)
```

Creates a [SparseVector] from a list of doubles with all values.

#### `SparseVector.fromMap`

```dart
SparseVector.fromMap(Map<int, double> map, int dimensions)
```

Creates a [SparseVector] from a map of indices to values.

Map keys are indices and values are the vector values at those positions.
The [dimensions] parameter specifies the total vector length.

#### `SparseVector.fromBinary`

```dart
SparseVector.fromBinary(Uint8List bytes)
```

Creates a [SparseVector] from its binary representation.

### Properties

- **`dimensions`** → `int` *(final)*

  The total number of dimensions in the vector.

- **`indices`** → `List<int>` *(final)*

  The indices of non-zero values in the vector.

- **`values`** → `List<double>` *(final)*

  The non-zero values in the vector.

### Methods

#### `toBinary`

```dart
Uint8List toBinary()
```

Converts the sparse vector to its binary representation.

#### `toList`

```dart
List<double> toList()
```

Returns the sparse vector as a dense list of double values.

#### `static fromString`

```dart
static SparseVector fromString(String value)
```

Creates a [SparseVector] from a string representation.

**Parameters:**

- `value` (`String`) *(required)*

---

## class `StreamingConnectionHandler`

The StreamingConnection handler manages the web socket connection and its
state. It will automatically reconnect to the server if the connection is
lost. The [listener] will be notified whenever the connection state changes
and once every second when counting down to reconnect. The time between
reconnection attempts is specified with [retryEverySeconds], default is 5
seconds.

### Constructors

#### `StreamingConnectionHandler`

```dart
StreamingConnectionHandler({required ServerpodClientShared client, required void Function(StreamingConnectionHandlerState) listener, int retryEverySeconds})
```

Creates a new connection handler with the specified listener and interval
for reconnecting to the server.

### Properties

- **`client`** → `ServerpodClientShared` *(final)*

  The Serverpod client this StreamingConnectionHandler is managing.

- **`retryEverySeconds`** → `int` *(final)*

  Time in seconds between connection attempts. Default is 5 seconds.

- **`listener`** → `void Function(StreamingConnectionHandlerState)` *(final)*

  A listener that is called whenever the state of the connection handler
  changes.

- **`status`** → `StreamingConnectionHandlerState`

### Methods

#### `dispose`

```dart
void dispose()
```

Disposes the connection handler, but does not close the connection.

#### `connect`

```dart
void connect()
```

Opens a web socket channel to the server and attempts to keep it alive.

#### `close`

```dart
void close()
```

Disconnects the streaming connection if it is open.

---

## class `StreamingConnectionHandlerState`

Represents the state of the connection handler.

### Properties

- **`retryInSeconds`** → `int?` *(final)*

  Time in seconds until next connection attempt. Only set if the connection
  [status] is StreamingConnectionStatus.waitingToRetry.

- **`status`** → `StreamingConnectionStatus` *(final)*

  The status of the connection.

---

## abstract class `Tag`

**Implements:** `SerializableModel`

Category for a sample.

### Constructors

#### `Tag`

```dart
Tag({UuidValue? id, required String name, List<SampleTagXref>? samplesXref})
```

#### `Tag.fromJson`

```dart
Tag.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`id`** → `UuidValue?`

  The database id, set if the object has been inserted into the
  database or if it has been fetched from the database. Otherwise,
  the id will be null.

- **`name`** → `String`

  Unique identifier for the tag.

- **`samplesXref`** → `List<SampleTagXref>?`

  Samples associated with this tag.
  Technically, this relationship only reaches the cross-reference table,
  not the samples themselves.

### Methods

#### `copyWith`

```dart
Tag copyWith({UuidValue? id, String? name, List<SampleTagXref>? samplesXref})
```

Returns a shallow copy of this [Tag]
with some or all fields replaced by the given arguments.

**Parameters:**

- `id` (`UuidValue?`)
- `name` (`String?`)
- `samplesXref` (`List<SampleTagXref>?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## abstract class `Task`

**Implements:** `SerializableModel`

Results from evaluating one model against one dataset.

### Constructors

#### `Task`

```dart
Task({UuidValue? id, required String inspectId, required UuidValue modelId, Model? model, required UuidValue datasetId, Dataset? dataset, required UuidValue runId, Run? run, DateTime? createdAt})
```

#### `Task.fromJson`

```dart
Task.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`id`** → `UuidValue?`

  The database id, set if the object has been inserted into the
  database or if it has been fetched from the database. Otherwise,
  the id will be null.

- **`inspectId`** → `String`

  InspectAI-generated Id.

- **`modelId`** → `UuidValue`

- **`model`** → `Model?`

  Model identifier (e.g., "google/gemini-2.5-pro").

- **`datasetId`** → `UuidValue`

- **`dataset`** → `Dataset?`

  Dataset identifier (e.g., "flutter_qa_dataset").

- **`runId`** → `UuidValue`

- **`run`** → `Run?`

  Run this task belongs to.

- **`createdAt`** → `DateTime`

  When this task was evaluated.

### Methods

#### `copyWith`

```dart
Task copyWith({UuidValue? id, String? inspectId, UuidValue? modelId, Model? model, UuidValue? datasetId, Dataset? dataset, UuidValue? runId, Run? run, DateTime? createdAt})
```

Returns a shallow copy of this [Task]
with some or all fields replaced by the given arguments.

**Parameters:**

- `id` (`UuidValue?`)
- `inspectId` (`String?`)
- `modelId` (`UuidValue?`)
- `model` (`Model?`)
- `datasetId` (`UuidValue?`)
- `dataset` (`Dataset?`)
- `runId` (`UuidValue?`)
- `run` (`Run?`)
- `createdAt` (`DateTime?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## abstract class `TaskSummary`

**Implements:** `SerializableModel`

### Constructors

#### `TaskSummary`

```dart
TaskSummary({UuidValue? id, required UuidValue taskId, Task? task, required int totalSamples, required int passedSamples, required double accuracy, String? taskName, required int inputTokens, required int outputTokens, required int totalTokens, required int reasoningTokens, String? variant, required int executionTimeSeconds, required int samplesWithRetries, required int samplesNeverSucceeded, required int totalRetries})
```

#### `TaskSummary.fromJson`

```dart
TaskSummary.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`id`** → `UuidValue?`

  The database id, set if the object has been inserted into the
  database or if it has been fetched from the database. Otherwise,
  the id will be null.

- **`taskId`** → `UuidValue`

- **`task`** → `Task?`

  Task this summary belongs to.

- **`totalSamples`** → `int`

  Total number of samples in this task.

- **`passedSamples`** → `int`

  Number of samples that passed.

- **`accuracy`** → `double`

  Accuracy as a value from 0.0 to 1.0.

- **`taskName`** → `String?`

  The Inspect AI task function name (e.g., "qa_task").

- **`inputTokens`** → `int`

  Input tokens used.

- **`outputTokens`** → `int`

  Output tokens generated.

- **`totalTokens`** → `int`

  Total tokens used.

- **`reasoningTokens`** → `int`

  Reasoning tokens used (for models that support it).

- **`variant`** → `String?`

  Variant configuration used (e.g., "baseline", "dart_mcp").

- **`executionTimeSeconds`** → `int`

  Total execution time in seconds.

- **`samplesWithRetries`** → `int`

  Number of samples that needed retries.

- **`samplesNeverSucceeded`** → `int`

  Number of samples that failed all retries (excluded from accuracy).

- **`totalRetries`** → `int`

  Total number of retries across all samples.

### Methods

#### `copyWith`

```dart
TaskSummary copyWith({UuidValue? id, UuidValue? taskId, Task? task, int? totalSamples, int? passedSamples, double? accuracy, String? taskName, int? inputTokens, int? outputTokens, int? totalTokens, int? reasoningTokens, String? variant, int? executionTimeSeconds, int? samplesWithRetries, int? samplesNeverSucceeded, int? totalRetries})
```

Returns a shallow copy of this [TaskSummary]
with some or all fields replaced by the given arguments.

**Parameters:**

- `id` (`UuidValue?`)
- `taskId` (`UuidValue?`)
- `task` (`Task?`)
- `totalSamples` (`int?`)
- `passedSamples` (`int?`)
- `accuracy` (`double?`)
- `taskName` (`String?`)
- `inputTokens` (`int?`)
- `outputTokens` (`int?`)
- `totalTokens` (`int?`)
- `reasoningTokens` (`int?`)
- `variant` (`String?`)
- `executionTimeSeconds` (`int?`)
- `samplesWithRetries` (`int?`)
- `samplesNeverSucceeded` (`int?`)
- `totalRetries` (`int?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## abstract class `ToolCallData`

**Implements:** `SerializableModel`

Result of a tool call made during evaluation. Not a database table.

### Constructors

#### `ToolCallData`

```dart
ToolCallData({required String name, required Map<String, String> arguments})
```

#### `ToolCallData.fromJson`

```dart
ToolCallData.fromJson(Map<String, dynamic> jsonSerialization)
```

### Properties

- **`name`** → `String`

  Name of the tool.

- **`arguments`** → `Map<String, String>`

  Arguments passed to the tool.

### Methods

#### `copyWith`

```dart
ToolCallData copyWith({String? name, Map<String, String>? arguments})
```

Returns a shallow copy of this [ToolCallData]
with some or all fields replaced by the given arguments.

**Parameters:**

- `name` (`String?`)
- `arguments` (`Map<String, String>?`)

#### `toJson`

```dart
Map<String, dynamic> toJson()
```

---

## class `UnknownMessageException`

**Implements:** `Exception`

Exception thrown when an unknown message is received.

### Constructors

#### `UnknownMessageException`

```dart
UnknownMessageException(String jsonString, {Object? error, StackTrace? stackTrace})
```

Creates a new [UnknownMessageException].

### Properties

- **`jsonString`** → `String` *(final)*

  The JSON string that was not recognized.

- **`error`** → `Object?` *(final)*

  An optional error that occurred when parsing the message.

- **`stackTrace`** → `StackTrace?` *(final)*

  An optional stack trace for the error.

---

## class `Uuid`

uuid for Dart
Author: Yulian Kuncheff
Released under MIT License.

### Constructors

#### `Uuid`

```dart
Uuid({GlobalOptions? goptions})
```

Creates a new instance of the Uuid class.
Optionally you can pass in a [GlobalOptions] object to set global options
for all UUID generation.
[GlobalOptions.rng] is a [RNG] class that returns a list of random bytes.

Defaults rng function is `UuidUtil.cryptoRNG`

Example: Using MathRNG globally

```dart
var uuid = Uuid(options: {
  'grng': UuidUtil.mathRNG
})

// Generate a v4 (random) id that will use cryptRNG for its rng function
uuid.v4();
```

### Properties

- **`goptions`** → `GlobalOptions?` *(final)*

- **`NAMESPACE_DNS`** → `static String`

- **`NAMESPACE_URL`** → `static String`

- **`NAMESPACE_OID`** → `static String`

- **`NAMESPACE_X500`** → `static String`

- **`NAMESPACE_NIL`** → `static String`

### Methods

#### `static parse`

```dart
static List<int> parse(String uuid, {List<int>? buffer, int offset, bool validate, ValidationMode validationMode})
```

Parses the provided [uuid] into a list of byte values as a List&lt;int&gt;.
Can optionally be provided a [buffer] to write into and
 a positional [offset] for where to start inputting into the buffer.
Throws FormatException if the UUID is invalid. Optionally you can set
[validate] to false to disable validation of the UUID before parsing.

Example parsing a UUID string

```dart
var bytes = uuid.parse('797ff043-11eb-11e1-80d6-510998755d10');
// bytes-> [121, 127, 240, 67, 17, 235, 17, 225, 128, 214, 81, 9, 152, 117, 93, 16]
```

**Parameters:**

- `uuid` (`String`) *(required)*
- `buffer` (`List<int>?`)
- `offset` (`int`)
- `validate` (`bool`)
- `validationMode` (`ValidationMode`)

#### `static parseAsByteList`

```dart
static Uint8List parseAsByteList(String uuid, {List<int>? buffer, int offset, bool validate, ValidationMode validationMode})
```

Parses the provided [uuid] into a list of byte values as a Uint8List.
Can optionally be provided a [buffer] to write into and
 a positional [offset] for where to start inputting into the buffer.
Throws FormatException if the UUID is invalid. Optionally you can set
[validate] to false to disable validation of the UUID before parsing.

**Parameters:**

- `uuid` (`String`) *(required)*
- `buffer` (`List<int>?`)
- `offset` (`int`)
- `validate` (`bool`)
- `validationMode` (`ValidationMode`)

#### `static unparse`

```dart
static String unparse(List<int> buffer, {int offset})
```

Unparses a [buffer] of bytes and outputs a proper UUID string.
An optional [offset] is allowed if you want to start at a different point
in the buffer.
Throws an exception if the buffer does not have a length of 16

Example parsing and unparsing a UUID string

```dart
var uuidString = uuid.unparse(bytes);
// uuidString -> '797ff043-11eb-11e1-80d6-510998755d10'
```

**Parameters:**

- `buffer` (`List<int>`) *(required)*
- `offset` (`int`)

#### `static isValidUUID`

```dart
static bool isValidUUID({String fromString, Uint8List? fromByteList, ValidationMode validationMode, bool noDashes})
```

Validates the provided [uuid] to make sure it has all the necessary
components and formatting and returns a [bool]
You can choose to validate from a string or from a byte list based on
which parameter is passed.

**Parameters:**

- `fromString` (`String`)
- `fromByteList` (`Uint8List?`)
- `validationMode` (`ValidationMode`)
- `noDashes` (`bool`)

#### `v1`

```dart
String v1({Map<String, dynamic>? options, V1Options? config})
```

Generates a time-based version 1 UUID

By default it will generate a string based off current time, and will
return a string.

The first argument is an options map that takes various configuration
options detailed in the readme. This is going to be eventually deprecated.

The second argument is a [V1Options] object that takes the same options as
the options map. This is the preferred way to pass options.

http://tools.ietf.org/html/rfc4122.html#section-4.2.2

Example: Generate string UUID with fully-specified options
```dart
uuid.v1(options: {
    'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
    'clockSeq': 0x1234,
    'mSecs': new DateTime.utc(2011,11,01).millisecondsSinceEpoch,
    'nSecs': 5678
})   // -> "710b962e-041c-11e1-9234-0123456789ab"
```

**Parameters:**

- `options` (`Map<String, dynamic>?`)
- `config` (`V1Options?`)

#### `v1buffer`

```dart
List<int> v1buffer(List<int> buffer, {Map<String, dynamic>? options, V1Options? config, int offset})
```

Generates a time-based version 1 UUID into a provided buffer

By default it will generate a string based off current time, and will
place the result into the provided [buffer]. The [buffer] will also be returned..

Optionally an [offset] can be provided with a start position in the buffer.

The first optional argument is an options map that takes various configuration
options detailed in the readme. This is going to be eventually deprecated.

The second optional argument is a [V1Options] object that takes the same
options as the options map. This is the preferred way to pass options.

http://tools.ietf.org/html/rfc4122.html#section-4.2.2

Example: In-place generation of two binary IDs
```dart
// Generate two ids in an array
var myBuffer = new List(32); // -> []
uuid.v1buffer(myBuffer);
// -> [115, 189, 5, 128, 201, 91, 17, 225, 146, 52, 109, 0, 9, 0, 52, 128, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null, null]
uuid.v1buffer(myBuffer, offset: 16);
// -> [115, 189, 5, 128, 201, 91, 17, 225, 146, 52, 109, 0, 9, 0, 52, 128, 115, 189, 5, 129, 201, 91, 17, 225, 146, 52, 109, 0, 9, 0, 52, 128]

// Optionally use uuid.unparse() to get stringify the ids
uuid.unparse(myBuffer);    // -> '73bd0580-c95b-11e1-9234-6d0009003480'
uuid.unparse(myBuffer, offset: 16) // -> '73bd0581-c95b-11e1-9234-6d0009003480'
```

**Parameters:**

- `buffer` (`List<int>`) *(required)*
- `options` (`Map<String, dynamic>?`)
- `config` (`V1Options?`)
- `offset` (`int`)

#### `v1obj`

```dart
UuidValue v1obj({Map<String, dynamic>? options, V1Options? config})
```

Generates a time-based version 1 UUID as a [UuidValue] object

By default it will generate a string based off current time, and will
return it as a [UuidValue] object.

The first argument is an options map that takes various configuration
options detailed in the readme. This is going to be eventually deprecated.

The second argument is a [V1Options] object that takes the same options as
the options map. This is the preferred way to pass options.

http://tools.ietf.org/html/rfc4122.html#section-4.2.2

Example: UuidValue usage
```dart
uuidValue = uuid.v1Obj(options: {
    'node': [0x01, 0x23, 0x45, 0x67, 0x89, 0xab],
    'clockSeq': 0x1234,
    'mSecs': new DateTime.utc(2011,11,01).millisecondsSinceEpoch,
    'nSecs': 5678
}) // -> UuidValue{uuid: '710b962e-041c-11e1-9234-0123456789ab'}

print(uuidValue) -> // -> '710b962e-041c-11e1-9234-0123456789ab'
uuidValue.toBytes() -> // -> [...]
```

**Parameters:**

- `options` (`Map<String, dynamic>?`)
- `config` (`V1Options?`)

#### `v4`

```dart
String v4({Map<String, dynamic>? options, V4Options? config})
```

Generates a RNG version 4 UUID

By default it will generate a string based cryptoRNG, and will return
a string. If you wish to use crypto-strong RNG, pass in UuidUtil.cryptoRNG

The first argument is an options map that takes various configuration
options detailed in the readme. This is going to be eventually deprecated.

The second argument is a [V4Options] object that takes the same options as
the options map. This is the preferred way to pass options.

http://tools.ietf.org/html/rfc4122.html#section-4.4

Example: Generate string UUID with different RNG method

```dart
import 'package:uuid/uuid_util.dart';
uuid.v4(options: {
  'rng': UuidUtil.cryptoRNG
});
// -> "109156be-c4fb-41ea-b1b4-efe1671c5836"
```

Example: Generate string UUID with different RNG method and named parameters

```dart
import 'package:uuid/uuid_util.dart';
uuid.v4(options: {
  'rng': UuidUtil.mathRNG,
  'namedArgs': new Map.fromIterables([const Symbol('seed')],[1])
});
// -> "09a91894-e93f-4141-a3ec-82eb32f2a3ef"
```

Example: Generate string UUID with different RNG method and positional parameters

```dart
import 'package:uuid/uuid_util.dart';
uuid.v4(options: {
  'rng': UuidUtil.cryptoRNG,
  'positionalArgs': [1]
});
// -> "09a91894-e93f-4141-a3ec-82eb32f2a3ef"
```

Example: Generate string UUID with fully-specified options

```dart
uuid.v4(options: {
  'random': [
    0x10, 0x91, 0x56, 0xbe, 0xc4, 0xfb, 0xc1, 0xea,
    0x71, 0xb4, 0xef, 0xe1, 0x67, 0x1c, 0x58, 0x36
  ]
});
// -> "109156be-c4fb-41ea-b1b4-efe1671c5836"
```

**Parameters:**

- `options` (`Map<String, dynamic>?`)
- `config` (`V4Options?`)

#### `v4buffer`

```dart
List<int> v4buffer(List<int> buffer, {Map<String, dynamic>? options, V4Options? config, int offset})
```

Generates a RNG version 4 UUID into a provided buffer

By default it will generate a string based off cryptoRNG, and will
place the result into the provided [buffer]. The [buffer] will also be returned.
If you wish to have crypto-strong RNG, pass in UuidUtil.cryptoRNG.

Optionally an [offset] can be provided with a start position in the buffer.

The first optional argument is an options map that takes various configuration
options detailed in the readme. This is going to be eventually deprecated.

The second optional argument is a [V4Options] object that takes the same options as
the options map. This is the preferred way to pass options.

http://tools.ietf.org/html/rfc4122.html#section-4.4

Example: Generate two IDs in a single buffer

```dart
var myBuffer = new List(32);
uuid.v4buffer(myBuffer);
uuid.v4buffer(myBuffer, offset: 16);
```

**Parameters:**

- `buffer` (`List<int>`) *(required)*
- `options` (`Map<String, dynamic>?`)
- `config` (`V4Options?`)
- `offset` (`int`)

#### `v4obj`

```dart
UuidValue v4obj({Map<String, dynamic>? options, V4Options? config})
```

Generates a RNG version 4 UUID as a [UuidValue] object

By default it will generate a string based cryptoRNG, and will return
a [UuidValue] object. If you wish to use crypto-strong RNG, pass in UuidUtil.cryptoRNG

The first argument is an options map that takes various configuration
options detailed in the readme. This is going to be eventually deprecated.

The second argument is a [V4Options] object that takes the same options as
the options map. This is the preferred way to pass options.

http://tools.ietf.org/html/rfc4122.html#section-4.4

Example: UuidValue usage

```dart
uuidValue = uuid.v4obj(options: {
  'random': [
    0x10, 0x91, 0x56, 0xbe, 0xc4, 0xfb, 0xc1, 0xea,
    0x71, 0xb4, 0xef, 0xe1, 0x67, 0x1c, 0x58, 0x36
  ]
}) // -> UuidValue{uuid: '109156be-c4fb-41ea-b1b4-efe1671c5836'}

print(uuidValue) -> // -> '109156be-c4fb-41ea-b1b4-efe1671c5836'
uuidValue.toBytes() -> // -> [...]
```

**Parameters:**

- `options` (`Map<String, dynamic>?`)
- `config` (`V4Options?`)

#### `v5`

```dart
String v5(String? namespace, String? name, {Map<String, dynamic>? options, V5Options? config})
```

Generates a namespace & name-based version 5 UUID

By default it will generate a string based on a provided uuid namespace and
name, and will return a string.

The [namespace] parameter is the UUID namespace (as a String).
The [name] parameter is a String that will be converted to UTF-8 bytes.

For binary data input, use [v5FromBytes] instead.

The first optional argument is an options map that takes various configuration
options detailed in the readme. This is going to be eventually deprecated.

The second optional argument is a [V5Options] object that takes the same options as
the options map. This is the preferred way to pass options.

http://tools.ietf.org/html/rfc4122.html#section-4.4

Example: Generate string UUID with fully-specified options

```dart
uuid.v5(Namespace.url.value, 'www.google.com');
// -> "c74a196f-f19d-5ea9-bffd-a2742432fc9c"
```

**Parameters:**

- `namespace` (`String?`) *(required)*
- `name` (`String?`) *(required)*
- `options` (`Map<String, dynamic>?`)
- `config` (`V5Options?`)

#### `v5FromBytes`

```dart
String v5FromBytes(String? namespace, Uint8List? name, {V5Options? config})
```

Generates a namespace & name-based version 5 UUID from binary data

By default it will generate a string based on a provided uuid namespace and
binary name data, and will return a string.

The [namespace] parameter is the UUID namespace (as a String).
The [name] parameter is a Uint8List containing arbitrary binary data.
This allows for generating UUIDs from raw bytes as per RFC 4122 / RFC 9562.

The optional [config] argument is a [V5Options] object that takes configuration options.

http://tools.ietf.org/html/rfc4122.html#section-4.4

Example: Generate UUID from binary data

```dart
var binaryData = Uint8List.fromList([0x01, 0x02, 0x03, 0x04]);
uuid.v5FromBytes(Namespace.url.value, binaryData);
// -> "81156b66-5dc6-5909-8842-89a96a29d3ba"
```

**Parameters:**

- `namespace` (`String?`) *(required)*
- `name` (`Uint8List?`) *(required)*
- `config` (`V5Options?`)

#### `v5buffer`

```dart
List<int> v5buffer(String? namespace, String? name, List<int>? buffer, {Map<String, dynamic>? options, V5Options? config, int offset})
```

Generates a namespace & name-based version 5 UUID into a provided buffer

By default it will generate a string based on a provided uuid namespace and
place the result into the provided [buffer]. The [buffer] will also be returned.

The [namespace] parameter is the UUID namespace (as a String).
The [name] parameter is a String.

Optionally an [offset] can be provided with a start position in the buffer.

The first optional argument is an options map that takes various configuration
options detailed in the readme. This is going to be eventually deprecated.

The second optional argument is a [V5Options] object that takes the same options as
the options map. This is the preferred way to pass options.

http://tools.ietf.org/html/rfc4122.html#section-4.4

Example: Generate two IDs in a single buffer

```dart
var myBuffer = new List(32);
uuid.v5buffer(Uuid.NAMESPACE_URL, 'www.google.com', myBuffer);
uuid.v5buffer(Uuid.NAMESPACE_URL, 'www.google.com', myBuffer, offset: 16);
```

**Parameters:**

- `namespace` (`String?`) *(required)*
- `name` (`String?`) *(required)*
- `buffer` (`List<int>?`) *(required)*
- `options` (`Map<String, dynamic>?`)
- `config` (`V5Options?`)
- `offset` (`int`)

#### `v5FromBytesBuffer`

```dart
List<int> v5FromBytesBuffer(String? namespace, Uint8List? name, List<int>? buffer, {V5Options? config, int offset})
```

Generates a namespace & name-based version 5 UUID from binary data into a provided buffer

By default it will generate a string based on a provided uuid namespace and
binary name data, and place the result into the provided [buffer].
The [buffer] will also be returned.

The [namespace] parameter is the UUID namespace (as a String).
The [name] parameter is a Uint8List containing arbitrary binary data.

Optionally an [offset] can be provided with a start position in the buffer.

http://tools.ietf.org/html/rfc4122.html#section-4.4

Example: Generate two IDs in a single buffer

```dart
var myBuffer = new List(32);
var binaryData = Uint8List.fromList([0x01, 0x02, 0x03]);
uuid.v5FromBytesBuffer(Namespace.url.value, binaryData, myBuffer);
uuid.v5FromBytesBuffer(Namespace.url.value, binaryData, myBuffer, offset: 16);
```

**Parameters:**

- `namespace` (`String?`) *(required)*
- `name` (`Uint8List?`) *(required)*
- `buffer` (`List<int>?`) *(required)*
- `config` (`V5Options?`)
- `offset` (`int`)

#### `v5obj`

```dart
UuidValue v5obj(String? namespace, String? name, {Map<String, dynamic>? options, V5Options? config})
```

Generates a namespace & name-based version 5 UUID as a [UuidValue] object

By default it will generate a string based on a provided uuid namespace and
name, and will return a [UuidValue] object.

The [namespace] parameter is the UUID namespace (as a String).
The [name] parameter is a String.

The first optional argument is an options map that takes various configuration
options detailed in the readme. This is going to be eventually deprecated.

The second optional argument is a [V5Options] object that takes the same options as
the options map. This is the preferred way to pass options.

http://tools.ietf.org/html/rfc4122.html#section-4.4

Example: UuidValue usage
```dart
uuidValue = uuid.v5obj(Uuid.NAMESPACE_URL, 'www.google.com');
// -> UuidValue(uuid: "c74a196f-f19d-5ea9-bffd-a2742432fc9c")

print(uuidValue) -> // -> 'c74a196f-f19d-5ea9-bffd-a2742432fc9c'
uuidValue.toBytes() -> // -> [...]
```

**Parameters:**

- `namespace` (`String?`) *(required)*
- `name` (`String?`) *(required)*
- `options` (`Map<String, dynamic>?`)
- `config` (`V5Options?`)

#### `v5FromBytesObj`

```dart
UuidValue v5FromBytesObj(String? namespace, Uint8List? name, {V5Options? config})
```

Generates a namespace & name-based version 5 UUID from binary data as a [UuidValue] object

By default it will generate a string based on a provided uuid namespace and
binary name data, and will return a [UuidValue] object.

The [namespace] parameter is the UUID namespace (as a String).
The [name] parameter is a Uint8List containing arbitrary binary data.

http://tools.ietf.org/html/rfc4122.html#section-4.4

Example: UuidValue usage with binary data
```dart
var binaryData = Uint8List.fromList([0x01, 0x02, 0x03, 0x04]);
uuidValue = uuid.v5FromBytesObj(Namespace.url.value, binaryData);
// -> UuidValue(uuid: "81156b66-5dc6-5909-8842-89a96a29d3ba")

print(uuidValue) -> // -> '81156b66-5dc6-5909-8842-89a96a29d3ba'
uuidValue.toBytes() -> // -> [...]
```

**Parameters:**

- `namespace` (`String?`) *(required)*
- `name` (`Uint8List?`) *(required)*
- `config` (`V5Options?`)

#### `v6`

```dart
String v6({V6Options? config})
```

Generates a draft time-based version 6 UUID

By default it will generate a string based off current Gregorian epoch time
in milliseconds, and will return a string.

The first argument is a [V6Options] object that takes the same options as
the options map.

https://datatracker.ietf.org/doc/html/draft-ietf-uuidrev-rfc4122bis#name-uuid-version-6

**Parameters:**

- `config` (`V6Options?`)

#### `v6buffer`

```dart
List<int> v6buffer(List<int> buffer, {V6Options? config, int offset})
```

Generates a draft time-based version 1 UUID into a provided buffer

By default it will generate a string based off current Gregorian epoch time, and will
in milliseconds, and will place the result into the provided [buffer].
The [buffer] will also be returned.

Optionally an [offset] can be provided with a start position in the buffer.

The first optional argument is an options map that takes various configuration
options detailed in the readme. This is going to be eventually deprecated.

The second optional argument is a [V6Options] object that takes the same options as
the options map. This is the preferred way to pass options.

https://datatracker.ietf.org/doc/html/draft-ietf-uuidrev-rfc4122bis#name-uuid-version-6

**Parameters:**

- `buffer` (`List<int>`) *(required)*
- `config` (`V6Options?`)
- `offset` (`int`)

#### `v6obj`

```dart
UuidValue v6obj({V6Options? config})
```

Generates a draft time-based version 6 UUID as a [UuidValue] object

By default it will generate a string based off current Gregorian Epoch time
in milliseconds, and will return it as a [UuidValue] object.

The first argument is a [V6Options] object that takes the same options as
the options map. This is the preferred way to pass options.

https://datatracker.ietf.org/doc/html/draft-ietf-uuidrev-rfc4122bis#name-uuid-version-6

**Parameters:**

- `config` (`V6Options?`)

#### `v7`

```dart
String v7({V7Options? config})
```

Generates a draft time-based version 7 UUID as a [UuidValue] object

By default it will generate a string based off current Unix epoch time in
milliseconds, and will return a string.

The first argument is a [V7Options] object that takes the same options as
the options map.

https://datatracker.ietf.org/doc/html/draft-ietf-uuidrev-rfc4122bis#name-uuid-version-7

**Parameters:**

- `config` (`V7Options?`)

#### `v7buffer`

```dart
List<int> v7buffer(List<int> buffer, {V7Options? config, int offset})
```

Generates a draft time-based version 7 UUID into a provided buffer

By default it will generate a string based off current Unix epoch time in
milliseconds, and will place the result into the provided [buffer].
The [buffer] will also be returned..

Optionally an [offset] can be provided with a start position in the buffer.

The first optional argument is a [V7Options] object that takes the same options as
the options map.

https://datatracker.ietf.org/doc/html/draft-ietf-uuidrev-rfc4122bis#name-uuid-version-7

**Parameters:**

- `buffer` (`List<int>`) *(required)*
- `config` (`V7Options?`)
- `offset` (`int`)

#### `v7obj`

```dart
UuidValue v7obj({V7Options? config})
```

Generates a draft time-based version 7 UUID as a [UuidValue] object

By default it will generate a string based off current Unix epoch time in
milliseconds, and will return it as a [UuidValue] object.

The first argument is a [V7Options] object that takes the same options as
the options map.

https://datatracker.ietf.org/doc/html/draft-ietf-uuidrev-rfc4122bis#name-uuid-version-7

**Parameters:**

- `config` (`V7Options?`)

#### `v8`

```dart
String v8({V8Options? config})
```

Generates a draft time-based version 8 UUID

By default it will generate a string based off current Unix epoch time in
milliseconds, and will return a string.

The first argument is a [V8Options] object that takes the same options as
the options map.

https://datatracker.ietf.org/doc/html/draft-ietf-uuidrev-rfc4122bis#name-uuid-version-8

**Parameters:**

- `config` (`V8Options?`)

#### `v8buffer`

```dart
List<int> v8buffer(List<int> buffer, {V8Options? config, int offset})
```

Generates a draft time-based version 8 UUID into a provided buffer

By default it will generate a string based off current Unix epoch time in
milliseconds, and will place the result into the provided [buffer].
The [buffer] will also be returned..

Optionally an [offset] can be provided with a start position in the buffer.

The first optional argument is a [V8Options] object that takes the same options as
the options map.

https://datatracker.ietf.org/doc/html/draft-ietf-uuidrev-rfc4122bis#name-uuid-version-8

**Parameters:**

- `buffer` (`List<int>`) *(required)*
- `config` (`V8Options?`)
- `offset` (`int`)

#### `v8obj`

```dart
UuidValue v8obj({V8Options? config})
```

Generates a draft time-based version 8 UUID as a [UuidValue] object

By default it will generate a string based off current Unix epoch time in
milliseconds, and will return it as a [UuidValue] object.

The first argument is a [V8Options] object that takes the same options as
the options map.

https://datatracker.ietf.org/doc/html/draft-ietf-uuidrev-rfc4122bis#name-uuid-version-8

**Parameters:**

- `config` (`V8Options?`)

#### `v8g`

```dart
String v8g({V8GenericOptions? config})
```

Generates a draft time-based version 8 UUID

Takes in 128 bits (16 bytes) of custom data, and produces a valid V8 uuid.
Bits 48-51 and bits 64-65 will be modified to create a valid uuid.

The first argument is a [V8GenericOptions] object that takes the same options as
the options map.

https://datatracker.ietf.org/doc/html/draft-ietf-uuidrev-rfc4122bis#name-uuid-version-8

**Parameters:**

- `config` (`V8GenericOptions?`)

#### `v8gbuffer`

```dart
List<int> v8gbuffer(List<int> buffer, {V8GenericOptions? config, int offset})
```

Generates a draft time-based version 8 UUID into a provided buffer

Takes in 128 bits (16 bytes) of custom data, and produces a valid V8 uuid.
Bits 48-51 and bits 64-65 will be modified to create a valid uuid.
It will place the result into the provided [buffer].

The [buffer] will also be returned..

Optionally an [offset] can be provided with a start position in the buffer.

The first optional argument is a [V8GenericOptions] object that takes the same options as
the options map.

https://datatracker.ietf.org/doc/html/draft-ietf-uuidrev-rfc4122bis#name-uuid-version-8

**Parameters:**

- `buffer` (`List<int>`) *(required)*
- `config` (`V8GenericOptions?`)
- `offset` (`int`)

#### `v8gobj`

```dart
UuidValue v8gobj({V8GenericOptions? config})
```

Generates a draft time-based version 8 UUID as a [UuidValue] object

Takes in 128 bits (16 bytes) of custom data, and produces a valid V8 uuid.
Bits 48-51 and bits 64-65 will be modified to create a valid uuid.
It will return it as a [UuidValue] object.

The first argument is a [V8GenericOptions] object that takes the same options as
the options map.

https://datatracker.ietf.org/doc/html/draft-ietf-uuidrev-rfc4122bis#name-uuid-version-8

**Parameters:**

- `config` (`V8GenericOptions?`)

---

## class `UuidValue`

### Constructors

#### `UuidValue.fromString`

```dart
UuidValue.fromString(String uuid)
```

fromString() creates a UuidValue from a [String] with no validation.

#### `UuidValue.fromByteList`

```dart
UuidValue.fromByteList(Uint8List byteList, {int? offset})
```

fromByteList() creates a UuidValue from a [Uint8List] of bytes.

#### `UuidValue.fromList`

```dart
UuidValue.fromList(List<int> byteList, {int? offset})
```

fromList() creates a UuidValue from a [List<int>] of bytes.

#### `UuidValue.fromNamespace`

```dart
UuidValue.fromNamespace(Namespace ns)
```

fromNamespace() creates a UuidValue from a [Namespace] enum.

#### `UuidValue.withValidation`

```dart
UuidValue.withValidation(String uuid, [ValidationMode validationMode, bool noDashes])
```

withValidation() creates a UuidValue from a [uuid] string.
Optionally, you can provide a [validationMode] to use when validating
the uuid string.
Throws [FormatException] if the UUID is invalid.

#### `UuidValue.raw`

```dart
UuidValue.raw(String uuid)
```

Creates a UuidValue by taking directly the internal string representation of the [uuid],
which is expected to be lowercase.

You can use [UuidValue.fromString] instead, which will lowercase the uuid string for you or
[UuidValue.withValidation] if you need validation of the created UUIDs.

#### `UuidValue`

```dart
UuidValue(String uuid)
```

Takes in a string representation of a [uuid] to wrap.

### Properties

- **`uuid`** → `String` *(final)*

- **`dns`** → `static UuidValue`

- **`url`** → `static UuidValue`

- **`oid`** → `static UuidValue`

- **`x500`** → `static UuidValue`

- **`nil`** → `static UuidValue`

- **`version`** → `int`

- **`time`** → `int`

- **`isV1`** → `bool`

- **`isV4`** → `bool`

- **`isV5`** → `bool`

- **`isV6`** → `bool`

- **`isV7`** → `bool`

- **`isV8`** → `bool`

- **`isNil`** → `bool`

### Methods

#### `validate`

```dart
void validate([ValidationMode validationMode, bool noDashes])
```

validate() validates the internal string representation of the uuid.
Optionally, you can provide a [validationMode] to use when validating
the uuid string.
Throws [FormatException] if the UUID is invalid.

**Parameters:**

- `validationMode` (`ValidationMode`)
- `noDashes` (`bool`)

#### `toBytes`

```dart
Uint8List toBytes({bool validate})
```

**Parameters:**

- `validate` (`bool`)

#### `toFormattedString`

```dart
String toFormattedString({bool validate})
```

**Parameters:**

- `validate` (`bool`)

#### `equals`

```dart
bool equals(UuidValue other)
```

**Parameters:**

- `other` (`UuidValue`) *(required)*

---

## class `Vector`

Represents a vector of double values.

### Constructors

#### `Vector`

```dart
Vector(List<double> _vec)
```

Creates a new [Vector] from a list of double values.

#### `Vector.fromBinary`

```dart
Vector.fromBinary(Uint8List bytes)
```

Creates a [Vector] from its binary representation.

### Methods

#### `toBinary`

```dart
Uint8List toBinary()
```

Converts the vector to its binary representation.

#### `toList`

```dart
List<double> toList()
```

Returns the vector as a list of double values.

---

## class `WebSocketClosedException`

**Extends:** `MethodStreamException`

Thrown if the WebSocket connection is closed.

### Constructors

#### `WebSocketClosedException`

```dart
WebSocketClosedException()
```

Creates a new [WebSocketClosedException].

---

## class `WebSocketConnectException`

**Extends:** `MethodStreamException`

Thrown if the WebSocket connection fails.

### Constructors

#### `WebSocketConnectException`

```dart
WebSocketConnectException(Object? error, [StackTrace? stackTrace])
```

Creates a new [WebSocketConnectException].

### Properties

- **`error`** → `Object?` *(final)*

  The error that caused the exception.

- **`stackTrace`** → `StackTrace?` *(final)*

  The stack trace of the error.

---

## class `WebSocketListenException`

**Extends:** `MethodStreamException`

Thrown if an error occurs when listening to the WebSocket connection.

### Constructors

#### `WebSocketListenException`

```dart
WebSocketListenException(Object? error, [StackTrace? stackTrace])
```

Creates a new [WebSocketListenException].

### Properties

- **`error`** → `Object?` *(final)*

  The error that caused the exception.

- **`stackTrace`** → `StackTrace?` *(final)*

  The stack trace of the error.

---

## abstract class `WebSocketMessage`

Base class for messages sent over a WebSocket connection.

### Constructors

#### `WebSocketMessage`

```dart
WebSocketMessage()
```

### Methods

#### `static fromJsonString`

```dart
static WebSocketMessage fromJsonString(String jsonString, SerializationManager serializationManager)
```

Converts a JSON string to a [WebSocketMessage] object.

Throws an [UnknownMessageException] if the message is not recognized.

**Parameters:**

- `jsonString` (`String`) *(required)*
- `serializationManager` (`SerializationManager`) *(required)*

---

## abstract class `WebSocketMessageInfo`

Interface of [WebSocketMessage] subclasses that have endpoint,
method and connection id info.

### Constructors

#### `WebSocketMessageInfo`

```dart
WebSocketMessageInfo()
```

### Properties

- **`endpoint`** → `String`

- **`method`** → `String`

- **`connectionId`** → `UuidValue`

---

## enum `CloseReason`

The reason a stream was closed.

### Values

- **`done`**
  The stream was closed because the method was done.
- **`error`**
  The stream was closed because an error occurred.

---

## enum `Namespace`

RFC4122 & RFC9562 provided namespaces for v3, v5, and v8 namespace based UUIDs

### Values

- **`DNS`**
- **`URL`**
- **`OID`**
- **`X500`**
- **`NIL`**
- **`MAX`**
- **`dns`**
- **`url`**
- **`oid`**
- **`x500`**
- **`nil`**
- **`max`**

---

## enum `OpenMethodStreamResponseType`

The response to an [OpenMethodStreamCommand].

### Values

- **`success`**
  The stream was successfully opened.
- **`endpointNotFound`**
  The endpoint was not found.
- **`authenticationFailed`**
  The user is not authenticated.
- **`authorizationDeclined`**
  The user is not authorized.
- **`invalidArguments`**
  The arguments were invalid.

---

## enum `RefreshAuthKeyResult`

Represents the result of an authentication key refresh operation.

### Values

- **`skipped`**
  Refresh was skipped because the key is not expiring.
- **`success`**
  Refresh was successful and a new key was obtained.
- **`failedUnauthorized`**
  Refresh failed due to invalid refresh credentials (such as expired token).
- **`failedOther`**
  Refresh failed due to other reasons (network, server error, etc.).

---

## enum `Status`

### Values

- **`complete`**
- **`inProgress`**
- **`failed`**

---

## enum `StreamingConnectionStatus`

Status of the streaming connection.

### Values

- **`connected`**
  Streaming connection is live.
- **`connecting`**
  Streaming connection is connecting.
- **`disconnected`**
  Streaming connection is disconnected.
- **`waitingToRetry`**
  Streaming connection is waiting to make a new connection attempt.

---

## enum `ValidationMode`

The options for UUID Validation strictness

### Values

- **`nonStrict`**
- **`strictRFC4122`**
- **`strictRFC9562`**

---

## enum `Variant`

### Values

- **`mcp`**
- **`rules`**

---

## `getType`

```dart
Type getType()
```

Get the type provided as an generic. Useful for getting a nullable type.

---

## `isValidAuthHeaderValue`

```dart
bool isValidAuthHeaderValue(String value)
```

Returns true if the provided value is a valid HTTP "authorization" header value
(which includes starting with an authentication scheme name).

**Parameters:**

- `value` (`String`) *(required)*

---

## `isWrappedBasicAuthHeaderValue`

```dart
bool isWrappedBasicAuthHeaderValue(String value)
```

Returns true if the provided value is a Serverpod-wrapped auth key.

**Parameters:**

- `value` (`String`) *(required)*

---

## `isWrappedBearerAuthHeaderValue`

```dart
bool isWrappedBearerAuthHeaderValue(String value)
```

Returns true if the provided value is a Bearer auth header value.

**Parameters:**

- `value` (`String`) *(required)*

---

## `unwrapAuthHeaderValue`

```dart
String? unwrapAuthHeaderValue(String? authValue)
```

Returns the auth key from an auth value that has potentially been wrapped.
This operation is the inverse of [wrapAsBasicAuthHeaderValue] and
[wrapAsBearerAuthHeaderValue]. If null is provided, null is returned.

**Parameters:**

- `authValue` (`String?`) *(required)*

---

## `wrapAsBasicAuthHeaderValue`

```dart
String wrapAsBasicAuthHeaderValue(String key)
```

Returns a value that is compliant with the HTTP auth header format
by encoding and wrapping the provided auth key as a Basic auth value.

**Parameters:**

- `key` (`String`) *(required)*

---

## `wrapAsBearerAuthHeaderValue`

```dart
String wrapAsBearerAuthHeaderValue(String token)
```

Returns a value that is compliant with the HTTP auth header format
by wrapping the provided token as a Bearer auth value.
Unlike Basic auth, Bearer tokens are not Base64 encoded as they are
expected to already be in the correct format.

**Parameters:**

- `token` (`String`) *(required)*

