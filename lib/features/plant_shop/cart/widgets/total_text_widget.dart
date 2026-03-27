import 'package:flutter/material.dart';

class TotalTextWidget extends StatelessWidget {
  final double total;
  const TotalTextWidget({super.key, required this.total});

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
            '${total.toStringAsFixed(0)} MMK',
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
