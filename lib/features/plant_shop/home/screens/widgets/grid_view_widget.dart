import 'package:flutter/material.dart';

class GridViewWidget extends StatelessWidget {
  final int? itemCount;
  final int crossAxisCount;
  final Widget? Function(BuildContext, int) itemBuilder;

  const GridViewWidget({
    super.key,
    this.itemCount,
    required this.crossAxisCount,
    required this.itemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        childAspectRatio: 0.56,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
