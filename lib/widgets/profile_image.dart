import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    super.key,
    this.imageUrl,
    this.width = 50,
    this.height = 50,
    this.autoGenerateName,
    this.borderRadius = 50,
  });
  const ProfileImage.singleDimension({
    super.key,
    this.autoGenerateName,
    this.imageUrl,
    double dimension = 50,
  })  : width = dimension,
        height = dimension,
        borderRadius = dimension;

  final String? imageUrl;
  final double width;
  final double height;
  final double borderRadius;

  /// Generate imagewith user name
  final String? autoGenerateName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: const Color(0XFFC7EBFC),
        borderRadius: BorderRadius.circular(borderRadius),
        // border: Border.all(width: 4, color: Colors.white),
      ),
      child: !(imageUrl?.startsWith("http") ?? false)
          ? autoGenerateName != null
              ? CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://ui-avatars.com/api/?name=$autoGenerateName&background=0D8ABC&color=fff",
                  placeholder: (context, url) => placeHolder(),
                )
              : Center(
                  child: Row(
                    children: [
                      Icon(
                        Icons.person,
                        size: height / 2,
                        color: Colors.white,
                      ),
                      // Text(
                      //   "$imageUrl",
                      //   style: const TextStyle(
                      //     color: Colors.red,
                      //   ),
                      // )
                    ],
                  ),
                )
          : CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl: imageUrl!,
              placeholder: (context, url) => placeHolder(),
            ),
    );
  }

  Shimmer placeHolder() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: Colors.grey.shade200,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        height: height,
        width: width,
      ),
    );
  }
}
