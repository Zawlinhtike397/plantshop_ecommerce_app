import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/features/plant_shop/plant_details/widget/add_to_cart_button.dart';
import 'package:plantify_plantshop_project/features/plant_shop/plant_details/widget/plant_info_with_icons.dart';
import 'package:plantify_plantshop_project/features/plant_shop/plant_details/widget/vertical_total_price_text.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class PlantInfoBottomSheet extends StatelessWidget {
  final Map<String, Object> plantData;
  const PlantInfoBottomSheet({super.key, required this.plantData});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColor.darkTeal,
        // AppColor.primary,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          PlantInfoWithIcons(plantData: plantData),

          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.fromLTRB(50.0, 0, 35.0, 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                VerticalTotalPriceText(plantData: plantData),
                AddToCartButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
