import 'package:flutter/foundation.dart';
import 'file_result.dart'; // Ensure this file contains the FileResult model

/// A controller that manages file selection and notifies listeners on changes.
class FilePickerController extends ValueNotifier<FileResult?> {
  /// Creates a [FilePickerController] initialized with no selected file.
  FilePickerController({this.fileName}) : super(null);

  /// Optional file name override.
  final String? fileName;

  /// Stores the formatted file size (e.g., "1.5 MB").
  String? _sizeInBytes;

  /// Getter for the formatted file size.
  String? get sizeInBytes => _sizeInBytes;

  /// Returns the currently selected file.
  FileResult? get file => value;

  /// Sets a new file and updates its size asynchronously.
  set file(FileResult? newFile) {
    if (newFile == null) {
      _clearState();
      return;
    }

    // Apply fileName override if provided
    final updatedFile = fileName != null ? newFile.copyWith(fileName: fileName) : newFile;

    // Set the new file
    value = updatedFile;

    // Fetch and update file size asynchronously
    _updateFileSize(updatedFile);
  }

  /// Clears the selected file and resets the size.
  void clearFile() => _clearState();

  /// Manually refreshes the UI without changing the file.
  void refresh() => notifyListeners();

  /// Resets the file and size, ensuring a consistent state.
  void _clearState() {
    value = null;
    _sizeInBytes = null;
    notifyListeners();
  }

  /// Updates the file size asynchronously.
  Future<void> _updateFileSize(FileResult file) async {
    final size = await file.sizeInBytes();
    if (value == file) {
      // Ensures this update corresponds to the latest file selection
      _sizeInBytes = size;
      notifyListeners();
    }
  }
}
