import 'package:flutter/material.dart';

class DiscountTextWidget extends StatelessWidget {
  final double discountAmount;

  const DiscountTextWidget({super.key, required this.discountAmount});

  @override
  Widget build(BuildContext context) {
    if (discountAmount == 0) {
      return const SizedBox.shrink();
    }
    // hide if no discount

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Discount',
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontSize: 14.0, color: Colors.green),
        ),
        Text(
          '${discountAmount.toStringAsFixed(0)} MMK',
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(fontSize: 14.0, color: Colors.green),
        ),
      ],
    );
  }
}
