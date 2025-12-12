import 'package:intl/intl.dart';

extension StringExtension on String {
  /// Checks if the string is a valid email address.
  bool get isEmail {
    const emailRegExpString =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    return RegExp(emailRegExpString).hasMatch(this);
  }

  /// Checks if the string is a valid web link.
  bool get isLink {
    const linkRegExpString =
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?";
    return RegExp(linkRegExpString).hasMatch(this);
  }

  /// Capitalizes the first letter of the string.
  /// If [lowercaseOther] is true, the rest of the string is converted to lowercase.
  String capitalizeFirstLetter({bool lowercaseOther = true}) {
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${lowercaseOther ? substring(1).toLowerCase() : substring(1)}";
  }

  /// Formats the string as a money value (e.g., "1000.50").
  String toCurrencyFormat() {
    final f = NumberFormat('###.0#', 'en_US');
    return f.format(double.tryParse(this) ?? 0);
  }

  /// Checks if the string represents an image file path/URL.
  bool get isImage {
    if (isEmpty || !contains('.')) return false;
    const extensions = {"png", "jpg", "jpeg", "heic", "gif"};
    return extensions.contains(split(".").last.toLowerCase());
  }

  /// Checks if the string represents a document file path/URL.
  bool get isDocument {
    if (isEmpty || !contains('.')) return false;
    const extensions = {"doc", "docx", "pdf"};
    return extensions.contains(split(".").last.toLowerCase());
  }

  /// Checks if the string represents an audio file path/URL.
  bool get isAudio {
    if (isEmpty || !contains('.')) return false;
    const extensions = {"mp3"};
    return extensions.contains(split(".").last.toLowerCase());
  }

  /// Checks if the string represents a video file path/URL.
  bool get isVideo {
    if (isEmpty || !contains('.')) return false;
    const extensions = {"mp4", "mov"};
    return extensions.contains(split(".").last.toLowerCase());
  }

  /// Extracts initials from a name (e.g., "John Doe" -> "JD").
  String get initials {
    if (isEmpty) return '';
    final values = split(' ');
    final buffer = StringBuffer();
    for (final e in values) {
      if (e.isNotEmpty) {
        buffer.write(e[0]);
      }
    }
    return buffer.toString().toUpperCase();
  }

  /// Returns null if the string is empty; otherwise, returns the string.
  String? get nullIfEmpty => isEmpty ? null : this;

  /// Adds a suffix to the string if it is not empty.
  String? withSuffix(String suffix) =>
      nullIfEmpty == null ? null : '$this$suffix';

  /// Adds a prefix to the string if it is not empty.
  String? withPrefix(String prefix) =>
      nullIfEmpty == null ? null : '$prefix$this';

  /// Converts the string to title case (e.g., "hello world" -> "Hello World").
  String toTitleCase() {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalizeFirstLetter()).join(' ');
  }

  /// Converts the string to a slug (e.g., "Hello World" -> "hello-world").
  String toSlug() {
    return toLowerCase().replaceAll(RegExp(r'[^a-z0-9]+'), '-');
  }

  /// Checks if the string is a valid phone number.
  bool get isPhoneNumber {
    const phoneRegExpString = r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$';
    return RegExp(phoneRegExpString).hasMatch(this);
  }

  /// Checks if the string is a strong password.
  bool get isStrongPassword {
    const passwordRegExpString =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    return RegExp(passwordRegExpString).hasMatch(this);
  }
}
