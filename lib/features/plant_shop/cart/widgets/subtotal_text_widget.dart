import 'package:flutter/material.dart';

class SubTotalTextWidget extends StatelessWidget {
  const SubTotalTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Subtotal',
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontSize: 14.0),
        ),
        Text(
          '90000 MMK',
          // '\$${subTotal.toStringAsFixed(2)}',
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(fontSize: 14.0),
        ),
      ],
    );
  }
}
