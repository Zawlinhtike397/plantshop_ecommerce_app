import 'package:flutter/material.dart';

class UnorderedListItem extends StatelessWidget {
  final String text;
  const UnorderedListItem({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("• "),
        Expanded(child: Text(text)),
      ],
    );
  }
}
