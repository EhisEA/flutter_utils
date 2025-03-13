import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ShakeWidget extends StatefulWidget {
  final Widget child;
  final double horizontalPadding;
  final double animationRange;
  final ShakeWidgetController controller;
  final Duration animationDuration;

  const ShakeWidget(
      {super.key,
      required this.child,
      required this.controller,
      this.horizontalPadding = 20,
      this.animationRange = 16,
      this.animationDuration = const Duration(milliseconds: 800)});

  @override
  State<ShakeWidget> createState() => ShakeXState();
}

class ShakeXState extends State<ShakeWidget> with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  int shakeCount = 0;
  int maxShakeCount = 5;

  @override
  void initState() {
    animationController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );

    widget.controller.setState(this);

    super.initState();
  }

  void startShake() {
    shakeCount = 0;
    _shake();
  }

  void _shake() {
    if (shakeCount < maxShakeCount) {
      shakeCount++;
      animationController.forward(from: 0.0).whenComplete(() {
        animationController.reverse().whenComplete(_shake);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Animation<double> offsetAnimation = Tween(begin: 0.0, end: widget.animationRange)
        .chain(CurveTween(curve: Curves.elasticIn))
        .animate(animationController)
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            animationController.reverse();
          }
        },
      );

    return AnimatedBuilder(
      animation: offsetAnimation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(offsetAnimation.value, 0.0),
          child: widget.child,
        );
      },
    );
  }
}

class ShakeWidgetController {
  late ShakeXState _state;

  void setState(ShakeXState state) {
    _state = state;
  }

  Future<void> shake() {
    HapticFeedback.mediumImpact();
    return _state.animationController.forward(from: 0.0);
  }
}
