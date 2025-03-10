class ApiFailure implements Exception {
  ApiFailure({required this.message, this.data, this.statusCode});

  final String message;
  final int? statusCode;
  final dynamic data;

  factory ApiFailure.fromHttpErrorMap(Map<String, dynamic> json) => ApiFailure(
    message: json['error']?['message'] ?? 'Unknown error',
  );

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ApiFailure &&
        other.message == message &&
        other.data == data;
  }

  @override
  int get hashCode => Object.hash(message, data);
}
