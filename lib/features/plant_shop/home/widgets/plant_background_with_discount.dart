import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/container/circular_container.dart';
import 'package:plantify_plantshop_project/common/widgets/product/discount_tag.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class PlantBackgroundWithDiscount extends StatelessWidget {
  final Map<String, Object> plantData;
  const PlantBackgroundWithDiscount({super.key, required this.plantData});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final List<String> images = plantData['imageUrl'] as List<String>;
    return Stack(
      children: [
        CircularContainer(
          color: isDarkMode
              ? Color.fromARGB(255, 51, 50, 50)
              : AppColor.lightGray,
          child: Image.asset(
            images[0],
            width: double.infinity,
            // fit: BoxFit.contain,
          ),
        ),
        DiscountTag(percentage: '30%'),
      ],
    );
  }
}
