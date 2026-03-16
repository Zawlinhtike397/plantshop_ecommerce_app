import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class PlantCardShimmer extends StatelessWidget {
  const PlantCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDarkMode ? Colors.grey[900] : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(height: 120, width: double.infinity, color: Colors.grey),
            const SizedBox(height: 8),
            Container(height: 16, width: 80, color: Colors.grey),
            const SizedBox(height: 6),
            Container(height: 16, width: 40, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
