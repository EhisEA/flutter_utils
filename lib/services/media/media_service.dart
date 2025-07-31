import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import '../../models/models.dart';

abstract class MediaService {
  Future<FileResult?> getImage({bool fromCamera = false});

  Future<FileResult?> getFile({
    List<String>? allowedExtensions,
  });

  Future<List<FileResult>?> getFiles({
    List<String>? allowedExtensions,
  });

  Future<FileResult?> saveFile({
    required String name,
    required Uint8List bytes,
    File? file,
    String? filePath,
    String? fileUrl,
    String extension = '',
    String? customMimeType,
  });

  Future<List<FileResult>?> getMultipleImages();

  Future<FileResult?> cropImage({
    required FileResult file,
    int? size,
    ({double ratioX, double ratioY})? aspectRatio,
  });

  Future<FileResult> resizeImage({
    required FileResult file,
    required Size size,
  });

  Future<FileResult> compressImage({
    required FileResult file,
    required int quality,
  });

  Future<FileResult?> downloadFile({required String url});
}
