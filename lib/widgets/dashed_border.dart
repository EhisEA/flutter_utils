import 'dart:ui';

import 'package:flutter/material.dart';

class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final BorderRadius borderRadius;

  DashedBorderPainter({
    required this.color,
    this.strokeWidth = 2.0,
    this.dashWidth = 5.0,
    this.dashSpace = 3.0,
    this.borderRadius = BorderRadius.zero,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final path = Path()..addRRect(borderRadius.toRRect(rect));
    final dashedPath = _createDashedPath(path);

    canvas.drawPath(dashedPath, paint);
  }

  Path _createDashedPath(Path source) {
    final Path dashedPath = Path();
    final PathMetrics pathMetrics = source.computeMetrics();

    for (final pathMetric in pathMetrics) {
      double distance = 0.0;
      while (distance < pathMetric.length) {
        final double nextDistance = distance + dashWidth;
        const bool isDash = true;

        if (isDash) {
          dashedPath.addPath(
            pathMetric.extractPath(
              distance,
              nextDistance.clamp(0, pathMetric.length),
            ),
            Offset.zero,
          );
        }
        distance = nextDistance + dashSpace;
      }
    }
    return dashedPath;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class DashedBorderWidget extends StatelessWidget {
  final Widget child;
  final Color borderColor;
  final BorderRadius borderRadius;
  final double? dashSpace;
  final double? dashWidth;

  const DashedBorderWidget({
    super.key,
    required this.child,
    this.borderColor = Colors.black,
    this.borderRadius = BorderRadius.zero,
    this.dashSpace,
    this.dashWidth,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: DashedBorderPainter(
          color: borderColor,
          borderRadius: borderRadius,
          dashSpace: dashSpace ?? 8,
          dashWidth: dashWidth ?? 9,
          strokeWidth: .99),
      child: child,
    );
  }
}
