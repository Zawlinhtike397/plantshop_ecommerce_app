import 'package:flutter/material.dart';

class VerticalTotalPriceText extends StatelessWidget {
  const VerticalTotalPriceText({super.key, required this.plantData});

  final Map<String, Object> plantData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Price',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.white, fontSize: 16),
        ),
        Text(
          '${plantData['price']} MMK',
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
