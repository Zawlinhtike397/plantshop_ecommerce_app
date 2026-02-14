import 'package:flutter/material.dart';

class HeadingWidget extends StatelessWidget {
  final String name;
  const HeadingWidget({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 18.0),
    );
  }
}
