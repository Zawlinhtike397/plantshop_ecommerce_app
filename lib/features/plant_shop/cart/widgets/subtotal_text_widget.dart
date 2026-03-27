import 'package:flutter/material.dart';

class SubTotalTextWidget extends StatelessWidget {
  final double subtotal;
  const SubTotalTextWidget({super.key, required this.subtotal});

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
          '${subtotal.toStringAsFixed(0)} MMK',
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(fontSize: 14.0),
        ),
      ],
    );
  }
}
