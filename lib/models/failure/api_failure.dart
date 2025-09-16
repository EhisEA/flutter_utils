import 'package:flutter_utils/models/failure/failure.dart';

class ApiFailure extends Failure {
  ApiFailure(super.message, {this.data, this.statusCode, this.event});

  final int? statusCode;
  final dynamic data;
  final dynamic event;

  factory ApiFailure.fromHttpErrorMap(Map<String, dynamic> error) {
    // checking the error format
    // so i can apporpriately get the error message
    // Note: input errors are different from normal error
    late String errorMessage;
    //input error test
    if (error.containsKey("errors")) {
      //get the first error model in the list then
      //the msg of the error
      errorMessage = error["errors"][0]["msg"];
    }
    // normal error test
    else if (error.containsKey("message")) {
      errorMessage = error["message"];
    } //default
    else if (error.containsKey("error")) {
      errorMessage = error["error"]["message"];
    } //default
    else {
      errorMessage = "Error";
    }

    return ApiFailure(errorMessage, event: error['event']);
  }

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
