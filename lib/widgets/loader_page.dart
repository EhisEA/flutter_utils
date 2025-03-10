import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// A widget that displays a loading indicator with optional child content. The
/// `Loader` widget can be used to provide feedback to the user that some content
/// is being loaded in the background. The `isLoading` property can be used to
/// toggle the visibility of the loading indicator, while the `child` property
/// can be used to display content on top of the loading indicator.

class Loader extends StatelessWidget {
  const Loader({this.radius, this.color = Colors.green, super.key})
      : child = null,
        isLoading = true;

  const Loader.page({
    required this.child,
    this.isLoading = false,
    this.radius,
    this.color = Colors.green,
    super.key,
  }) : assert(child != null, " An value must be passed for child");

  final double? radius;
  final Color color;
  final bool isLoading;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    if (child != null) {
      return SizedBox.expand(
        child: Stack(
          children: [
            child!,
            if (isLoading) ...[
              Container(
                color: Colors.black.withOpacity(0.3),
              ),
              const Center(
                child: CircularProgressIndicator.adaptive(),
              ),
            ],
          ],
        ),
      );
    }

    return SizedBox(
      width: radius ?? 35,
      height: radius ?? 35,
      child: Platform.isAndroid
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(color),
            )
          : CupertinoActivityIndicator(
              radius: radius ?? 20,
            ),
    );
  }
}
