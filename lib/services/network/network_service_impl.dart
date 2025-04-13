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

  /// Sends a GET request to the specified [path] with optional [queryParams].
  @override
  Future<HeaderApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final res = await _dio.get(
        path,
        queryParameters: queryParams,
        options: Options(
          headers: {
            'Authorization': accessToken == null ? null : 'Bearer $accessToken',
          },
        ),
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
    Object? data,
  }) async {
    try {
      final res = await _dio.post(
        path,
        data: data,
        options: Options(
          headers: {
            'Authorization': accessToken == null ? null : 'Bearer $accessToken',
          },
        ),
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
    Object? data,
    Map<String, dynamic>? file,
  }) async {
    try {
      final res = await _dio.post(
        path,
        data: _generateFormData(data, file),
        options: Options(
          headers: {
            'Authorization': accessToken == null ? null : 'Bearer $accessToken',
          },
        ),
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
    Object? data,
    Map<String, dynamic>? file,
  }) async {
    try {
      final res = await _dio.patch(
        path,
        data: _generateFormData(data, file),
        options: Options(
          headers: {
            'Authorization': accessToken == null ? null : 'Bearer $accessToken',
          },
        ),
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
  Future<HeaderApiResponse> putFormData(
    String path, {
    Object? data,
    Map<String, dynamic>? file,
  }) async {
    try {
      final res = await _dio.patch(
        path,
        data: _generateFormData(data, file),
        options: Options(
          headers: {
            'Authorization': accessToken == null ? null : 'Bearer $accessToken',
          },
        ),
      );
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a PATCH request to the specified [path] with optional [data].
  @override
  Future<HeaderApiResponse> patch(String path, {Object? data}) async {
    try {
      final res = await _dio.patch(
        path,
        data: data,
        options: Options(
          headers: {
            'Authorization': accessToken == null ? null : 'Bearer $accessToken',
          },
        ),
      );
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a PUT request to the specified [path] with optional [data].
  @override
  Future<HeaderApiResponse> put(String path, {Object? data}) async {
    try {
      final res = await _dio.put(
        path,
        data: data,
        options: Options(
          headers: {
            'Authorization': accessToken == null ? null : 'Bearer $accessToken',
          },
        ),
      );
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a DELETE request to the specified [path] with optional [data].
  @override
  Future<HeaderApiResponse> delete(String path, {Object? data}) async {
    try {
      final res = await _dio.delete(
        path,
        data: data,
        options: Options(
          headers: {
            'Authorization': accessToken == null ? null : 'Bearer $accessToken',
          },
        ),
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
        final newAccessToken = response.data['access_token'];
        accessToken = newAccessToken; // Update access token
        return newAccessToken;
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

    if (statusCode == 401 || statusCode == 403) {
      throw ApiFailure(
        errorMessage == 'Something went wrong!'
            ? 'Authentication error, please login'
            : errorMessage,
        statusCode: statusCode,
        data: responseData,
      );
    }

    throw ApiFailure(
      errorMessage,
      statusCode: statusCode,
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
            final firstValue = firstError.values.first;
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
      for (var value in file.entries) {
        if (value.value is List) {
          map[value.key] = (value.value as List)
              .map((e) => MultipartFile.fromFileSync(e))
              .toList();
        } else {
          map[value.key] = MultipartFile.fromFileSync(value.value);
        }
      }
    }

    FormData formData = FormData.fromMap(map);
    if (data != null) {
      formData.fields.addAll((data as Map<String, String>).entries);
    }

    return formData;
  }
}
