import 'package:dio/dio.dart';

import '../../models/models.dart';
import '../../utils/utils.dart';
import 'logging_interceptor.dart';

part 'network_service.dart';

/// Implementation of the [NetworkService] that handles HTTP requests using Dio.
///
/// This class includes authentication, token refresh logic, request handling,
/// and support for form-data requests.
class NetworkServiceImpl implements NetworkService {
  final _logger = const AppLogger(NetworkServiceImpl);

  /// Constructs a [NetworkServiceImpl] instance with a list of [interceptors].
  NetworkServiceImpl({this.interceptors = const []}) {
    _dio = Dio(
      BaseOptions(
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    )..interceptors.addAll(interceptors); // Custom interceptors
  }

  @override
  Dio get dio => _dio;

  /// List of custom interceptors added to Dio.
  final List<Interceptor> interceptors;

  @override
  String? accessToken;

  @override
  String? refreshToken;

  @override
  String? refreshTokenRoute;

  late final Dio _dio;

  /// Builds request options with authorization header and custom headers.
  Options _buildRequestOptions({
    Map<String, dynamic>? headers,
  }) {
    return Options(
      headers: {
        if (accessToken != null) 'Authorization': 'Bearer $accessToken',
        ...headers ?? {},
      },
    );
  }

  /// Sends a GET request to the specified [path] with optional [queryParams].
  @override
  Future<HeaderApiResponse> get(
    String path, {
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final res = await _dio.get(
        path,
        queryParameters: queryParams,
        cancelToken: cancelToken,
        options: _buildRequestOptions(headers: headers),
      );
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a POST request to the specified [path] with optional [data].
  @override
  Future<HeaderApiResponse> post(
    String path, {
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Object? data,
  }) async {
    try {
      final res = await _dio.post(
        path,
        data: data,
        cancelToken: cancelToken,
        options: _buildRequestOptions(headers: headers),
      );
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a POST request with form data, allowing file uploads.
  ///
  /// - [data]: Additional form fields to be sent.
  /// - [file]: A map of files where the key represents the field name and
  ///   the value is the file content.
  @override
  Future<HeaderApiResponse> postFormData(
    String path, {
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Object? data,
    Map<String, dynamic>? file,
  }) async {
    try {
      final res = await _dio.post(
        path,
        cancelToken: cancelToken,
        data: _generateFormData(data, file),
        options: _buildRequestOptions(headers: headers),
      );
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a PATCH request with form data, allowing file uploads.
  ///
  /// - [data]: Additional form fields to be sent.
  /// - [file]: A map of files where the key represents the field name and
  ///   the value is the file content.
  @override
  Future<HeaderApiResponse> patchFormData(
    String path, {
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Object? data,
    Map<String, dynamic>? file,
  }) async {
    try {
      final res = await _dio.patch(
        path,
        cancelToken: cancelToken,
        data: _generateFormData(data, file),
        options: _buildRequestOptions(headers: headers),
      );
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a PUT request with form data, allowing file uploads.
  ///
  /// - [data]: Additional form fields to be sent.
  /// - [file]: A map of files where the key represents the field name and
  ///   the value is the file content.
  @override
  Future<HeaderApiResponse> putFormData(
    String path, {
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
    Object? data,
    Map<String, dynamic>? file,
  }) async {
    try {
      final res = await _dio.put(
        path,
        cancelToken: cancelToken,
        data: _generateFormData(data, file),
        options: _buildRequestOptions(headers: headers),
      );
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a PATCH request to the specified [path] with optional [data].
  @override
  Future<HeaderApiResponse> patch(
    String path, {
    Object? data,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final res = await _dio.patch(
        path,
        data: data,
        cancelToken: cancelToken,
        options: _buildRequestOptions(headers: headers),
      );
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a PUT request to the specified [path] with optional [data].
  @override
  Future<HeaderApiResponse> put(
    String path, {
    Object? data,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final res = await _dio.put(
        path,
        data: data,
        cancelToken: cancelToken,
        options: _buildRequestOptions(headers: headers),
      );
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a DELETE request to the specified [path] with optional [data].
  @override
  Future<HeaderApiResponse> delete(
    String path, {
    Object? data,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final res = await _dio.delete(
        path,
        data: data,
        cancelToken: cancelToken,
        options: _buildRequestOptions(headers: headers),
      );
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Attempts to refresh the authentication token when it expires.
  ///
  /// If successful, updates [accessToken] and returns the new token.
  /// Otherwise, returns `null`, indicating a failed refresh.
  @override
  Future<String?> refreshTokenForNewToken() async {
    if (refreshToken == null || refreshTokenRoute == null) return null;

    try {
      final dio = Dio()..interceptors.add(LoggingInterceptor());
      final response = await dio.post(
        refreshTokenRoute!,
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        if (responseData is Map<String, dynamic>) {
          final newAccessToken = responseData['access_token'] as String?;
          if (newAccessToken != null && newAccessToken.isNotEmpty) {
            accessToken = newAccessToken;
            return newAccessToken;
          }
        }
        _logger.e('Invalid token refresh response format');
      }
    } catch (e) {
      _logger.e('Failed to refresh token: $e');
    }

    return null; // If refresh fails, force re-login
  }

  /// Handles successful HTTP responses and wraps them in an [ApiResponse] object.
  HeaderApiResponse _handleResponse(Response res) {
    return HeaderApiResponse(
      headers: res.headers.map,
      statusCode: res.statusCode,
      data: res.data,
    );
  }

  /// Handles errors from HTTP requests, logs them, and throws an [ApiFailure].
  Future<HeaderApiResponse> _handleError(DioException error) async {
    final responseData = error.response?.data;
    final responseEvent = error.response?.data?['event'];
    final statusCode = error.response?.statusCode;

    String errorMessage = 'Something went wrong!';

    try {
      // Try to extract error message from response
      errorMessage = _extractErrorMessage(responseData) ?? errorMessage;
    } catch (e) {
      _logger.e('Error parsing error response: $e',
          functionName: "_handleError");
    }

    _logger.e(errorMessage, functionName: "_handleError");
    _logger.e(error.response?.headers.map, functionName: "error headers");
    _logger.e(error.response?.headers, functionName: "error headers 2");
    _logger.e(error.response, functionName: "error response");

    // Handle network connectivity issues
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.sendTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      throw ApiFailure(
        'Connection timeout. Please check your internet connection.',
        statusCode: statusCode,
        data: responseData,
      );
    }

    if (error.type == DioExceptionType.connectionError) {
      throw ApiFailure(
        'No internet connection. Please check your network settings.',
        statusCode: statusCode,
        data: responseData,
      );
    }

    if (statusCode == 401 || statusCode == 403) {
      throw ApiFailure(
        errorMessage == 'Something went wrong!'
            ? 'Authentication error, please login'
            : errorMessage,
        headers: error.response?.headers.map,
        statusCode: statusCode,
        event: responseEvent,
        data: responseData,
      );
    }

    if (error.type == DioExceptionType.cancel) {
      throw ApiCancelFailure("Api request cancelled");
    }

    throw ApiFailure(
      errorMessage,
      headers: error.response?.headers.map,
      statusCode: statusCode,
      event: responseEvent,
      data: responseData,
    );
  }

  /// Extracts error message from API response data
  String? _extractErrorMessage(dynamic responseData) {
    if (responseData == null) return null;

    try {
      // Case 2: Check errors array/object
      final errors = responseData['errors'];
      if (errors != null) {
        if (errors is List && errors.isNotEmpty) {
          final firstError = errors.first;
          if (firstError is Map && firstError.isNotEmpty) {
            final firstValue = firstError['message'] ?? firstError.values.first;
            if (firstValue is List && firstValue.isNotEmpty) {
              return firstValue.first.toString();
            }
            return firstValue.toString();
          }
          return firstError.toString();
        }

        if (errors is Map && errors.isNotEmpty) {
          final firstError = errors.values.first;
          if (firstError is List && firstError.isNotEmpty) {
            return firstError.first.toString();
          }
          return firstError.toString();
        }
      }
      // Case 1: Check for direct message
      if (responseData['message'] is String) {
        return responseData['message'];
      }

      // Case 3: Fallback to string representation
      return 'Something went wrong!';
    } catch (e) {
      return null;
    }
  }

  /// Generates a [FormData] object for sending multipart form data (file uploads).
  ///
  /// - [data]: Additional form fields.
  /// - [file]: A map of file paths where keys are field names.
  FormData _generateFormData(
    Object? data,
    Map<String, dynamic>? file,
  ) {
    Map<String, dynamic> map = <String, dynamic>{};

    if (file != null) {
      for (var entry in file.entries) {
        if (entry.value is List) {
          map[entry.key] = (entry.value as List)
              .map((e) => MultipartFile.fromFileSync(e.toString()))
              .toList();
        } else {
          map[entry.key] = MultipartFile.fromFileSync(entry.value.toString());
        }
      }
    }

    FormData formData = FormData.fromMap(map);
    if (data != null) {
      if (data is Map<String, dynamic>) {
        formData.fields.addAll(
          data.entries.map((e) => MapEntry(e.key, e.value.toString())),
        );
      } else if (data is Map) {
        // Handle other Map types
        formData.fields.addAll(
          data.entries
              .map((e) => MapEntry(e.key.toString(), e.value.toString())),
        );
      }
    }

    return formData;
  }
}
