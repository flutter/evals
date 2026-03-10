/// Client for uploading files to Google Cloud Storage.
///
/// Uses the `gcloud` package for storage operations and `googleapis_auth`
/// for service account authentication.
library;

import 'dart:io';

import 'package:gcloud/storage.dart';
import 'package:googleapis_auth/auth_io.dart' as auth;
import 'package:http/http.dart' as http;

/// A client for interacting with Google Cloud Storage.
///
/// Handles authentication via service account credentials and provides
/// methods for uploading files to a GCS bucket.
class GcsClient {
  final Storage _storage;
  final http.Client _httpClient;

  GcsClient._(this._storage, this._httpClient);

  /// Creates a [GcsClient] authenticated with a service account.
  ///
  /// [projectId] is the Google Cloud project ID.
  /// [credentialsPath] is the path to the service account JSON key file.
  static Future<GcsClient> create({
    required String projectId,
    required String credentialsPath,
  }) async {
    final file = File(credentialsPath);
    if (!file.existsSync()) {
      throw FileSystemException(
        'Service account credentials file not found',
        credentialsPath,
      );
    }

    final jsonString = file.readAsStringSync();
    final credentials = auth.ServiceAccountCredentials.fromJson(jsonString);
    final scopes = [
      ...Storage.SCOPES,
    ];

    final httpClient = await auth.clientViaServiceAccount(credentials, scopes);
    final storage = Storage(httpClient, projectId);

    return GcsClient._(storage, httpClient);
  }

  /// Uploads a file to the specified [bucketName] at [objectName].
  ///
  /// The [objectName] is the full path within the bucket,
  /// e.g. `2026-01-07_17-11-47/some-log.json`.
  Future<ObjectInfo> uploadFile(
    String bucketName,
    String objectName,
    File file,
  ) async {
    final bucket = _storage.bucket(bucketName);
    final bytes = await file.readAsBytes();
    return bucket.writeBytes(objectName, bytes);
  }

  /// Releases the underlying HTTP client resources.
  void close() {
    _httpClient.close();
  }
}
