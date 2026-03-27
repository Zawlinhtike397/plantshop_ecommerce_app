import 'package:flutter/material.dart';

class DeliveryTextWidget extends StatelessWidget {
  final double deliveryFee;
  const DeliveryTextWidget({super.key, required this.deliveryFee});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Delivery',
          style: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(fontSize: 14.0),
        ),
        Text(
          '${deliveryFee.toStringAsFixed(0)} MMK',
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(fontSize: 14.0),
        ),
      ],
    );
  }
}
