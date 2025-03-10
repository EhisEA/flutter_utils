import 'package:flutter/material.dart';

class AppRectangle extends StatelessWidget {
  const AppRectangle({
    super.key,
    this.color,
    this.radius,
    this.child,
    this.margin,
    this.padding,
    this.height,
    this.borderColor,
    this.borderWidth,
    this.width,
    this.alignment,
    this.shadow,
    this.shape,
    this.constraints,
    this.borderStrokeAlign,
    this.gradient,
    this.image,
  });
  final Color? color, borderColor;
  final double? radius;
  final double? height, width, borderWidth, borderStrokeAlign;
  final Widget? child;
  final AlignmentGeometry? alignment;
  final EdgeInsets? margin, padding;
  final BoxShadow? shadow;
  final BoxShape? shape;
  final BoxConstraints? constraints;
  final Gradient? gradient;
  final DecorationImage? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      constraints: constraints,
      decoration: BoxDecoration(
        boxShadow: shadow == null ? null : [shadow!],
        borderRadius:
            radius == null ? null : BorderRadius.circular(radius ?? 0),
        border: borderColor != null
            ? Border.all(
                color: borderColor!,
                width: borderWidth ?? 1,
                strokeAlign: borderStrokeAlign ?? BorderSide.strokeAlignInside,
              )
            : null,
        shape: shape ?? BoxShape.rectangle,
        color: color,
        gradient: gradient,
        image: image,
      ),
      child: child,
    );
  }
}
