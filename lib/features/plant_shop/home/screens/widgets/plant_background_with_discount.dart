import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/container/circular_container.dart';
import 'package:plantify_plantshop_project/common/widgets/product/discount_tag.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class PlantBackgroundWithDiscount extends StatelessWidget {
  const PlantBackgroundWithDiscount({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Stack(
      children: [
        CircularContainer(
          color: isDarkMode
              ? Color.fromARGB(255, 51, 50, 50)
              : AppColor.lightGray,
          child: Image.asset(
            ImageStrings.plant1Test,
            width: double.infinity,
            // fit: BoxFit.contain,
          ),
        ),
        DiscountTag(percentage: '30%'),
      ],
    );
  }
}
