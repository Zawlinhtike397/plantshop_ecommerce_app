import 'package:flutter/material.dart';

class CircularContainer extends StatelessWidget {
  final Color color;
  final double? width, height;
  final double radius;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final double padding;

  const CircularContainer({
    super.key,
    required this.color,
    this.width,
    this.height,
    this.radius = 16.0,
    this.margin,
    this.child,
    this.padding = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}
