import 'package:flutter/material.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.borderRadius,
  });

  final String imageUrl;
  final double? width;
  final double? height;
  final double? borderRadius;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: borderRadius == null ? null : BorderRadius.circular(borderRadius!),
      ),
      // child: Cac(
      //   url: imageUrl,
      //   fit: BoxFit.cover,
      //   fadeInDuration: const Duration(seconds: 1),
      //   // errorBuilder: (context, exception, stacktrace) {
      //   //   return Text(stacktrace.toString());
      //   // },
      //   loadingBuilder: (context, progress) {
      //     return Skeleton(
      //       radius: borderRadius,
      //       width: width,
      //       height: height,
      //     );
      //   },
      // ),
    );
  }
}
