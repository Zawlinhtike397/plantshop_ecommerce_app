import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/plant_info/plant_model.dart';
import 'package:plantify_plantshop_project/common/widgets/product/product_price_text.dart';

class VerticalTotalPriceText extends StatelessWidget {
  const VerticalTotalPriceText({super.key, required this.plantData});

  final PlantModel plantData;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total Price',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Colors.white, fontSize: 16),
        ),
        AppProductPriceText(
          price: '${plantData.originalPrice}',
          isAlwaysWhite: true,
        ),
      ],
    );
  }
}
