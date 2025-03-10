import 'package:dio/dio.dart';
import 'package:flutter_utils/utils/app_logger.dart';

import 'network_service_impl.dart';

/// An interceptor that automatically attaches authentication tokens to requests
/// and handles token refresh when authentication failures occur.
class AuthInterceptor extends Interceptor {
  /// Reference to the network service that manages authentication tokens.
  final NetworkService _networkService;

  /// Logger instance for debugging network activity.
  final _logger = const AppLogger(AuthInterceptor);

  /// List of status codes that indicate an authentication failure,
  /// prompting a token refresh attempt.
  final List<int> authFailureStatusCodes;

  /// Creates an instance of [AuthInterceptor] with a given [NetworkService].
  AuthInterceptor(this._networkService, {this.authFailureStatusCodes = const [401, 403]});

  /// Modifies the request to include the Authorization header if an access token is available.
  ///
  /// - If [_networkService.accessToken] is not null, the request header is updated with the Bearer token.
  /// - Passes the modified request to the next handler.
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (_networkService.accessToken != null) {
      options.headers['Authorization'] = 'Bearer ${_networkService.accessToken}';
    }
    super.onRequest(options, handler);
  }

  /// Handles API errors and attempts to refresh the token if necessary.
  ///
  /// - If the error response status code is in [authFailureStatusCodes] (e.g., 401 or 403),
  ///   it tries to refresh the token using [_networkService.refreshTokenForNewToken].
  /// - If the token is refreshed successfully, the original request is retried with the new token.
  /// - If the token refresh fails, the error is logged, and the request proceeds with the original failure.
  ///
  /// Logs messages in **red** if token refresh fails for better visibility.
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode != null &&
        authFailureStatusCodes.contains(err.response!.statusCode)) {
      _logger.w('<== Token expired. Attempting refresh... ==>', functionName: "onError");

      try {
        // Attempt to refresh the access token
        final newToken = await _networkService.refreshTokenForNewToken();

        if (newToken != null) {
          _logger.w('<== Token refreshed successfully ==>', functionName: "onError");

          // Retry the failed request with the new token
          err.requestOptions.headers['Authorization'] = 'Bearer $newToken';

          final response = await _networkService.dio.fetch(err.requestOptions);
          return handler.resolve(response);
        }
      } on DioException catch (e) {
        _logger.custom('<== Token refresh failed: ${e.message} ==>',
            color: LoggerColor.red, functionName: "onError");
        return super.onError(e, handler);
      } catch (e) {
        _logger.custom('<== Unexpected error during token refresh: $e ==>',
            color: LoggerColor.red, functionName: "onError");
      }

      _logger.custom('<== Token refresh failed. Request cannot proceed. ==>',
          color: LoggerColor.red, functionName: "onError");
    }

    return super.onError(err, handler);
  }
}
