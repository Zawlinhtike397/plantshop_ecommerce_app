import 'package:flutter/material.dart';

class ProductTitle extends StatelessWidget {
  final String name;
  const ProductTitle({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return Text(
      name,
      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontSize: 20.0),
    );
  }
}
