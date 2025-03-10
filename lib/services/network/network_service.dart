part of 'network_service_impl.dart';

/// An abstract class that defines the contract for network operations.
///
/// This class provides a unified interface for performing HTTP requests
/// (GET, POST, PATCH, PUT, DELETE) and handling authentication-related
/// operations like token refresh.
abstract class NetworkService {
  /// The Dio instance used for making HTTP requests.
  Dio get dio;

  /// Sends a GET request to the specified [path].
  ///
  /// - [queryParams]: Optional query parameters for the request.
  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParams,
  });

  /// Sends a POST request to the specified [path] with optional [data].
  Future<ApiResponse> post(
    String path, {
    Object? data,
  });

  /// Sends a POST request with form data, allowing file uploads.
  ///
  /// - [data]: Additional form fields to be sent.
  /// - [file]: A map of files where the key represents the field name and
  ///   the value is the file content.
  Future<ApiResponse> postFormData(
    String path, {
    Object? data,
    Map<String, dynamic>? file,
  });

  /// Sends a PATCH request with form data, allowing file uploads.
  ///
  /// - [data]: Additional form fields to be sent.
  /// - [file]: A map of files where the key represents the field name and
  ///   the value is the file content.
  Future<ApiResponse> patchFormData(
    String path, {
    Object? data,
    Map<String, dynamic>? file,
  });

  /// Sends a PATCH request to the specified [path] with optional [data].
  Future<ApiResponse> patch(String path, {Object? data});

  /// Sends a PUT request to the specified [path] with optional [data].
  Future<ApiResponse> put(String path, {Object? data});

  /// Sends a DELETE request to the specified [path] with optional [data].
  Future<ApiResponse> delete(String path, {Object? data});

  /// Attempts to refresh the access token when authentication fails.
  ///
  /// If successful, returns the new access token, otherwise returns `null`.
  Future<String?> refreshTokenForNewToken();

  /// The current access token used for authentication.
  abstract String? accessToken;

  /// The refresh token used to obtain a new access token.
  abstract String? refreshToken;

  /// The API endpoint used for refreshing the access token.
  abstract String? refreshTokenRoute;
}
