import 'package:flutter/material.dart';

class SplashScreenCircleBackground extends StatelessWidget {
  const new({this.top, this.bottom, this.right, this.left, this.size = 0, this.color, super.key});
  final double? top;
  final double? bottom;
  final double? right;
  final double? left;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      bottom: bottom,
      left: left,
      right: right,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(shape: .circle, color: color),
      ),
    );
  }
}
