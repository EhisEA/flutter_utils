import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

/// Represents a file and its associated metadata.
class FileResult {
  /// The path of the file.
  final String path;

  /// The height of the file (if applicable, e.g., image/video).
  final num? height;

  /// The width of the file (if applicable, e.g., image/video).
  final num? width;

  /// The duration of the file in seconds (if applicable, e.g., video/audio).
  final int? duration;

  /// The size of the file in bytes.
  final double? size;

  /// The name of the file.
  final String? fileName;

  /// The base64 or URL of a thumbnail (if applicable).
  final String? thumbnail;

  /// The file data as bytes (used for in-memory operations).
  final Uint8List? data;

  /// Constructs a [FileResult] object with the provided parameters.
  ///
  /// - The [path] parameter is required.
  /// - The [height], [width], [duration], [size], [thumbnail], [fileName], and [data] parameters are optional.
  const FileResult({
    required this.path,
    this.height,
    this.width,
    this.duration,
    this.size,
    this.thumbnail,
    this.fileName,
    this.data,
  });

  /// Returns a `File` object representing the file.
  File get file => File(path);

  /// Gets the size of the file in bytes asynchronously.
  ///
  /// Returns the file size in bytes.
  Future<int> getFileSize() async {
    final file = File(path);
    return await file.length();
  }

  /// Returns a human-readable string of the file size.
  ///
  /// Converts bytes to KB or MB as needed.
  Future<String> sizeInBytes() async {
    final bytes = await getFileSize();
    if (bytes < 1024) return "$bytes B";
    if (bytes < 1024 * 1024) return "${(bytes / 1024).toStringAsFixed(2)} KB";
    return "${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB";
  }

  /// Retrieves the file name from the file path.
  String get pickedFileName => file.uri.pathSegments.last;

  /// Returns the aspect ratio of the file if applicable.
  ///
  /// If the file has valid `width` and `height`, it returns `width / height`.
  /// Otherwise, returns `null`.
  double? get aspectRatio {
    if (width == null || height == null || height == 0) return null;
    return width! / height!;
  }

  /// Resizes the file dimensions to fit within a maximum width while maintaining aspect ratio.
  ///
  /// If dimensions are invalid, returns `Size.zero`.
  Size fitToWidth(double maxDimension) {
    if (width == null || height == null || width! <= 0 || height! <= 0 || maxDimension <= 0) {
      return Size.zero;
    }
    final aspectRatio = width! / height!;
    final newWidth = maxDimension;
    final newHeight = maxDimension / aspectRatio;
    return Size(newWidth, newHeight);
  }

  /// Creates a copy of the `FileResult` with modified properties.
  ///
  /// Allows partial modification while keeping other values unchanged.
  FileResult copyWith({
    String? path,
    num? height,
    num? width,
    int? duration,
    double? size,
    String? thumbnail,
    String? fileName,
  }) {
    return FileResult(
      path: path ?? this.path,
      height: height ?? this.height,
      width: width ?? this.width,
      duration: duration ?? this.duration,
      size: size ?? this.size,
      thumbnail: thumbnail ?? this.thumbnail,
      fileName: fileName ?? this.fileName,
    );
  }
}
