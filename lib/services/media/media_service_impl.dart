import 'dart:io';
import 'dart:ui' as ui;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../models/models.dart';
import '../../utils/utils.dart';
import 'media_service.dart';

/// Implementation of [MediaService] for handling file, image, and media operations.
class MediaServiceImpl implements MediaService {
  final ImageCropper _cropper = ImageCropper();
  final FilePicker _filePicker = FilePicker.platform;
  final ImagePicker _picker = ImagePicker();
  final _logger = const AppLogger(MediaServiceImpl);

  /// Creates a [FileResult] from a given [File].
  FileResult _createFileResult(File file) {
    return FileResult(
      path: file.path,
      size: kIsWeb ? null : file.lengthSync() / 1024,
      fileName: file.path.split('/').last,
    );
  }

  /// Compresses an image file to reduce its size.
  ///
  /// - [file]: The input file to compress.
  /// - [quality]: Compression quality (1-100, higher is better quality).
  ///
  /// Returns the compressed file as a [FileResult].
  @override
  Future<FileResult> compressImage({
    required FileResult file,
    required int quality,
  }) async {
    try {
      final imageBytes = await File(file.path).readAsBytes();
      img.Image? image = img.decodeImage(imageBytes);

      if (image == null) throw Exception("Invalid image file");

      final compressedBytes = img.encodeJpg(image, quality: quality);
      final compressedFile =
          await File(file.path).writeAsBytes(compressedBytes);

      return file.copyWith(path: compressedFile.path);
    } catch (e) {
      _logger.e('Error compressing image: $e');
      rethrow;
    }
  }

