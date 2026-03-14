import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

class ZShimmerEffect extends StatelessWidget {
  const ZShimmerEffect({
    super.key,
    required this.width,
    required this.height,
    this.color,
    this.radius = 15,
  });
  final double width, height;
  final Color? color;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.brightnessOf(context) == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[850]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? (isDark ? AppColor.darkerGrey : AppColor.white),
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
