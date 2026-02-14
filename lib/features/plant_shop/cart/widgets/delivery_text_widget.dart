import 'package:flutter/material.dart';

class DeliveryTextWidget extends StatelessWidget {
  const DeliveryTextWidget({super.key});

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
          '10000 MMK',
          style: Theme.of(
            context,
          ).textTheme.bodySmall!.copyWith(fontSize: 14.0),
        ),
      ],
    );
  }
}
