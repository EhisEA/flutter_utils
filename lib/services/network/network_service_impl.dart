import 'package:dio/dio.dart';

import '../../models/models.dart';
import '../../utils/utils.dart';
import 'network_interceptor.dart';

part 'network_service.dart';

/// Implementation of the [NetworkService] that handles HTTP requests using Dio.
///
/// This class includes authentication, token refresh logic, request handling,
/// and support for form-data requests.
class NetworkServiceImpl implements NetworkService {
  final _logger = const AppLogger(NetworkServiceImpl);

  /// Constructs a [NetworkServiceImpl] instance with a list of [interceptors].
  NetworkServiceImpl(this.interceptors) {
    _dio = Dio(
      BaseOptions(
        headers: {
          'Authorization': accessToken == null ? null : 'Bearer $accessToken',
        },
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
  Future<ApiResponse> get(
    String path, {
    Map<String, dynamic>? queryParams,
  }) async {
    try {
      final res = await _dio.get(path, queryParameters: queryParams);
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a POST request to the specified [path] with optional [data].
  @override
  Future<ApiResponse> post(
    String path, {
    Object? data,
  }) async {
    try {
      final res = await _dio.post(path, data: data);
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
  Future<ApiResponse> postFormData(
    String path, {
    Object? data,
    Map<String, dynamic>? file,
  }) async {
    try {
      final res = await _dio.post(
        path,
        data: _generateFormData(data, file),
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
  Future<ApiResponse> patchFormData(
    String path, {
    Object? data,
    Map<String, dynamic>? file,
  }) async {
    try {
      final res = await _dio.patch(
        path,
        data: _generateFormData(data, file),
      );
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a PATCH request to the specified [path] with optional [data].
  @override
  Future<ApiResponse> patch(String path, {Object? data}) async {
    try {
      final res = await _dio.patch(path, data: data);
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a PUT request to the specified [path] with optional [data].
  @override
  Future<ApiResponse> put(String path, {Object? data}) async {
    try {
      final res = await _dio.put(path, data: data);
      return _handleResponse(res);
    } on DioException catch (e) {
      return await _handleError(e);
    }
  }

  /// Sends a DELETE request to the specified [path] with optional [data].
  @override
  Future<ApiResponse> delete(String path, {Object? data}) async {
    try {
      final res = await _dio.delete(path, data: data);
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
      final dio = Dio()..interceptors.add(NetworkInterceptor());
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
  ApiResponse _handleResponse(Response res) {
    return HeaderApiResponse(
      headers: res.headers.map,
      statusCode: res.statusCode,
      data: res.data,
    );
  }

  /// Handles errors from HTTP requests, logs them, and throws an [ApiFailure].
  Future<ApiResponse> _handleError(DioException error) async {
    _logger.e(error.message ?? 'Something went wrong!', functionName: "_handleError");

    if (error.response?.statusCode == 401 || error.response?.statusCode == 403) {
      throw ApiFailure(
        error.message ?? 'Authentication error, please login',
        statusCode: error.response?.statusCode,
        data: error.response?.data,
      );
    } else {
      throw ApiFailure(
        error.message ?? 'Something went wrong!',
        statusCode: error.response?.statusCode,
        data: error.response?.data,
      );
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
          map[value.key] = (value.value as List).map((e) => MultipartFile.fromFileSync(e)).toList();
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
