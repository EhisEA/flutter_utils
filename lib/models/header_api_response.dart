import 'api_response.dart';

/// API Response with Header Support
class HeaderApiResponse<T> extends ApiResponse<T> {
  /// Additional header fields (e.g., authentication signature)
  final Map<String, dynamic>? headers;

  /// Constructor for API response with headers
  const HeaderApiResponse({
    required this.headers,
    super.statusCode,
    super.data,
  });

  /// Factory constructor to create `HeaderApiResponse<T>` from JSON
  factory HeaderApiResponse.fromJson(
    Map<String, dynamic> headers,
    Map<String, dynamic> json, {
    required T Function(Map<String, dynamic>) parser,
  }) {
    return HeaderApiResponse<T>(
      headers: headers,
      statusCode: json['statusCode'],
      data: json.containsKey('data') ? parser(json['data']) : null,
    );
  }

  @override
  String toString() {
    return 'HeaderApiResponse(headers: $headers, ${super.toString()})';
  }
}
