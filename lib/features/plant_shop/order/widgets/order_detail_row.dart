import 'package:flutter/material.dart';

class OrderDetailRow extends StatelessWidget {
  final String left, right;
  final bool bold;

  const OrderDetailRow({
    super.key,
    required this.left,
    required this.right,
    this.bold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(left),
          Text(
            right,
            style: TextStyle(fontWeight: bold ? FontWeight.bold : null),
          ),
        ],
      ),
    );
  }
}
