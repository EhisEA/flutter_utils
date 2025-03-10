import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Utility class for preloading both raster and vector images
/// to prevent jank during first render.
class AssetPreloader {
  /// Preloads a raster image asset and returns the loaded Image widget.
  ///
  /// [context] - BuildContext for image precaching.
  /// [path] - Asset path to the image file.
  ///
  /// Throws an exception if the image cannot be loaded.
  static Future<Image> loadImg(BuildContext context, String path) async {
    try {
      final image = Image.asset(path);
      await precacheImage(image.image, context);
      return image;
    } catch (e) {
      throw Exception('Failed to load image: $e');
    }
  }

  /// Preloads an SVG asset into the SVG cache.
  ///
  /// [svgPath] - Asset path to the SVG file.
  ///
  /// Throws an exception if the SVG cannot be loaded.
  static Future<void> precacheSvgPicture(String svgPath) async {
    try {
      final svgLoader = SvgAssetLoader(svgPath);
      await svg.cache.putIfAbsent(
        svgLoader.cacheKey(null),
        () => svgLoader.loadBytes(null),
      );
    } catch (e) {
      throw Exception('Failed to precache SVG: $e');
    }
  }

  /// Clears the SVG cache to free up memory.
  static void clearSvgCache() {
    svg.cache.clear();
  }
}
