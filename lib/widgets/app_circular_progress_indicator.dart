import 'package:flutter/material.dart';

class AppCircularProgressIndicator extends StatefulWidget {
  const AppCircularProgressIndicator({
    super.key,
    this.size,
    this.color,
    this.margin,
  });
  final double? size;
  final Color? color;
  final EdgeInsets? margin;

  @override
  State<AppCircularProgressIndicator> createState() =>
      _AppCircularProgressIndicatorState();
}

class _AppCircularProgressIndicatorState
    extends State<AppCircularProgressIndicator> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return widget.size == null
        ? Center(
            child: Container(
              margin: widget.margin,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: widget.color ?? Colors.white,
              ),
            ),
          )
        : Center(
            child: Container(
              width: widget.size,
              height: widget.size,
              margin: widget.margin,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: widget.color ?? Colors.white,
              ),
            ),
          );
  }
}
