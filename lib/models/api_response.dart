/// Generic API Response Model
class ApiResponse<T> {
  /// HTTP status code (e.g., 200, 400, 500)
  final int? statusCode;

  /// Response message from the API
  final String? message;

  /// Data returned from the API
  final T? data;

  /// Constructor for API response
  const ApiResponse({
    this.statusCode,
    this.message,
    this.data,
  });

  /// Factory constructor to create an `ApiResponse<T>` from JSON
  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    required T Function(Map<String, dynamic>) parser,
  }) {
    return ApiResponse<T>(
      statusCode: json['statusCode'],
      message: json['message'],
      data: json.containsKey('data') ? parser(json['data']) : null,
    );
  }

  /// Creates a success response
  factory ApiResponse.success(T data, {String? message, int? statusCode}) {
    return ApiResponse(
      data: data,
      message: message ?? 'Success',
      statusCode: statusCode,
    );
  }

  /// Creates an error response
  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse(
      message: message,
      statusCode: statusCode,
    );
  }

  @override
  String toString() {
    return 'ApiResponse(statusCode: $statusCode, message: $message, data: $data)';
  }
}

/// API Response with Header Support
class HeaderApiResponse<T> extends ApiResponse<T> {
  /// Additional header fields (e.g., authentication signature)
  final Map<String, String>? headers;

  /// Constructor for API response with headers
  const HeaderApiResponse({
    required this.headers,
    super.statusCode,
    super.message,
    super.data,
  });

  /// Factory constructor to create `HeaderApiResponse<T>` from JSON
  factory HeaderApiResponse.fromJson(
    Map<String, String> headers,
    Map<String, dynamic> json, {
    required T Function(Map<String, dynamic>) parser,
  }) {
    return HeaderApiResponse<T>(
      headers: headers,
      statusCode: json['statusCode'],
      message: json['message'],
      data: json.containsKey('data') ? parser(json['data']) : null,
    );
  }

  @override
  String toString() {
    return 'HeaderApiResponse(headers: $headers, ${super.toString()})';
  }
}
