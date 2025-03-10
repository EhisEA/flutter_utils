class AppRegex {
  /// Email validation regex.
  /// Supports:
  /// - Standard email formats (e.g., user@domain.com)
  /// - Subdomains (e.g., user@sub.domain.com)
  /// - Special characters in the local part (e.g., user+alias@domain.com)
  static final RegExp email = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$",
  );

  /// Phone number validation regex.
  /// Supports 10-11 digits (adjust as needed for specific countries).
  static final RegExp phone = RegExp(r'^\d{10,11}$');

  /// Password validation regex patterns.
  static final RegExp hasUpperCase = RegExp(r'[A-Z]'); // At least one uppercase letter
  static final RegExp hasLowerCase = RegExp(r'[a-z]'); // At least one lowercase letter
  static final RegExp hasNumber = RegExp(r'[0-9]'); // At least one digit
  static final RegExp hasSpecialChar =
      RegExp(r'[!@#$%^&*(),.?":{}|<>]'); // At least one special character

  /// OTP code validation regex (6 digits).
  static final RegExp otpCode = RegExp(r'^\d{6}$');

  /// Name validation regex (allows letters, spaces, and common name characters).
  static final RegExp name = RegExp(r"^[a-zA-Z]+(?: [a-zA-Z]+)*$");

  /// Splits a name on whitespace.
  static final RegExp nameWhitespace = RegExp(r'\s+');

  /// Validates a password against all complexity rules.
  /// Returns `true` if the password meets all requirements.
  static bool validatePassword(String password) {
    return password.length >= 8 &&
        hasUpperCase.hasMatch(password) &&
        hasLowerCase.hasMatch(password) &&
        hasNumber.hasMatch(password) &&
        hasSpecialChar.hasMatch(password);
  }
}
