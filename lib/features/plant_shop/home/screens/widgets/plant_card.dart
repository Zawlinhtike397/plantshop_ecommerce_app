import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/product/category_tag.dart';
import 'package:plantify_plantshop_project/common/widgets/product/favorite_icon.dart';
import 'package:plantify_plantshop_project/common/widgets/product/product_name_text.dart';
import 'package:plantify_plantshop_project/common/widgets/product/product_price_text.dart';
import 'package:plantify_plantshop_project/features/plant_shop/home/screens/widgets/plant_background_with_discount.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';

class PlantCard extends StatelessWidget {
  const PlantCard({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? AppColor.darkerGrey : AppColor.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        spacing: 16.0,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlantBackgroundWithDiscount(),

          Column(
            spacing: 7.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProductNameText(
                name: 'Lucky Jade Plant',
                overflow: TextOverflow.ellipsis,
                letterSpacing: 0.0,
                fontWeight: FontWeight.w600,
              ),

              CategoryTag(),
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppProductPriceText(price: '12.99'),

              FavouriteIcon(markedAsFavourite: true),
            ],
          ),
        ],
      ),
    );
  }
}
