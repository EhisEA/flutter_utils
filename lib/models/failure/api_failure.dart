import 'package:flutter_utils/models/failure/failure.dart';

class ApiFailure extends Failure {
  ApiFailure(super.message,
      {this.data, this.headers, this.statusCode, this.event});

  final int? statusCode;
  final dynamic data;
  final dynamic headers;
  final dynamic event;

  factory ApiFailure.fromHttpErrorMap(
      Map<String, dynamic> error, dynamic headers) {
    // Checking the error format to appropriately get the error message.
    // Note: input errors are different from normal error.
    late String errorMessage;

    // Input error test - check for errors array
    if (error.containsKey("errors") && error["errors"] is List) {
      final errors = error["errors"] as List;
      if (errors.isNotEmpty && errors[0] is Map) {
        final firstError = errors[0] as Map;
        errorMessage = firstError["msg"]?.toString() ??
            firstError["message"]?.toString() ??
            "Error";
      } else {
        errorMessage = "Error";
      }
    }
    // Normal error test - check for direct message
    else if (error.containsKey("message") && error["message"] is String) {
      errorMessage = error["message"] as String;
    }
    // Check for nested error object
    else if (error.containsKey("error") && error["error"] is Map) {
      final errorObj = error["error"] as Map;
      errorMessage = errorObj["message"]?.toString() ?? "Error";
    }
    // Default fallback
    else {
      errorMessage = "Error";
    }

    return ApiFailure(errorMessage, event: error['event'], headers: headers);
  }

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ApiFailure &&
        other.message == message &&
        other.data == data &&
        other.headers == headers;
  }

  @override
  int get hashCode => Object.hash(message, data, headers);
}
