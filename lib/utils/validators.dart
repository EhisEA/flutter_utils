import 'app_regex.dart';

/// Utility class for validating user input.
class Validator {
  /// Validates a password.
  /// Returns an error message if the password is invalid, otherwise null.
  static String? password(String? value, {String title = "Password", int limit = 6}) {
    if (value == null || value.isEmpty) {
      return "${title.toUpperCase()} cannot be empty";
    } else if (value.length < limit) {
      return "${title.toUpperCase()} must be at least $limit characters";
    } else if (!AppRegex.hasUpperCase.hasMatch(value)) {
      return "${title.toUpperCase()} must contain an uppercase letter";
    } else if (!AppRegex.hasLowerCase.hasMatch(value)) {
      return "${title.toUpperCase()} must contain a lowercase letter";
    } else if (!AppRegex.hasSpecialChar.hasMatch(value)) {
      return "${title.toUpperCase()} must contain a special character";
    } else if (!AppRegex.hasNumber.hasMatch(value)) {
      return "${title.toUpperCase()} must contain a number";
    }
    return null;
  }

  /// Validates an email address.
  /// Returns an error message if the email is invalid, otherwise null.
  static String? email(String? email) {
    if (email == null || email.isEmpty) {
      return "Email address cannot be empty";
    } else if (!AppRegex.email.hasMatch(email)) {
      return "Invalid email address";
    }
    return null;
  }

  /// Validates a phone number.
  /// Returns an error message if the phone number is invalid, otherwise null.
  static String? phone(String? phone, [String title = "Phone Number"]) {
    if (phone == null || phone.isEmpty) {
      return "$title cannot be empty";
    } else if (!AppRegex.phone.hasMatch(phone)) {
      return "Invalid $title";
    }
    return null;
  }

  /// Validates an OTP code.
  /// Returns an error message if the OTP code is invalid, otherwise null.
  static String? otpCode(String? otp, [String title = "Code"]) {
    if (otp == null || otp.trim().isEmpty) {
      return "$title cannot be empty";
    } else if (!AppRegex.otpCode.hasMatch(otp)) {
      return "Invalid ${title.toLowerCase()}";
    }
    return null;
  }

  /// Validates a name.
  /// Returns an error message if the name is invalid, otherwise null.
  static String? name(String? name, [String title = "Name"]) {
    if (name == null || name.isEmpty) {
      return "$title cannot be empty";
    } else if (name.trim().length < 2) {
      return "Invalid $title";
    }
    return null;
  }

  /// Validates that a field is not empty.
  /// Returns an error message if the field is empty, otherwise null.
  static String? emptyField(String? value, [String title = "Field"]) {
    return (value == null || value.trim().isEmpty) ? '$title is required' : null;
  }

  /// Validates a username.
  /// Returns an error message if the username is invalid, otherwise null.
  static String? username(String? value, {String title = "Username", int limit = 12}) {
    if (value == null || value.trim().isEmpty) {
      return '$title is required';
    } else if (value.length > limit) {
      return '$title cannot be greater than $limit characters';
    }
    return null;
  }

  /// Validates a single name (no spaces).
  /// Returns an error message if the name is invalid, otherwise null.
  static String? singleName(String? name, [String title = "Name"]) {
    if (name == null || name.trim().isEmpty) {
      return "$title cannot be empty";
    }
    return null;
  }

  /// Validates a full name (at least two words).
  /// Returns an error message if the full name is invalid, otherwise null.
  static String? fullname(String? name, {String title = "Full Name", int nameLimit = 4}) {
    if (name == null || name.trim().isEmpty) {
      return "$title cannot be empty";
    }

    final nameList = name.trim().split(RegExp(r'\s+')).where((s) => s.isNotEmpty).toList();
    if (nameList.length < 2 || name.length < nameLimit) {
      return "Invalid $title";
    }
    return null;
  }
}
