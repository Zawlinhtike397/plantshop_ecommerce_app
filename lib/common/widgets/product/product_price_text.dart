import 'package:flutter/material.dart';

class AppProductPriceText extends StatelessWidget {
  const AppProductPriceText({
    super.key,
    this.currencySign = 'MMK',
    required this.price,
    this.maxLines = 1,
    this.overflow = TextOverflow.ellipsis,
    this.isLarge = true,
    this.lineThrough = false,
  });

  final String currencySign, price;
  final int? maxLines;
  final bool isLarge;
  final bool lineThrough;
  final TextOverflow? overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      price + currencySign,
      maxLines: maxLines,
      overflow: overflow,
      style: isLarge
          ? Theme.of(context).textTheme.titleLarge!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null,
            )
          : Theme.of(context).textTheme.bodySmall!.apply(
              decoration: lineThrough ? TextDecoration.lineThrough : null,
            ),
    );
  }
}
