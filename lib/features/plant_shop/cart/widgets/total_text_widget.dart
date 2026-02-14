import 'package:flutter/material.dart';

class TotalTextWidget extends StatelessWidget {
  const TotalTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, bottom: 12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            '100000MMK',
            // '\$${total.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleSmall!.copyWith(
              fontSize: 15.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
