import 'package:flutter/material.dart';
import 'package:plantify_plantshop_project/common/widgets/product/product_price_text.dart';
import 'package:plantify_plantshop_project/features/plant_shop/cart/widgets/plant_quantity_plus_minus_btn.dart';
import 'package:plantify_plantshop_project/utils/constants/colors.dart';
import 'package:plantify_plantshop_project/utils/constants/image_strings.dart';

class PlantCartItem extends StatelessWidget {
  const PlantCartItem({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: MediaQuery.of(context).size.width * 0.31,
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Stack(
        children: [
          Card(
            elevation: 0.2,
            color: isDarkMode ? AppColor.darkerGrey : Colors.white,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0)),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
              child: Row(
                children: [
                  Image.asset(ImageStrings.plant1, fit: BoxFit.fitWidth),
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              spacing: 20.0,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Snake Plants',
                                  // cart[index]['name'],
                                  style: Theme.of(context).textTheme.bodyMedium!
                                      .copyWith(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                                AppProductPriceText(
                                  price: '30000',
                                  isLarge: false,
                                ),
                              ],
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              spacing: 6.0,
                              children: [
                                SizedBox(height: 11),
                                AppProductPriceText(
                                  price: '60000',
                                  isLarge: false,
                                ),

                                PlantQuantityPlusMinusBtn(
                                  isDarkMode: isDarkMode,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
            ),
          ),
          Positioned(
            top: -1,
            right: 4,
            child: IconButton(
              onPressed: () {
                // cartProvider.removeCartData(cart[index]);
              },
              icon: Icon(
                Icons.close,
                color: isDarkMode ? Colors.white : AppColor.darkerGrey,
                size: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
