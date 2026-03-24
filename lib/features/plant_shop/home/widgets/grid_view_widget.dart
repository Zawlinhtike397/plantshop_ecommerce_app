import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  final int itemCount, crossAxisCount;
  final Widget Function(BuildContext, int) itemBuilder;

  const GridViewWidget({
    super.key,
    required this.crossAxisCount,
    required this.itemCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
      delegate: SliverChildBuilderDelegate(itemBuilder, childCount: itemCount),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 10,
        childAspectRatio: 0.56,
      ),
    );
  }
}
