import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../../utils/utils.dart';

class LoggingInterceptor extends QueuedInterceptor {
  LoggingInterceptor();

  final _logger = const AppLogger(LoggingInterceptor);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    _logRequest(options);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    _logResponse(response);
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    _logError(err);
    err = err.copyWith(message: _handleError(err));
    super.onError(err, handler);
  }

  /// Logs HTTP requests
  void _logRequest(RequestOptions options) {
    if (!kDebugMode) return;

    _logger.custom('<== REQUEST ==>',
        color: LoggerColor.black, functionName: "onRequest");
    _logger.custom(
      'REQUEST [${options.method}] ==> ${options.uri}',
      color: LoggerColor.black,
      functionName: "onRequest",
    );
    _logger.custom('Headers --> ${options.headers}',
        color: LoggerColor.black, functionName: "onRequest");
    _logger.custom('Params --> ${options.queryParameters}',
        color: LoggerColor.black, functionName: "onRequest");
    _logger.custom('Content Type --> ${options.contentType}',
        color: LoggerColor.black, functionName: "onRequest");

    if (options.data is FormData) {
      final formData = options.data as FormData;
      _logger.custom('Data Fields --> ${formData.fields}',
          color: LoggerColor.black, functionName: "onRequest");
      _logger.custom('File Attachments --> ${formData.files.length} files',
          color: LoggerColor.black, functionName: "onRequest");
    } else {
      _logger.custom('Data --> ${options.data}',
          color: LoggerColor.black, functionName: "onRequest");
    }
  }

  /// Logs HTTP responses
  void _logResponse(Response response) {
    if (!kDebugMode) return;

    _logger.custom('==> <== RESPONSE ==>',
        color: LoggerColor.black, functionName: "onResponse");
    _logger.custom(
      'RESPONSE [${response.statusCode}] => PATH: ${response.requestOptions.uri}',
      color: LoggerColor.black,
      functionName: "onResponse",
    );
    _logger.custom('Response Data => ${response.data}',
        color: LoggerColor.black, functionName: "onResponse");
  }

  /// Logs HTTP errors
  void _logError(DioException err) {
    if (!kDebugMode) return;

    _logger.e('<== ERROR ==>', functionName: "onError");
    _logger.e(
      'ERROR [${err.response?.statusCode}] => PATH: ${err.requestOptions.uri}',
      functionName: "onError",
    );
    _logger.e('Message --> ${err.message}', functionName: "onError");
    _logger.e('Error Data --> ${err.response?.data}', functionName: "onError");
  }

  /// Handles and formats error messages
  String _handleError(DioException dioError) {
    switch (dioError.type) {
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionTimeout:
        return "Connection timeout. Please try again.";
      case DioExceptionType.sendTimeout:
        return "Request took too long to send.";
      case DioExceptionType.receiveTimeout:
        return "Response took too long to receive.";
      case DioExceptionType.badCertificate:
        return "Invalid SSL certificate.";
      case DioExceptionType.badResponse:
        return dioError.response?.data?['message'] ??
            "Unexpected server response.";
      case DioExceptionType.connectionError:
        return "No internet connection or server is unreachable.";
      case DioExceptionType.unknown:
        return "An unknown error occurred.";
    }
  }
}
