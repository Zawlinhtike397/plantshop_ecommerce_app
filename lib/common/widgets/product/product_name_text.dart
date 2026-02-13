import 'package:flutter/material.dart';

class ProductText extends StatelessWidget {
  final String name;
  final TextOverflow overflow;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  final double? fontSize;

  const ProductText({
    super.key,
    required this.name,
    required this.overflow,
    this.fontWeight,
    this.letterSpacing,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    );
  }
}