  /// Crops an image file.
  ///
  /// - [file]: The file to crop.
  /// - [context]: (Optional) The current build context for web cropping.
  /// - [size]: (Optional) The maximum width and height of the cropped image.
  ///
  /// Returns the cropped file as a [FileResult] or `null` if canceled.
  @override
  Future<FileResult?> cropImage({
    required FileResult file,
    BuildContext? context,
    int? size,
    ({double ratioX, double ratioY})? aspectRatio,
  }) async {
    try {
      final res = await _cropper.cropImage(
        sourcePath: file.path,
        aspectRatio: aspectRatio != null
            ? CropAspectRatio(
                ratioX: aspectRatio.ratioX,
                ratioY: aspectRatio.ratioY,
              )
            : null,
        compressQuality: 100,
        maxWidth: size,
        maxHeight: size,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          IOSUiSettings(title: ''),
          AndroidUiSettings(
            toolbarTitle: 'Crop',
            toolbarColor: Colors.black,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
          ),
          if (context != null)
            WebUiSettings(
              context: context,
              size: const CropperSize(width: 400, height: 300),
            ),
        ],
      );
      return res == null ? null : file.copyWith(path: res.path);
    } catch (e) {
      _logger.e('Error cropping image: $e');
      return null;
    }
  }

  /// Downloads a file from a given URL.
  ///
  /// - [url]: The URL of the file to download.
  ///
  /// Returns the downloaded file as a [FileResult] or `null` if failed.
  @override
  Future<FileResult?> downloadFile({required String url}) async {
    try {
      final filename = url.split('/').last;
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/$filename';

      final response = await http.get(Uri.parse(url));
      if (response.statusCode != 200) {
        throw Exception('Failed to download file');
      }

      final file = File(filePath);
      await file.writeAsBytes(response.bodyBytes);

      return _createFileResult(file);
    } catch (e) {
      _logger.e('Error downloading file: $e');
      return null;
    }
  }

  /// Picks a single file from the device.
  ///
  /// - [allowedExtensions]: A list of allowed file extensions (optional).
  ///
  /// Returns the selected file as a [FileResult] or `null` if no file is picked.
  @override
  Future<FileResult?> getFile({
    List<String>? allowedExtensions,
  }) async {
    try {
      final res = await _filePicker.pickFiles(
        allowMultiple: false,
        allowedExtensions: allowedExtensions,
        type: allowedExtensions == null ? FileType.any : FileType.custom,
      );
      return res == null
          ? null
          : _createFileResult(File(res.files.single.path!));
    } catch (e) {
      _logger.e('Error picking file: $e');
      return null;
    }
  }

  /// Picks multiple files from the device.
  ///
  /// - [allowedExtensions]: A list of allowed file extensions (optional).
  ///
  /// Returns a list of selected files as [FileResult] or `null` if no files are picked.
  @override
  Future<List<FileResult>?> getFiles({
    List<String>? allowedExtensions,
  }) async {
    try {
      final res = await _filePicker.pickFiles(
        allowMultiple: true,
        allowedExtensions: allowedExtensions,
        type: allowedExtensions == null ? FileType.any : FileType.custom,
      );
      return res?.files.map((e) => _createFileResult(File(e.path!))).toList();
    } catch (e) {
      _logger.e('Error picking files: $e');
      return null;
    }
  }

  /// Picks an image from the gallery or camera.
  ///
  /// - [fromCamera]: Whether to pick the image from the camera (default: false).
  ///
  /// Returns the selected image as a [FileResult] or `null` if no image is picked.
  @override
  Future<FileResult?> getImage({bool fromCamera = false}) async {
    try {
      if (!kIsWeb) {
        // Check permissions for mobile platforms
        final permission = fromCamera ? Permission.camera : Permission.photos;
        var status = await permission.status;
        if (!status.isGranted) {
          status = await permission.request();
          if (!status.isGranted) {
            _logger
                .w('Permission denied for ${fromCamera ? "camera" : "photos"}');
            return null;
          }
        }
      }

      final res = await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      );
      return res == null ? null : _createFileResult(File(res.path));
    } catch (e) {
      _logger.e('Error picking image: $e');
      return null;
    }
  }

  /// Picks multiple images from the gallery.
  ///
  /// Returns a list of selected images as [FileResult] or `null` if no images are picked.
  @override
  Future<List<FileResult>?> getMultipleImages() async {
    try {
      if (!kIsWeb) {
        // Check photos permission for mobile platforms
        var status = await Permission.photos.status;
        if (!status.isGranted) {
          status = await Permission.photos.request();
          if (!status.isGranted) {
            _logger.w('Permission denied for photos');
            return null;
          }
        }
      }

      final res = await _picker.pickMultiImage();
      return res.map((e) => _createFileResult(File(e.path))).toList();
    } catch (e) {
      _logger.e('Error picking multiple images: $e');
      return null;
    }
  }

  /// Resizes an image to the specified [size].
  ///
  /// - [file]: The file to resize.
  /// - [size]: The target dimensions for the resized image.
  ///
  /// Returns the resized image as a [FileResult].
  @override
  Future<FileResult> resizeImage({
    required FileResult file,
    required ui.Size size,
  }) async {
    try {
      final imageBytes = await File(file.path).readAsBytes();
      img.Image? image = img.decodeImage(imageBytes);

      if (image == null) throw Exception("Invalid image file");

      final resizedImage = img.copyResize(
        image,
        width: size.width.toInt(),
        height: size.height.toInt(),
      );

      final resizedBytes = img.encodeJpg(resizedImage);
      final resizedFile = await File(file.path).writeAsBytes(resizedBytes);

      return file.copyWith(path: resizedFile.path);
    } catch (e) {
      _logger.e('Error resizing image: $e');
      rethrow;
    }
  }

  /// Saves a file to the device.
  ///
  /// - [name]: Name of the file.
  /// - [bytes]: File content as bytes.
  /// - [extension]: File extension (e.g., `jpg`, `png`).
  ///
  /// Returns the saved file as a [FileResult].
  @override
  Future<FileResult?> saveFile({
    required String name,
    required Uint8List bytes,
    File? file,
    String? filePath,
    String? fileUrl,
    String extension = '',
    String? customMimeType,
  }) async {
    try {
      // Handle Web storage separately
      if (kIsWeb) {
        return FileResult(
          path: name,
          size: bytes.length / 1024,
          fileName: name,
          data: bytes,
        );
      }

      // Ensure storage permission
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        status = await Permission.storage.request();
      }
      if (!status.isGranted) throw Exception('Storage permission denied');

      String path;
      if (Platform.isAndroid) {
        var directory = await getDownloadsDirectory();
        path = directory!.path;
      } else {
        path = (await getApplicationDocumentsDirectory()).path;
      }

      final savedFile = File(
          '$path/$name${DateTime.now().microsecondsSinceEpoch}.$extension');
      await savedFile.writeAsBytes(bytes);

      return _createFileResult(savedFile);
    } catch (e) {
      _logger.e('Error saving file: $e');
      return null;
    }
  }
}
