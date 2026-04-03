import 'package:flutter/material.dart';

class OrderDetailTimeline extends StatelessWidget {
  final String text;
  final bool active;

  const OrderDetailTimeline({
    super.key,
    required this.text,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 12,
          color: active ? Colors.green : Colors.grey,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}
