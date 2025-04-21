/// Generic API Response Model
class ApiResponse<T> {
  /// HTTP status code (e.g., 200, 400, 500)
  final int? statusCode;

  /// Data returned from the API
  final T? data;

  final bool hasNextPage;

  /// Constructor for API response
  const ApiResponse({
    this.statusCode,
    this.data,
    this.hasNextPage = false,
  });

  /// Factory constructor to create an `ApiResponse<T>` from JSON
  factory ApiResponse.fromJson(
    Map<String, dynamic> json, {
    required T Function(Map<String, dynamic>) parser,
  }) {
    return ApiResponse<T>(
      statusCode: json['statusCode'],
      data: json.containsKey('data') ? parser(json['data']) : null,
    );
  }

  /// Creates a success response
  factory ApiResponse.success(T data, {String? message, int? statusCode}) {
    return ApiResponse(
      data: data,
      statusCode: statusCode,
    );
  }

  /// Creates an error response
  factory ApiResponse.error(String message, {int? statusCode}) {
    return ApiResponse(
      statusCode: statusCode,
    );
  }

  @override
  String toString() {
    return 'ApiResponse(statusCode: $statusCode, data: $data)';
  }
}
