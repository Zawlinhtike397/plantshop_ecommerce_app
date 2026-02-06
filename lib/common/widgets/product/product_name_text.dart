import 'package:flutter/material.dart';

class ProductNameText extends StatelessWidget {
  final String name;
  final TextOverflow overflow;
  final FontWeight? fontWeight;
  final double? letterSpacing;
  const ProductNameText({
    super.key,
    required this.name,
    required this.overflow,
    this.fontWeight,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
        letterSpacing: letterSpacing,
        fontWeight: fontWeight,
      ),
    );
  }
}
